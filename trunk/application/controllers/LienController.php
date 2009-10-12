<?php

class LienController extends Zend_Controller_Action 
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
		
		$config = $modelConfig->fetchEntrySetting('nb_max_lien_page');
		
		$nb_max_lien_page = $config['value'];
		
		if($nb_max_lien_page == 0)
		{
			$nb_max_lien_page = 4;
		}
		
		// Récupération du nombre d'enregistrement
		$nb = $model->countEntries();
		// Arrondi à l'entier supérieur
		$nb_page = ceil($nb/$nb_max_lien_page);
		// Bloque l'accès au page supérieure au nombre total de page
		if($page > $nb_page) 
		{
			$page=1;
		}
		
		// Récupération du nombre de ligne pour la page voulue
		$datas  = $model->fetchEntriesLimitPage($page,$nb_max_lien_page);
		
		$pages = null;
		
		for($i=1; $i<=$nb_page; $i++)
		{
			$pages[$i] = $i;
		}

		
		$smarty->assign('datas', $datas);
		$smarty->assign('pages', $pages);
		$smarty->assign('url','?page=');
		$smarty->display('lien/index.tpl');
	}
	
	public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntries();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());			
			$smarty->assign('title','Lien');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('lien/indexAdmin.tpl');
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
			$form    = $this->_getLienForm($id);
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$model->save($id,$form->getValues());
					return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			if($id > 0)
				$smarty->assign('title','Modification Lien');
			else
				$smarty->assign('title', 'Ajout Lien');
			
			$smarty->assign('form', $form);
			$smarty->display('lien/form.tpl');
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
            require_once APPLICATION_PATH . '/models/Lien.php';
            $this->_model = new Model_Lien();
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

    protected function _getLienForm($id)
    {
        require_once APPLICATION_PATH . '/forms/Lien.php';
        $form = new Form_Lien();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
