<?php

class LanJeuxController extends Zend_Controller_Action {

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('index');
        }

        throw new Exception('Invalid method');
    }

    public function indexAction() {
        return $this->_helper->redirector('index', 'accueil');
    }

}
