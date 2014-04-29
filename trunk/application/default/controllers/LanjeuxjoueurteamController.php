<?php

class LanJeuxJoueurTeamController extends Zend_Controller_Action {

    public function indexAction() {
        return $this->_helper->redirector('index', 'accueil');
    }

}
