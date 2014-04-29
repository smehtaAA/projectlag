<?php

class CharteArticleController extends Zend_Controller_Action {

    protected $_model;

    public function indexAction() {
        /*
          $smarty = Zend_Registry::get('view');
          $model = $this->_getModel();
          $request = $this->getRequest();

          $datas = $model->fetchEntriesOrderByOrdre();

          $smarty->assign('titre', 'Article');
          $smarty->assign('base_url', $request->getBaseUrl());
          $smarty->assign('datas', $datas);
          $smarty->display('chartearticle/index.tpl');
         */

        return $this->_helper->redirector('index', 'accueil');
    }

    public function indexadminAction() {
        return $this->_helper->redirector('index');
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/CharteArticle.php';
            $this->_model = new Model_CharteArticle();
        }
        return $this->_model;
    }

}
