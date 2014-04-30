<?php

class Admin_LanJeuxJoueurTeamController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelLan;
    protected $_modelJeux;
    protected $_modelLanJeux;
    protected $_modelLanJoueur;

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('indexadmin');
        }

        throw new Exception('Invalid method');
    }

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
            $modelLan = $this->_getModelLan();
            $request = $this->getRequest();
            $idLan = (int) $request->getParam('idLan', 0);

            $datas = $model->fetchEntriesByLan($idLan);
            $lan = $modelLan->fetchEntry($idLan);

            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('total', $model->countEntries());
            $smarty->assign('title', 'Jeux de la Lan ' . $lan['nom']);
            $smarty->assign('urladd', $request->getBaseUrl() . '/lanjeux/form/?idLan=' . $idLan);
            $smarty->assign('urlupd', $request->getBaseUrl() . '/lanjeux/form/?idLan=' . $idLan . '&id=');
            $smarty->assign('urldel', $request->getBaseUrl() . '/lanjeux/del/?idLan=' . $idLan . '&id=');
            $smarty->assign('datas', $datas);

            $smarty->display('lanjeux/indexAdmin.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function viewinscritsAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $model = $this->_getModel();
            $modelLan = $this->_getModelLan();
            $modelLanJoueur = $this->_getModelLanJoueur();
            $request = $this->getRequest();
            $idLan = (int) $request->getParam('idLan', 0);

            $datas = $modelLanJoueur->fetchEntriesByLanField($idLan, array('idCompte', 'login', 'nom', 'prenom', 'dateins'));
            $lan = $modelLan->fetchEntry($idLan);

            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('total', $model->countEntries());
            $smarty->assign('title', 'Inscrits de la Lan ' . $lan['nom']);
            $smarty->assign('urlupd', $request->getBaseUrl() . '/lanjeuxjoueurteam/form/?idLan=' . $idLan . '&id=');
            $smarty->assign('urldel', $request->getBaseUrl() . '/lanjeuxjoueurteam/del/?idLan=' . $idLan . '&id=');
            $smarty->assign('datas', $datas);

            $smarty->display('lanjeuxjoueurteam/viewinscrits.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function viewteamsAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $model = $this->_getModel();
            $modelLan = $this->_getModelLan();
            $modelLanJeux = $this->_getModelLanJeux();
            $request = $this->getRequest();
            $idLan = (int) $request->getParam('idLan', 0);

            $datas = $model->fetchEntriesByLan_Teams($idLan);
            $jeux = $modelLanJeux->fetchEntriesByLan($idLan);
            $lan = $modelLan->fetchEntry($idLan);

            $teams = null;
            $compte = null;

            foreach ($jeux as $j) {
                $teams[$j['idJeux']] = $model->fetchEntriesByLanAndJeux($idLan, $j['idJeux']);

                foreach ($teams[$j['idJeux']] as $t) {
                    $compte[$j['idJeux']][$t['idTeam']] = $model->fetchEntriesByLanAndJeuxAndTeam($idLan, $j['idJeux'], $t['idTeam']);
                }
            }


            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('teams', $teams);
            $smarty->assign('jeux', $jeux);
            $smarty->assign('compte', $compte);
            $smarty->assign('total', $model->countEntries());
            $smarty->assign('title', 'Inscrits de la Lan ' . $lan['nom']);
            $smarty->assign('urldelteam', $request->getBaseUrl() . '/lanjeuxjoueurteam/delteam/?idLan=' . $idLan . '&id=');
            $smarty->assign('urlupd', $request->getBaseUrl() . '/lanjeuxjoueurteam/form/?idLan=' . $idLan . '&id=');
            $smarty->assign('urldel', $request->getBaseUrl() . '/lanjeuxjoueurteam/del/?idLan=' . $idLan . '&id=');
            $smarty->assign('datas', $datas);

            $smarty->display('lanjeuxjoueurteam/viewteams.tpl');
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
            $idLan = (int) $request->getParam('idLan', 0);
            $form = $this->_getLanJeuxJoueurTeamForm($id, $idLan);
            $model = $this->_getModel();
            $modelLan = $this->_getModelLan();
            $modelJeux = $this->_getModelJeux();
            $modelLanJoueur = $this->_getModelLanJoueur();

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();
                    $dataform['idLanJoueur'] = $id;
                    if ($dataform['validation'] == 0) {
                        $dataform['paiement'] = 0;
                    }
                    $modelLanJoueur->save($id, $dataform);
                    return $this->_helper->redirector('viewinscrits', 'lanjeuxjoueurteam', '', array('idLan' => $idLan));
                }
            } else {
                if ($id > 0) {
                    $data = $modelLanJoueur->fetchEntry($id);
                    $form->populate($data);
                }
            }

            $smarty->assign('title', 'Modification Inscription');

            $smarty->assign('form', $form);
            $smarty->display('lanjeux/form.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function delAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            $idLan = (int) $request->getParam('idLan', 0);
            if ($id > 0) {
                $model = $this->_getModel();
                $modelLanJoueur = $this->_getModelLanJoueur();
                $modelLanJoueur->delete($id);
                $model->deleteByLanJoueur($id);
            }
            return $this->_helper->redirector('viewinscrits', 'lanjeuxjoueurteam', '', array('idLan' => $idLan));
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function delteamAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $idTeam = (int) $request->getParam('id', 0);
            $idJeux = (int) $request->getParam('idJeux', 0);
            $idLan = (int) $request->getParam('idLan', 0);
            if ($id > 0) {
                $model = $this->_getModel();
                $model->deleteByTeamAndJeu($idTeam, $idJeux);
            }
            return $this->_helper->redirector('viewteams', 'lanjeuxjoueurteam', '', array('idLan' => $idLan));
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function activationjoueurAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $model = $this->_getModel();
            $modelLanJoueur = $this->_getModelLanJoueur();
            $modelLan = $this->_getModelLan();
            $id = (int) $request->getParam('idLanJoueur', 0);
            $idLan = (int) $request->getParam('idLan', 0);
            $change = (string) $request->getParam('change');
            $data = $modelLanJoueur->fetchEntry($id);
            $lan = $modelLan->fetchEntry($idLan);

            if ($change == "a") {
                $data['validation'] = 1;
                $data['paiement'] = $lan['prix_prepaiement'];
            } else {
                $data['validation'] = 0;
                $data['paiement'] = 0;
            }

            $modelLanJoueur->save($data['idLanJoueur'], $data);

            $smarty = Zend_Registry::get('view');

            $datas = $modelLanJoueur->fetchEntriesByLanField($idLan, array('idCompte', 'login', 'nom', 'prenom', 'dateins'));
            $lan = $modelLan->fetchEntry($idLan);

            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('total', $model->countEntries());
            $smarty->assign('title', 'Inscrits de la Lan ' . $lan['nom']);
            $smarty->assign('urlupd', $request->getBaseUrl() . '/lanjeuxjoueurteam/form/?idLan=' . $idLan . '&id=');
            $smarty->assign('urldel', $request->getBaseUrl() . '/lanjeuxjoueurteam/del/?idLan=' . $idLan . '&id=');
            $smarty->assign('datas', $datas);

            $smarty->display('lanjeuxjoueurteam/viewinscrits.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function activationjoueurteamAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $model = $this->_getModel();
            $modelLan = $this->_getModelLan();
            $modelLanJeux = $this->_getModelLanJeux();
            $modelLanJoueur = $this->_getModelLanJoueur();
            $id = (int) $request->getParam('idLanJeuxJoueurTeam', 0);
            $idLan = (int) $request->getParam('idLan', 0);
            $change = (string) $request->getParam('change');
            $data = $model->fetchEntry($id);
            $lan = $modelLan->fetchEntry($idLan);

            if ($change == "a") {
                $data['validation'] = 1;
                $data['paiement'] = $lan['prix_prepaiement'];
            } else {
                $data['validation'] = 0;
                $data['paiement'] = 0;
            }

            $modelLanJoueur->save($data['idLanJoueur'], $data);

            $smarty = Zend_Registry::get('view');

            $datas = $model->fetchEntriesByLan_Teams($idLan);
            $jeux = $modelLanJeux->fetchEntriesByLan($idLan);
            $lan = $modelLan->fetchEntry($idLan);

            foreach ($jeux as $j) {
                $teams[$j['idJeux']] = $model->fetchEntriesByLanAndJeux($idLan, $j['idJeux']);

                foreach ($teams[$j['idJeux']] as $t) {
                    $compte[$j['idJeux']][$t['idTeam']] = $model->fetchEntriesByLanAndJeuxAndTeam($idLan, $j['idJeux'], $t['idTeam']);
                }
            }


            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('teams', $teams);
            $smarty->assign('jeux', $jeux);
            $smarty->assign('compte', $compte);
            $smarty->assign('total', $model->countEntries());
            $smarty->assign('title', 'Inscrits de la Lan ' . $lan['nom']);
            $smarty->assign('urlupd', $request->getBaseUrl() . '/lanjeuxjoueurteam/form/?idLan=' . $idLan . '&id=');
            $smarty->assign('urldel', $request->getBaseUrl() . '/lanjeuxjoueurteam/del/?idLan=' . $idLan . '&id=');
            $smarty->assign('datas', $datas);

            $smarty->display('lanjeuxjoueurteam/viewteams.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJeuxJoueurTeam.php';
            $this->_model = new Model_LanJeuxJoueurTeam();
        }
        return $this->_model;
    }

    protected function _getModelLan() {
        if (null === $this->_modelLan) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lan.php';
            $this->_modelLan = new Model_Lan();
        }
        return $this->_modelLan;
    }

    protected function _getModelLanJoueur() {
        if (null === $this->_modelLanJoueur) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJoueur.php';
            $this->_modelLanJoueur = new Model_LanJoueur();
        }
        return $this->_modelLanJoueur;
    }

    protected function _getModelJeux() {
        if (null === $this->_modelJeux) {
            require_once APPLICATION_PATH_COMMONS . '/models/Jeux.php';
            $this->_modelJeux = new Model_Jeux();
        }
        return $this->_modelJeux;
    }

    protected function _getModelLanJeux() {
        if (null === $this->_modelLanJeux) {
            require_once APPLICATION_PATH_COMMONS . '/models/LanJeux.php';
            $this->_modelLanJeux = new Model_LanJeux();
        }
        return $this->_modelLanJeux;
    }

    protected function _getLanJeuxJoueurTeamForm($id, $idLan) {
        require_once APPLICATION_PATH_COMMONS . '/forms/LanJeuxJoueurTeam.php';
        $form = new Form_LanJeuxJoueurTeam();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?idLan=' . $idLan . '&id=' . $id));
        else
            $form->setAction($this->_helper->url('form/?idLan=' . $idLan));
        return $form;
    }

}
