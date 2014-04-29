<?php

class MentionLegaleController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelConfig;

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $model = $this->_getModel();
        $request = $this->getRequest();

        $datas = $model->fetchEntriesOrderByOrdre();

        $smarty->assign('titre', 'Mentions L&eacute;gales');
        $smarty->assign('base_url', $request->getBaseUrl());
        $smarty->assign('datas', $datas);
        $smarty->display('mentionlegale/index.tpl');
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/MentionLegale.php';
            $this->_model = new Model_MentionLegale();
        }
        return $this->_model;
    }

}
