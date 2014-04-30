<?php

require_once '../library/My/Utils.php';

class MultimediaController extends Zend_Controller_Action {

    protected $_model;

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('index');
        }

        throw new Exception('Invalid method');
    }

    public function indexAction() {
        $smarty = Zend_Registry::get('view');

        $smarty->display('multimedia/index.tpl');
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Multimedia.php';
            $this->_model = new Model_Multimedia();
        }
        return $this->_model;
    }

}
