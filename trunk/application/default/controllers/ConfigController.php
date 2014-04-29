<?php

class ConfigController extends Zend_Controller_Action {

    public function init() {
       $this->_helper->viewRenderer->setNoRender(true);
    }
    
    public function indexAction() {
        return $this->_helper->redirector('index', 'accueil');
    }
    
    public function indexadminAction() {
        return $this->_helper->redirector('index', 'accueil');
    }

}
