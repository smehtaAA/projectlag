<?php

class Admin_MessageController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelMessage;
    protected $_modelCompte;
    protected $_modelGrade;
    protected $_modelLecture;

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
        return $this->_helper->redirector('index', 'forum');
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Sujet.php';
            $this->_model = new Model_Sujet();
        }
        return $this->_model;
    }

    protected function _getModelMessage() {
        if (null === $this->_modelMessage) {
            require_once APPLICATION_PATH_COMMONS . '/models/Message.php';
            $this->_modelMessage = new Model_Message();
        }
        return $this->_modelMessage;
    }

    protected function _getModelCompte() {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }

    protected function _getModelGrade() {
        if (null === $this->_modelGrade) {
            require_once APPLICATION_PATH_COMMONS . '/models/Grade.php';
            $this->_modelGrade = new Model_Grade();
        }
        return $this->_modelGrade;
    }

    protected function _getModelLecture() {
        if (null === $this->_modelLecture) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lecture.php';
            $this->_modelLecture = new Model_Lecture();
        }
        return $this->_modelLecture;
    }

    protected function _getMessageForm($id, $idSujet) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Message.php';
        $form = new Form_Message();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?idSujet=' . $idSujet . '&id=' . $id));
        else
            $form->setAction($this->_helper->url('form?idSujet=' . $idSujet));
        return $form;
    }

}
