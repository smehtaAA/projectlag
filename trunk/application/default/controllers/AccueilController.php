<?php

class AccueilController extends Zend_Controller_Action {

    protected $_modelLan;
    protected $_modelNews;
    protected $_modelPartenaire;
    protected $_modelConfig;
    protected $_modelInformation;

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $modelLan = $this->_getModelLan();
        $modelNews = $this->_getModelNews();
        $modelConfig = $this->_getModelConfig();
        $modelPartenaire = $this->_getModelPartenaire();
        $modelInformation = $this->_getModelInformation();

        $request = $this->getRequest();
        $page = $request->page;
        $id = (int) $request->getParam('id', 0);

        $log = new SessionLAG();
        if ($log->_getTypeConnected('joueur')) {
            $smarty->assign('log_joueur', 1);
        } elseif ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $smarty->assign('log_joueur', 2);
        } else {
            $smarty->assign('log_joueur', 0);
        }

        if ($id == 0) {
            $config = $modelConfig->fetchEntrySetting('nb_max_news_page');
            $nb_max_news_page = $config['valeur'];

            if ($nb_max_news_page == 0)
                $nb_max_news_page = 4;

            // R�cup�ration du nombre d'enregistrement
            $nb = $modelNews->countEntries();
            // Arrondi � l'entier sup�rieur
            $nb_page = ceil($nb / $nb_max_news_page);
            // Bloque l'acc�s au page sup�rieure au nombre total de page
            if ($page > $nb_page)
                $page = 1;

            // R�cup�ration du nombre de ligne pour la page voulue
            $news = $modelNews->fetchEntriesLimitPage($page, $nb_max_news_page);
            $newsp = $modelNews->fetchEntriesPartenaireLimitPage(1, 2);
            $pages = null;

            for ($i = 1; $i <= $nb_page; $i++)
                $pages[$i] = $i;

            $lan_ouverte = $modelLan->fetchEntryOuverteField(array('idLan'));
            $lan = $modelLan->fetchEntryOuverteDateField(array('idLan', 'nom', 'adresse', 'cp', 'ville', 'datedeb', 'datefin', 'prix_prepaiement', 'prix', 'inscription'));
            if ($lan['inscription'] == 1 && $lan['idLan'] == $lan_ouverte['idLan']) {
                $lan['nb_inscrits'] = $modelLan->fetchEntriesCountValide($lan['idLan']);
                $lan['nb_preinscrits'] = $modelLan->fetchEntriesCountPreInscrits($lan['idLan']);
            }

            // R�cup�ration du partenaire aleatoire
            $partenaire = $modelPartenaire->fetchEntryRandom();

            $partenaires = $modelPartenaire->fetchEntriesL();
            foreach ($partenaires as $p)
                $part[$p['idPartenaire']] = $p['titre'];

            // R�cup�ration des 3 informations
            $infos = $modelInformation->fetchEntriesAccueil();

            $smarty->assign('infos', $infos);
            $smarty->assign('lan', $lan);
            $smarty->assign('lan_ouverte', $lan_ouverte);
            $smarty->assign('partenaire', $partenaire);
            $smarty->assign('partenaires', $part);
            $smarty->assign('logos', $partenaires);
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('pages', $pages);
            $smarty->assign('url', '?page=');
            $smarty->assign('newsp', $newsp);
            $smarty->assign('news', $news);
            $smarty->display('accueil/index.tpl');
        }
    }
    
    public function indexadminAction() {
        return $this->_helper->redirector('index');
    }

    public function retourindexAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {

            $defaultNamespace = new Zend_Session_Namespace();
            $log->_setInterface_admin(false);
            return $this->_helper->redirector('index');
        } else {
            $smarty->assign('message', 'Erreur Connexion');
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModelLan() {
        if (null === $this->_modelLan) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lan.php';
            $this->_modelLan = new Model_Lan();
        }
        return $this->_modelLan;
    }

    protected function _getModelNews() {
        if (null === $this->_modelNews) {
            require_once APPLICATION_PATH_COMMONS . '/models/News.php';
            $this->_modelNews = new Model_News();
        }
        return $this->_modelNews;
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

    protected function _getModelInformation() {
        if (null === $this->_modelInformation) {
            require_once APPLICATION_PATH_COMMONS . '/models/Information.php';
            $this->_modelInformation = new Model_Information();
        }
        return $this->_modelInformation;
    }

}
