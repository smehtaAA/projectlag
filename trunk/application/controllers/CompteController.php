<?php

class CompteController extends Zend_Controller_Action 
{
	
	protected $_model;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$smarty->display('compte/index.tpl');
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
			$smarty->assign('title','Compte');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('compte/indexSuperAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	public function indexadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')) {
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Compte');
			$smarty->display('compte/indexAdmin.tpl');
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
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Compte');
			$smarty->display('compte/indexAdmin.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
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
			$form    = $this->_getCompteForm($id, $log->_getType());
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					$datenaissance = $dataform['datenaissance'];
					$dataform['datenaissance'] = substr($datenaissance, 6, 4)."-".substr($datenaissance, 3, 2)."-".substr($datenaissance, 0, 2)." 00:00:00";
					$model->save($id,$dataform);
					if($log->_getTypeConnected('superadmin'))
						return $this->_helper->redirector('indexsuperadmin');
					else
						return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$date = new Zend_Date($data['datenaissance']);
					$data['datenaissance'] = $date->toString('dd/MM/Y');
					$form->populate($data);
				}
			}
			
			if($id > 0)
				$smarty->assign('title','Modification Compte');
			else
				$smarty->assign('title', 'Ajout Compte');
			
			$smarty->assign('form', $form);
			$smarty->display('compte/form.tpl');
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
			if($log->_getTypeConnected('superadmin'))
				return $this->_helper->redirector('indexsuperadmin');
			else
				return $this->_helper->redirector('indexadmin');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
    
	
	protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/Compte.php';
            $this->_model = new Model_Compte();
        }
        return $this->_model;
    }

    protected function _getCompteForm($id,$type)
    {
        require_once APPLICATION_PATH . '/forms/Compte.php';
        if(($type == 'admin'||$type=='superadmin') && !empty($id)) {
			Zend_Registry::set('modeform', 'modif');
			$form = new Form_Compte();
			$form->setAction($this->_helper->url('form/?id='.$id));
		} else {
			if($type == 'admin'||$type=='superadmin')
				Zend_Registry::set('modeform', 'ajout');
			else
				Zend_Registry::set('modeform', 'modif');
			
			$form = new Form_Compte();
			$form->setAction($this->_helper->url('form'));
		}
		return $form;
    }
	
}