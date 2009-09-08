<?php

class NewsController extends Zend_Controller_Action 
{
    protected $_model;
	protected $_modelConfig;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$model  = $this->_getModel();
		$modelConfig = $this->_getModelConfig();
		$request = $this->getRequest();
		$page = $request->page;

		$config = $modelConfig->fetchEntrySetting('nb_max_news_page');

 		$nb_max_news_page = $config['value'];
		
		if($nb_max_news_page == 0)
		{
			$nb_max_news_page = 4;
		}
		
		// Récupération du nombre d'enregistrement
		$nb = $model->countEntries();
		// Arrondi à l'entier supérieur
		$nb_page = ceil($nb/$nb_max_news_page);
		// Bloque l'accès au page supérieure au nombre total de page
		if($page > $nb_page) 
		{
			$page=1;
		}
		
		// Récupération du nombre de ligne pour la page voulue
		$datas  = $model->fetchEntriesLimitPage($page,$nb_max_news_page);
		
		$pages = null;
		
		for($i=1; $i<=$nb_page; $i++)
		{
			$pages[$i] = $i;
		}

		
		$smarty->assign('datas', $datas);
		$smarty->assign('pages', $pages);
		$smarty->assign('url','?page=');
		$smarty->display('news/index.tpl');
		
	}
	
	public function indexsuperadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntries();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','News');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('news/indexSuperAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }


    public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntries();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','News');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('news/indexAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }

    public function formAction()
    {
		$smarty  = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
			$request = $this->getRequest();
			$id      = (int)$request->getParam('id', 0);
			$form    = $this->_getNewsForm($id);
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();					
					if(!empty($dataform["creer_type_n"]))
						$dataform["type_n"] = $dataform["creer_type_n"];
					unset($dataform["creer_type_n"]);
					$model->save($id,$dataform);
					if($log->_getTypeConnected('superadmin'))
						return $this->_helper->redirector('indexsuperadmin');
					else
						return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			$form->RemplirType($model->fetchEntriesTypes());
			
			if($id > 0)
				$smarty->assign('title','Modification News');
			else
				$smarty->assign('title', 'Ajout News');
			
			$smarty->assign('form', $form);
			$smarty->display('news/form.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	public function delAction()
    {
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
			$request = $this->getRequest();
			$id      = (int)$request->getParam('id', 0);
			if ($id > 0) {
				$model = $this->_getModel();
				$model->delete($id);
			}
			return $this->_helper->redirector('indexadmin'); 
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }

    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/News.php';
            $this->_model = new Model_News();
        }
        return $this->_model;
    }
	
	protected function _getModelConfig()
	{
		if (null === $this->_modelConfig) {
			require_once APPLICATION_PATH . '/models/Config.php';
			$this->_modelConfig = new Model_Config();
		}
		return $this->_modelConfig;
	}

    protected function _getNewsForm($id)
    {
        require_once APPLICATION_PATH . '/forms/News.php';
        $form = new Form_News();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
