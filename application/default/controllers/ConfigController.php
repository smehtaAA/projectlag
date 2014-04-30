<?php

class ConfigController extends Zend_Controller_Action {

    public function init() {
       $this->_helper->viewRenderer->setNoRender(true);
    }

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('index');
        }

        throw new Exception('Invalid method');
    }
    
    public function indexAction() {
        return $this->_helper->redirector('index', 'accueil');
    }
    
    public function indexadminAction() {
        return $this->_helper->redirector('index', 'accueil');
    }

}
