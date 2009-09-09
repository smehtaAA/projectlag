<?php

class PartenaireController extends Zend_Controller_Action 
{
    protected $_model;
	protected $_modelConfig;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$model  = $this->_getModel();
		$modelConfig = $this->_getModelConfig();
		$request = $this->getRequest();
		$base_url = $request->getBaseUrl();
		$smarty->assign('base_url',$base_url);
		
		$types = $model->fetchEntriesTypes();
		$smarty->assign('types', $types);
		
		if(isset($request->type))
		{

				$partenaires = $model->fetchEntriesType($request->type);
				$smarty->assign('partenaires', $partenaires);
				$smarty->display('partenaire/index.tpl');

		}
		else 
		{
				$partenaires = $model->fetchEntries();
				$smarty->assign('partenaires', $partenaires);
				$smarty->display('partenaire/index.tpl');
		}	
	}

	public function indexsuperadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntriesOrderByOrdre();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());		
			$smarty->assign('title','Partenaire');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('partenaire/indexSuperAdmin.tpl');
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
			$datas  = $model->fetchEntriesOrderByOrdre();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());		
			$smarty->assign('title','Partenaire');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('partenaire/indexAdmin.tpl');
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
			$form    = $this->_getPartenaireForm($id);
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();	
					if($id==0){
						$nb = $model->countEntries();
						$dataform['ordre'] = $nb+1;
					}
					if(!empty($dataform["creer_type"]))
						$dataform["type"] = $dataform["creer_type"];
					unset($dataform["creer_type"]);
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
				$smarty->assign('title','Modification Partenaire');
			else
				$smarty->assign('title', 'Ajout Partenaire');
			
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
			if($log->_getTypeConnected('superadmin'))
				return $this->_helper->redirector('indexsuperadmin');
			else
				return $this->_helper->redirector('indexadmin');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	public function changementordreAction()
	{
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
			$request = $this->getRequest();
			$model   = $this->_getModel();
			$ordre   = (int)$request->getParam('ordre', 0);
			$change  = (string)$request->getParam('change');
			$data    = $model->fetchEntryByOrdre($ordre);
			
			if($change == "up") {
				$data['ordre']    = $data['ordre'] - 1;
				$mention          = $model->fetchEntryByOrdre($data['ordre']);
				$mention['ordre'] = $mention['ordre'] + 1;
			} else {
				$data['ordre']    = $data['ordre'] + 1;
				$mention          = $model->fetchEntryByOrdre($data['ordre']);
				$mention['ordre'] = $mention['ordre'] - 1;
			}
			
			$model->save($data['idPartenaire'], $data);
			$model->save($mention['idPartenaire'], $mention);
			
			$smarty = Zend_Registry::get('view');
	
			$datas  = $model->fetchEntriesOrderByOrdre();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());		
			$smarty->assign('title','Partenaire');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			if($log->_getTypeConnected('superadmin'))
				$smarty->display('partenaire/indexSuperAdmin.tpl');
			else
				$smarty->display('partenaire/indexAdmin.tpl');
			
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
	}

    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/Partenaire.php';
            $this->_model = new Model_Partenaire();
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

    protected function _getPartenaireForm($id)
    {
        require_once APPLICATION_PATH . '/forms/Partenaire.php';
        $form = new Form_Partenaire();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
