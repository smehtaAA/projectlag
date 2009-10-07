<?php

class AccueilController extends Zend_Controller_Action 
{
	protected $_modelLan;
	protected $_modelNews;
	protected $_modelConfig;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$modelLan = $this->_getModelLan();
		$modelNews = $this->_getModelNews();
		$modelConfig = $this->_getModelConfig();
		
		$request     = $this->getRequest();
		$page        = $request->page;
		$id          = (int)$request->getParam('id', 0);
		
		if($id == 0)
		{
			$config = $modelConfig->fetchEntrySetting('nb_max_news_page');
			$nb_max_news_page = $config['valeur'];
			
			if($nb_max_news_page == 0)
				$nb_max_news_page = 4;
			
			// Récupération du nombre d'enregistrement
			$nb = $modelNews->countEntries();
			// Arrondi à l'entier supérieur
			$nb_page = ceil($nb/$nb_max_news_page);
			// Bloque l'accès au page supérieure au nombre total de page
			if($page > $nb_page) 
				$page=1;
			
			// Récupération du nombre de ligne pour la page voulue
			$news = $modelNews->fetchEntriesLimitPage($page,$nb_max_news_page);
			$newsp = $modelNews->fetchEntriesPartenaireLimitPage(1,3);
			$pages = null;
			
			for($i=1; $i<=$nb_page; $i++)
				$pages[$i] = $i;
				
				
			$nb_inscrits=0;
			$lan=$modelLan->fetchEntryOuverte();
			if($lan!=-1)
				$nb_inscrits = $modelLan->fetchEntriesCount($lan['idLan']);
				
			$smarty->assign('lan', $lan);
			$smarty->assign('nb_inscrits', $nb_inscrits);
			$smarty->assign('base_url', $request->getBaseUrl());
			$smarty->assign('pages', $pages);
			$smarty->assign('url','?page=');
			$smarty->assign('newsp', $newsp);
			$smarty->assign('news', $news);
			$smarty->display('accueil/index.tpl');
		}
	}
	
    public function indexadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Accueil');
			$smarty->display('accueil/indexAdmin.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
	
	public function indexadminmenuAction()
	{
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Menu Administration');
			$smarty->display('accueil/indexAdminMenu.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
	}
	
	public function indexjoueurmenuAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('joueur')) {
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Accueil');
			$smarty->display('accueil/indexJoueur.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
	
	protected function _getModelLan()
    {
        if (null === $this->_modelLan) {
            require_once APPLICATION_PATH . '/models/Lan.php';
            $this->_modelLan = new Model_Lan();
        }
        return $this->_modelLan;
    }
	
    protected function _getModelNews()
    {
        if (null === $this->_modelNews) {
            require_once APPLICATION_PATH . '/models/News.php';
            $this->_modelNews = new Model_News();
        }
        return $this->_modelNews;
    }
	
	protected function _getModelConfig()
	{
		if (null === $this->_modelConfig) {
			require_once APPLICATION_PATH . '/models/Config.php';
			$this->_modelConfig = new Model_Config();
		}
		return $this->_modelConfig;
	}
    
}