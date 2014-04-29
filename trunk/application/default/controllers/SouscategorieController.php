<?php

class SousCategorieController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelSujet;
    protected $_modelCompte;
    protected $_modelCategorie;
    protected $_modelMessage;
    protected $_modelLecture;

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $request = $this->getRequest();
        $id = $request->getParam('id', 0);
        if ($id > 0) {
            $modelSousCategorie = $this->_getModel();
            $modelSujet = $this->_getModelSujet();
            $modelCompte = $this->_getModelCompte();
            $modelCategorie = $this->_getModelCategorie();
            $modelMessage = $this->_getModelMessage();
            $modelLecture = $this->_getModelLecture();
            $log = new SessionLAG();
            if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin') || $log->_getTypeConnected('joueur'))
                $login = $modelCompte->fetchEntryForum($log->_getUser());
            else
                $login = 0;

            $nb = null;
            $last_messages = null;
            $lecture = null;
            $sujets = $modelSujet->fetchEntryBySousCategorie($id);
            foreach ($sujets as $s) {

                $nb[$s['idSujet']]['reponses'] = $modelMessage->countEntriesBySujet($s['idSujet']) - 1;
                $last_messages[$s['idSujet']] = $modelMessage->fetchEntryLastBySujet($s['idSujet']);

                if (($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin') || $log->_getTypeConnected('joueur'))) {
                    $lecture[$s['idSujet']] = $modelLecture->fetchEntriesByCompteAndSujet($log->_getUser(), $s['idSujet']);
                }
            }



            $souscat = $modelSousCategorie->fetchEntryL($id);

            $categorie = $modelCategorie->fetchEntryField($souscat['idCategorie'], array('idCategorie', 'titre', 'admin'));

            $fil_arianne['cat'] = array('id' => $categorie['idCategorie'], 'nom' => $categorie['titre'], 'admin' => $categorie['admin']);
            $fil_arianne['sscat'] = array('id' => $souscat['idSousCategorie'], 'nom' => $souscat['titre'], 'admin' => $categorie['admin']);

            $smarty->assign('lecture', $lecture);
            $smarty->assign('fil_arianne', $fil_arianne);
            $smarty->assign('nb', $nb);
            $smarty->assign('last_messages', $last_messages);
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('sujets', $sujets);
            $smarty->assign('login', $login);
            $smarty->assign('souscat', $souscat);
            $smarty->assign('url_addsujet', $request->getBaseUrl() . '/sujet/form?idSsCat=' . $id);
            $smarty->assign('url_viewsujet', $request->getBaseUrl() . '/sujet/index?id=');

            $smarty->display('forum/souscategorie/index.tpl');
        } else {
            return $this->_helper->redirector('index', 'forum');
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
