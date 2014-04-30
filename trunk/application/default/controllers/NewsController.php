<?php

class NewsController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelConfig;
    protected $_modelPartenaire;

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
        $id = $request->getParam('id', 0);

        $news = $model->fetchEntry($id);

        $smarty->assign('base_url', $request->getBaseUrl());
        $smarty->assign('news', $news);
        $smarty->display('news/index.tpl');
    }

    public function indexpartenaireAction() {
        $smarty = Zend_Registry::get('view');

        $model = $this->_getModel();
        $modelConfig = $this->_getModelConfig();
        $request = $this->getRequest();
        $page = $request->page;

        $config = $modelConfig->fetchEntrySetting('nb_max_news_partenaire_page');

        $nb_max_news_page = $config['valeur'];

        if ($nb_max_news_page == 0) {
            $nb_max_news_page = 4;
        }

        // R�cup�ration du nombre d'enregistrement
        $nb = $model->countEntriesPartenaires();
        // Arrondi � l'entier sup�rieur
        $nb_page = ceil($nb / $nb_max_news_page);
        // Bloque l'acc�s au page sup�rieure au nombre total de page
        if ($page > $nb_page) {
            $page = 1;
        }

        // R�cup�ration du nombre de ligne pour la page voulue
        $datas = $model->fetchEntriesPartenaireLimitPage($page, $nb_max_news_page);

        $pages = null;

        for ($i = 1; $i <= $nb_page; $i++) {
            $pages[$i] = $i;
        }

        $smarty->assign('base_url', $request->getBaseUrl());
        $smarty->assign('datas', $datas);
        $smarty->assign('pages', $pages);
        $smarty->assign('url', '?page=');
        $smarty->display('news/indexPartenaire.tpl');
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/News.php';
            $this->_model = new Model_News();
        }
        return $this->_model;
    }

    protected function _getModelPartenaire() {
        if (null === $this->_modelPartenaire) {
            require_once APPLICATION_PATH_COMMONS . '/models/Partenaire.php';
            $this->_modelPartenaire = new Model_Partenaire();
        }
        return $this->_modelPartenaire;
    }

    protected function _getModelConfig() {
        if (null === $this->_modelConfig) {
            require_once APPLICATION_PATH_COMMONS . '/models/Config.php';
            $this->_modelConfig = new Model_Config();
        }
        return $this->_modelConfig;
    }

}
