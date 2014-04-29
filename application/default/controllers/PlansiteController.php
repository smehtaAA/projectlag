<?php

class PlansiteController extends Zend_Controller_Action {

    protected $_model;

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $model = $this->_getModel();
        $request = $this->getRequest();
        $base_url = $request->getBaseUrl();
        $smarty->assign('base_url', $base_url);

        $plansite = $model->fetchEntries();
        $smarty->assign('plansite', $plansite);
        $smarty->display('plansite/index.tpl');
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/PlanSite.php';
            $this->_model = new Model_PlanSite();
        }
        return $this->_model;
    }

}
