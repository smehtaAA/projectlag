<?php

class Admin_NewsletterMailController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelNewslettermailtype;

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
            $request = $this->getRequest();
            $datas = $model->fetchEntries();
            // Faire la liste ici
            // création d'un tableau avec smarty et dans ce tableau ajouter une colonne modifier et supprimer
            // je n'ai pas encore gérer le order pour le fetchEntries mais ne pas oublier
            $smarty->assign('title', 'Newsletter Mail');
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('urladd', 'form/');
            $smarty->assign('urlupd', 'form/?id=');
            $smarty->assign('urldel', 'del/?id=');
            $smarty->assign('datas', $datas);
            $smarty->display('newsletter/indexmailAdmin.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }
    public function delAction() {
        $log = new SessionLAG();
        $smarty = Zend_Registry::get('view');
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            if ($id > 0) {
                $model = $this->_getModel();
                $model->delete($id);
                $modelt = $this->_getModelNewsletterMailType();
                $modelt->deleteByMail($id);
            }
            return $this->_helper->redirector('indexadmin');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/NewsletterMail.php';
            $this->_model = new Model_NewsletterMail();
        }
        return $this->_model;
    }

    protected function _getModelNewsletterMailType() {
        if (null === $this->_modelNewslettermailtype) {
            require_once APPLICATION_PATH_COMMONS . '/models/NewsletterMailType.php';
            $this->_modelNewslettermailtype = new Model_NewsletterMailType();
        }
        return $this->_modelNewslettermailtype;
    }

    protected function _getNewsletterMailForm($id) {
        require_once APPLICATION_PATH_COMMONS . '/forms/NewsletterMail.php';
        $form = new Form_NewsletterMail();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?id=' . $id));
        else
            $form->setAction($this->_helper->url('form'));
        return $form;
    }

}
