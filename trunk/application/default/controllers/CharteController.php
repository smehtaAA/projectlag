<?php

class CharteController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelJeux;
    protected $_modelCharteArticle;

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $model = $this->_getModel();
        $modelCharteArticle = $this->_getModelCharteArticle();
        $request = $this->getRequest();

        $chartes = $model->fetchEntriesOrderByOrdre();
        foreach ($chartes as $c)
            $articles[$c['idCharte']] = $modelCharteArticle->fetchEntriesByCharte($c['idCharte']);

        $smarty->assign('titre', 'Chartes');
        $smarty->assign('base_url', $request->getBaseUrl());
        $smarty->assign('ancrage', $request->getBaseUrl() . '/charte/index#');
        $smarty->assign('chartes', $chartes);
        $smarty->assign('articles', $articles);
        $smarty->display('charte/index.tpl');
    }

    public function indexadminAction() {
        return $this->_helper->redirector('index');
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Charte.php';
            $this->_model = new Model_Charte();
        }
        return $this->_model;
    }

    protected function _getModelCharteArticle() {
        if (null === $this->_modelCharteArticle) {
            require_once APPLICATION_PATH_COMMONS . '/models/CharteArticle.php';
            $this->_modelCharteArticle = new Model_CharteArticle();
        }
        return $this->_modelCharteArticle;
    }

    protected function _getModelJeux() {
        if (null === $this->_modelJeux) {
            require_once APPLICATION_PATH_COMMONS . '/models/Jeux.php';
            $this->_modelJeux = new Model_Jeux();
        }
        return $this->_modelJeux;
    }

    protected function _getCharteForm($id) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Charte.php';
        $form = new Form_Charte();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?id=' . $id));
        else
            $form->setAction($this->_helper->url('form'));
        return $form;
    }

}
