<?php

class PartenaireController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelConfig;

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('index');
        }

        throw new Exception('Invalid method');
    }

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $model = $this->_getModel();
        $modelConfig = $this->_getModelConfig();
        $request = $this->getRequest();
        $base_url = $request->getBaseUrl();
        $smarty->assign('base_url', $base_url);

        $types = $model->fetchEntriesTypes();
        $smarty->assign('types', $types);

        if (isset($request->type)) {

            $partenaires = $model->fetchEntriesType($request->type);
            $smarty->assign('partenaires', $partenaires);
            $smarty->display('partenaire/index.tpl');
        } else {
            $partenaires = $model->fetchEntries();
            $smarty->assign('partenaires', $partenaires);
            $smarty->display('partenaire/index.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Partenaire.php';
            $this->_model = new Model_Partenaire();
        }
        return $this->_model;
    }

    protected function _getModelConfig() {
        if (null === $this->_modelConfig) {
            require_once APPLICATION_PATH_COMMONS . '/models/Config.php';
            $this->_modelConfig = new Model_Config();
        }
        return $this->_modelConfig;
    }

}
