<?php

class Admin_AccueilController extends Zend_Controller_Action {

    protected $_modelLan;
    protected $_modelNews;
    protected $_modelPartenaire;
    protected $_modelConfig;
    protected $_modelInformation;

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('indexadminmenu');
        }

        throw new Exception('Invalid method');
    }

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $log->_setInterface_admin(true);
            return $this->_helper->redirector('indexadminmenu');
        } else {
            $smarty->assign('message', 'Erreur Connexion');
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function indexadminmenuAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $request = $this->getRequest();
            $smarty->assign('baseurl', $request->getBaseUrl());
            $module = $request->getModuleName();

            $smarty->assign('module', $module);

            $smarty->assign('title', 'Menu Administration');
            $smarty->display('accueil/indexAdminMenu.tpl','admin');
        } else {
            $smarty->assign('message', 'Erreur Connexion');
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModelLan() {
        if (null === $this->_modelLan) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lan.php';
            $this->_modelLan = new Model_Lan();
        }
        return $this->_modelLan;
    }

    protected function _getModelNews() {
        if (null === $this->_modelNews) {
            require_once APPLICATION_PATH_COMMONS . '/models/News.php';
            $this->_modelNews = new Model_News();
        }
        return $this->_modelNews;
    }

    protected function _getModelPartenaire() {
        if (null === $this->_modelPartenaire) {
            require_once APPLICATION_PATH_COMMONS . '/models/Partenaire.php';
            $this->_modelPartenaire = new Model_Partenaire();
        }
        return $this->_modelPartenaire;
    }

    protected function _getModelConfig() {
        if (null === $this->_modelConfig) {
            require_once APPLICATION_PATH_COMMONS . '/models/Config.php';
            $this->_modelConfig = new Model_Config();
        }
        return $this->_modelConfig;
    }

    protected function _getModelInformation() {
        if (null === $this->_modelInformation) {
            require_once APPLICATION_PATH_COMMONS . '/models/Information.php';
            $this->_modelInformation = new Model_Information();
        }
        return $this->_modelInformation;
    }

}
