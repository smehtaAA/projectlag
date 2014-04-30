<?php

class Admin_ForumController extends Zend_Controller_Action {

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
            $request = $this->getRequest();
            $smarty->assign('baseurl', $request->getBaseUrl());

            $smarty->assign('title', 'Forum');
            $smarty->display('forum/indexAdmin.tpl');
        } else {
            $smarty->assign('message', 'Erreur Connexion');
            $smarty->display('error/errorconnexion.tpl');
        }
    }

}
