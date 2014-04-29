<?php

class LienController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelConfig;

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $model = $this->_getModel();
        $request = $this->getRequest();


        // R�cup�ration du nombre de ligne pour la page voulue
        $datas = $model->fetchEntries();

        $smarty->assign('datas', $datas);
        $smarty->display('lien/index.tpl');
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lien.php';
            $this->_model = new Model_Lien();
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

    protected function _getLienForm($id) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Lien.php';
        $form = new Form_Lien();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?id=' . $id));
        else
            $form->setAction($this->_helper->url('form'));
        return $form;
    }

}
