<?php

class Admin_LanController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelLanJeux;
    protected $_modelLanJoueur;
    protected $_modelLanJeuxJoueurTeam;
    protected $_modelCompte;
    protected $_modelConfig;

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $log->_setInterface_admin(true);
            return $this->_helper->redirector('indexadmin');
        } else {
            $smarty->assign('message', 'Erreur Connexion');
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function indexadminAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $model = $this->_getModel();
            $datas = $model->fetchEntriesorderByDate();
            $request = $this->getRequest();

            foreach ($datas as $lan) {
                $chiffre[$lan['idLan']][0]['insc'] = $model->fetchEntriesCount($lan['idLan']);
                $chiffre[$lan['idLan']][0]['valide'] = $model->fetchEntriesCountValide($lan['idLan']);
                $chiffre[$lan['idLan']][0]['teams'] = $model->fetchEntriesCountTeam($lan['idLan']);
                $chiffre[$lan['idLan']][0]['jeux'] = $model->fetchEntriesCountJeux($lan['idLan']);
            }


            $smarty->assign('baseurl', $request->getBaseUrl());
            $smarty->assign('total', $model->countEntries());
            $smarty->assign('chiffre', $chiffre);
            $smarty->assign('title', 'Lan');
            $smarty->assign('urladd', 'form/');
            $smarty->assign('urlupd', 'form/?id=');
            $smarty->assign('urldel', 'del/?id=');

            $smarty->assign('urlinscrits', $request->getBaseUrl() . '/lanjeuxjoueurteam/viewinscrits?idLan=');
            $smarty->assign('urlteams', $request->getBaseUrl() . '/lanjeuxjoueurteam/viewteams?idLan=');
            $smarty->assign('urljeux', $request->getBaseUrl() . '/lanjeux/indexadmin?idLan=');
            $smarty->assign('urldescription', $request->getBaseUrl() . '/lan/description?idLan=');

            $smarty->assign('datas', $datas);
            $smarty->display('lan/indexAdmin.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function descriptionAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $model = $this->_getModel();
            $modelLanJeux = $this->_getModelLanJeux();
            $request = $this->getRequest();
            $id = (int) $request->getParam('idLan', 0);
            $lan = $model->fetchEntry($id);

            $chiffre['insc'] = $model->fetchEntriesCount($lan['idLan']);
            $chiffre['present'] = $model->fetchEntriesCountPresent($lan['idLan']);
            $jeux = $modelLanJeux->fetchEntriesByLan($lan['idLan']);

            $smarty->assign('lan', $lan);
            $smarty->assign('chiffre', $chiffre);
            $smarty->assign('jeux', $jeux);
            $smarty->assign('titre', 'Lan ' . $lan['nom']);
            $smarty->display('lan/description.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function formAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            $form = $this->_getLanForm($id);
            $model = $this->_getModel();

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();
                    $datedeb = $dataform['datedeb'];
                    $dataform['datedeb'] = substr($datedeb, 6, 4) . "-" . substr($datedeb, 3, 2) . "-" . substr($datedeb, 0, 2) . " " . $dataform['heuredeb'] . ":" . $data['minutedeb'] . ":00";
                    $datefin = $dataform['datefin'];
                    $dataform['datefin'] = substr($datefin, 6, 4) . "-" . substr($datefin, 3, 2) . "-" . substr($datefin, 0, 2) . " " . $dataform['heurefin'] . ":" . $data['minutefin'] . ":00";

                    if ($dataform['inscription'] == 1) {
                        $d = new Zend_Date();
                        $dataform['date_inscription'] = $d->toString('YYYY-MM-dd');
                    }

                    $dataform['nom'] = utf8_decode($dataform['nom']);
                    $dataform['adresse'] = utf8_decode($dataform['adresse']);

                    $model->save($id, $dataform);
                    return $this->_helper->redirector('indexadmin');
                }
            } else {
                if ($id > 0) {
                    $data = $model->fetchEntry($id);
                    $date = new Zend_Date($data['datedeb']);
                    $data['datedeb'] = $date->toString('dd/MM/Y');
                    $data['heuredeb'] = $date->toString('H');
                    $data['minutedeb'] = $date->toString('mm');
                    $datef = new Zend_Date($data['datefin']);
                    $data['datefin'] = $datef->toString('dd/MM/Y');
                    $data['heurefin'] = $datef->toString('H');
                    $data['minutefin'] = $datef->toString('mm');
                    $data['nom'] = utf8_encode($data['nom']);
                    $data['adresse'] = utf8_encode($data['adresse']);
                    $form->populate($data);
                }
            }

            if ($id > 0)
                $smarty->assign('title', 'Modification Lan');
            else
                $smarty->assign('title', 'Ajout Lan');

            $smarty->assign('form', $form);
            $smarty->display('lan/form.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function delAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            if ($id > 0) {
                $model = $this->_getModel();
                $model->delete($id);
            }
            return $this->_helper->redirector('indexadmin');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lan.php';
            $this->_model = new Model_Lan();
        }
        return $this->_model;
    }

    protected function _getModelLanJoueur() {
        if (null === $this->_modelLanJoueur) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJoueur.php';
            $this->_modelLanJoueur = new Model_LanJoueur();
        }
        return $this->_modelLanJoueur;
    }

    protected function _getModelLanJeux() {
        if (null === $this->_modelLanJeux) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJeux.php';
            $this->_modelLanJeux = new Model_LanJeux();
        }
        return $this->_modelLanJeux;
    }

    protected function _getModelCompte() {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }

    protected function _getModelConfig() {
        if (null === $this->_modelConfig) {
            require_once APPLICATION_PATH_COMMONS . '/models/Config.php';
            $this->_modelConfig = new Model_Config();
        }
        return $this->_modelConfig;
    }

    protected function _getModelLanJeuxJoueurTeam() {
        if (null === $this->_modelLanJeuxJoueurTeam) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJeuxJoueurTeam.php';
            $this->_modelLanJeuxJoueurTeam = new Model_LanJeuxJoueurTeam();
        }
        return $this->_modelLanJeuxJoueurTeam;
    }

    protected function _getLanForm($id) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Lan.php';
        $form = new Form_Lan();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?id=' . $id));
        else
            $form->setAction($this->_helper->url('form'));
        return $form;
    }

}
