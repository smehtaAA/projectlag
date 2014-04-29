<?php

class Admin_SousCategorieController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelSujet;
    protected $_modelCompte;
    protected $_modelCategorie;
    protected $_modelMessage;
    protected $_modelLecture;

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
            $request = $this->getRequest();
            $smarty->assign('baseurl', $request->getBaseUrl());

            $smarty->assign('title', 'Sous Categorie');
            $smarty->display('forum/souscategorie/indexAdmin.tpl');
        } else {
            $smarty->assign('message', 'Erreur Connexion');
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function formAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            $idCat = (int) $request->getParam('idCat', 0);
            $form = $this->_getCategorieForm($id, $idCat);
            $model = $this->_getModel();

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();
                    if ($id == 0) {
                        $nb = $model->countEntriesbyCategorie($idCat);
                        $dataform['ordre'] = $nb + 1;
                    }
                    $dataform['idCategorie'] = $idCat;


                    $dataform['titre'] = utf8_decode($dataform['titre']);

                    $model->save($id, $dataform);
                    return $this->_helper->redirector('indexadmin', 'categorie');
                }
            } else {
                if ($id > 0) {
                    $data = $model->fetchEntry($id);

                    $data['titre'] = utf8_encode($data['titre']);
                    $form->populate($data);
                }
            }

            if ($id > 0)
                $smarty->assign('title', 'Modification SousCategorie');
            else
                $smarty->assign('title', 'Ajout SousCategorie');

            $smarty->assign('form', $form);
            $smarty->display('forum/souscategorie/form.tpl');
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
                $data = $model->fetchEntry($id);
                $ordre = $data['ordre'];
                $model->delete($id);

                // Decalage des ordres
                $datas = $model->fetchEntriesOrderByOrdre();
                foreach ($datas as $mention) {
                    if ($mention['ordre'] == $ordre + 1) {
                        $mention['ordre'] = $ordre;
                        $model->save($mention['idSousCategorie'], $mention);
                        $ordre++;
                    }
                }
            }
            return $this->_helper->redirector('indexadmin', 'categorie');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/SousCategorie.php';
            $this->_model = new Model_SousCategorie();
        }
        return $this->_model;
    }

    protected function _getModelCategorie() {
        if (null === $this->_modelCategorie) {
            require_once APPLICATION_PATH_COMMONS . '/models/Categorie.php';
            $this->_modelCategorie = new Model_Categorie();
        }
        return $this->_modelCategorie;
    }

    protected function _getModelCompte() {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }

    protected function _getCategorieForm($id, $idCat) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Categorie.php';
        $form = new Form_Categorie();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?idCat=' . $idCat . '&id=' . $id));
        else
            $form->setAction($this->_helper->url('form?idCat=' . $idCat));
        return $form;
    }

    protected function _getModelSujet() {
        if (null === $this->_modelSujet) {
            require_once APPLICATION_PATH_COMMONS . '/models/Sujet.php';
            $this->_modelSujet = new Model_Sujet();
        }
        return $this->_modelSujet;
    }

    protected function _getModelMessage() {
        if (null === $this->_modelMessage) {
            require_once APPLICATION_PATH_COMMONS . '/models/Message.php';
            $this->_modelMessage = new Model_Message();
        }
        return $this->_modelMessage;
    }

    protected function _getModelLecture() {
        if (null === $this->_modelLecture) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lecture.php';
            $this->_modelLecture = new Model_Lecture();
        }
        return $this->_modelLecture;
    }

}
