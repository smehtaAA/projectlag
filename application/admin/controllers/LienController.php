<?php

class Admin_LienController extends Zend_Controller_Action
{
    protected $_model;
	protected $_modelConfig;

	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$model  = $this->_getModel();
		$request = $this->getRequest();
		
		
		// R�cup�ration du nombre de ligne pour la page voulue
		$datas  = $model->fetchEntries();
		
		$smarty->assign('datas', $datas);
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
					$dataform = $form->getValues();
                                        $dataform['titre'] = utf8_decode($dataform['titre']);
					$model->save($id,$dataform);
					return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
                                        $data['titre'] = utf8_encode($data['titre']);
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
            require_once APPLICATION_PATH_COMMONS . '/models/Lien.php';
            $this->_model = new Model_Lien();
        }
        return $this->_model;
    }
		
	protected function _getModelConfig()
	{
		if (null === $this->_modelConfig) {
			require_once APPLICATION_PATH_COMMONS . '/models/Config.php';
			$this->_modelConfig = new Model_Config();
		}
		return $this->_modelConfig;
	}

    protected function _getLienForm($id)
    {
        require_once APPLICATION_PATH_COMMONS . '/forms/Lien.php';
        $form = new Form_Lien();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
