<?php

class Admin_CategorieController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelSousCategorie;
    protected $_modelCompte;
    protected $_modelSujet;
    protected $_modelMessage;
    protected $_modelLecture;

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('indexadmin');
        }

        throw new Exception('Invalid method');
    }

    public function indexadminAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $model = $this->_getModel();
            $modelSousCategorie = $this->_getModelSousCategorie();
            $request = $this->getRequest();

            $datas = $model->fetchEntriesOrderByOrdre();
            $datasSousCategorie = null;
            foreach ($datas as $cat) {
                $datasSousCategorie[$cat['idCategorie']] = $modelSousCategorie->fetchEntryByCategorie($cat['idCategorie']);
            }

            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('urladd', 'form/');
            $smarty->assign('urlupd', 'form/?id=');
            $smarty->assign('urldel', 'del/?id=');
            $smarty->assign('urladdSousCat', $request->getBaseUrl() . '/souscategorie/form?idCat=');
            $smarty->assign('urlupdSousCat', $request->getBaseUrl() . '/souscategorie/form?idCat=');
            $smarty->assign('urldelSousCat', $request->getBaseUrl() . '/souscategorie/del?id=');
            $smarty->assign('datas', $datas);
            $smarty->assign('datasSousCategorie', $datasSousCategorie);
            $smarty->assign('title', 'Categorie');
            $smarty->display('forum/categorie/indexAdmin.tpl');
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
            $form = $this->_getCategorieForm($id);
            $model = $this->_getModel();

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();
                    if ($id == 0) {
                        $nb = $model->countEntries();
                        $dataform['ordre'] = $nb + 1;
                    }

                    $dataform['titre'] = utf8_decode($dataform['titre']);

                    $model->save($id, $dataform);
                    return $this->_helper->redirector('indexadmin');
                }
            } else {
                if ($id > 0) {
                    $data = $model->fetchEntry($id);

                    $data['titre'] = utf8_encode($data['titre']);
                    $form->populate($data);
                }
            }

            if ($id > 0)
                $smarty->assign('title', 'Modification Categorie');
            else
                $smarty->assign('title', 'Ajout Categorie');

            $smarty->assign('form', $form);
            $smarty->display('forum/categorie/form.tpl');
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
                        $model->save($mention['idCategorie'], $mention);
                        $ordre++;
                    }
                }
            }
            return $this->_helper->redirector('indexadmin');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function changementordreAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $model = $this->_getModel();
            $modelSousCategorie = $this->_getModelSousCategorie();
            $ordre = (int) $request->getParam('ordre', 0);
            $change = (string) $request->getParam('change');
            $data = $model->fetchEntryByOrdre($ordre);

            if ($change == "up") {
                $data['ordre'] = $data['ordre'] - 1;
                $mention = $model->fetchEntryByOrdre($data['ordre']);
                $mention['ordre'] = $mention['ordre'] + 1;
            } else {
                $data['ordre'] = $data['ordre'] + 1;
                $mention = $model->fetchEntryByOrdre($data['ordre']);
                $mention['ordre'] = $mention['ordre'] - 1;
            }

            $model->save($data['idCategorie'], $data);
            $model->save($mention['idCategorie'], $mention);

            $smarty = Zend_Registry::get('view');

            $datas = $model->fetchEntriesOrderByOrdre();
            $datasSousCategorie = null;
            foreach ($datas as $cat) {
                $datasSousCategorie[$cat['idCategorie']] = $modelSousCategorie->fetchEntryByCategorie($cat['idCategorie']);
            }

            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('urladd', 'form/');
            $smarty->assign('urlupd', 'form/?id=');
            $smarty->assign('urldel', 'del/?id=');
            $smarty->assign('urladdSousCat', $request->getBaseUrl() . '/souscategorie/form?idCat=');
            $smarty->assign('urlupdSousCat', $request->getBaseUrl() . '/souscategorie/form?idCat=');
            $smarty->assign('urldelSousCat', $request->getBaseUrl() . '/souscategorie/del?id=');
            $smarty->assign('datas', $datas);
            $smarty->assign('datasSousCategorie', $datasSousCategorie);
            $smarty->assign('title', 'Categorie');
            $smarty->display('forum/categorie/indexAdmin.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function changementordresouscatAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $model = $this->_getModel();
            $modelSousCategorie = $this->_getModelSousCategorie();
            $ordre = (int) $request->getParam('ordre', 0);
            $idCat = (int) $request->getParam('idCat', 0);
            $change = (string) $request->getParam('change');
            $data = $modelSousCategorie->fetchEntryByOrdreAndCategorie($ordre, $idCat);

            if ($change == "up") {
                $data['ordre'] = $data['ordre'] - 1;
                $mention = $modelSousCategorie->fetchEntryByOrdreAndCategorie($data['ordre'], $data['idCategorie']);
                $mention['ordre'] = $mention['ordre'] + 1;
            } else {
                $data['ordre'] = $data['ordre'] + 1;
                $mention = $modelSousCategorie->fetchEntryByOrdreAndCategorie($data['ordre'], $data['idCategorie']);
                $mention['ordre'] = $mention['ordre'] - 1;
            }

            $modelSousCategorie->save($data['idSousCategorie'], $data);
            $modelSousCategorie->save($mention['idSousCategorie'], $mention);

            $smarty = Zend_Registry::get('view');

            $datas = $model->fetchEntriesOrderByOrdre();
            $datasSousCategorie = null;
            foreach ($datas as $cat) {
                $datasSousCategorie[$cat['idCategorie']] = $modelSousCategorie->fetchEntryByCategorie($cat['idCategorie']);
            }

            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('urladd', 'form/');
            $smarty->assign('urlupd', 'form/?id=');
            $smarty->assign('urldel', 'del/?id=');
            $smarty->assign('urladdSousCat', $request->getBaseUrl() . '/souscategorie/form?idCat=');
            $smarty->assign('urlupdSousCat', $request->getBaseUrl() . '/souscategorie/form?idCat=');
            $smarty->assign('urldelSousCat', $request->getBaseUrl() . '/souscategorie/del?id=');
            $smarty->assign('datas', $datas);
            $smarty->assign('datasSousCategorie', $datasSousCategorie);
            $smarty->assign('title', 'Categorie');
            $smarty->display('forum/categorie/indexAdmin.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Categorie.php';
            $this->_model = new Model_Categorie();
        }
        return $this->_model;
    }

    protected function _getModelSousCategorie() {
        if (null === $this->_modelSousCategorie) {
            require_once APPLICATION_PATH_COMMONS . '/models/SousCategorie.php';
            $this->_modelSousCategorie = new Model_SousCategorie();
        }
        return $this->_modelSousCategorie;
    }

    protected function _getCategorieForm($id) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Categorie.php';
        $form = new Form_Categorie();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?id=' . $id));
        else
            $form->setAction($this->_helper->url('form'));
        return $form;
    }

    protected function _getModelCompte() {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
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
