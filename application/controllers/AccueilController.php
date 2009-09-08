<?php

class AccueilController extends Zend_Controller_Action 
{
	protected $_model;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$smarty->display('accueil/index.tpl');
	}
	
    public function indexsuperadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
			//$model  = $this->_getModel();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Accueil');
			$smarty->display('accueil/indexAdmin.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
	
	public function indexadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')) {
			//$model  = $this->_getModel();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Accueil');
			$smarty->display('accueil/indexAdmin.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
	
	public function indexjoueurAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('joueur')) {
			//$model  = $this->_getModel();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Accueil');
			$smarty->display('accueil/indexAdmin.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
    
    public function formAction()
    {
		$smarty  = Zend_Registry::get('view');
		$log = new SessionMnd();
		if($log->_getTypeConnected('admin')) {
			$request = $this->getRequest();
			$id      = (int)$request->getParam('id', 0);

		} else {
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
    
    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/Accueil.php';
            $this->_model = new Model_Accueil();
        }
        return $this->_model;
    }

    protected function _getAccueilForm($id)
    {
        require_once APPLICATION_PATH . '/forms/Accueil.php';
        $form = new Form_Accueil();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}