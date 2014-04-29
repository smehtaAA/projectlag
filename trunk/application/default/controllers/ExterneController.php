<?php

class ExterneController extends Zend_Controller_Action {

    public function indexAction() {
        return $this->_helper->redirector('index', 'accueil');
    }

}
