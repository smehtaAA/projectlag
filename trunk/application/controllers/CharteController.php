<?php

class CharteController extends Zend_Controller_Action 
{
    protected $_model;
	protected $_modelJeux;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$model  = $this->_getModel();
		$request = $this->getRequest();
		
		$datas = $model->fetchEntriesOrderByOrdre();
		
		$smarty->assign('titre', 'Charte');
		$smarty->assign('base_url', $request->getBaseUrl());
		$smarty->assign('datas', $datas);
		$smarty->display('charte/index.tpl');
	}
	
	public function indexsuperadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
			$model   = $this->_getModel();
			$datas   = $model->fetchEntriesOrderByOrdre();
			$request = $this->getRequest();
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('titre','Charte');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('viewarticles',$request->getBaseUrl().'/chartearticle/indexsuperadmin?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('charte/indexSuperAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }

    public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')) {
			$model   = $this->_getModel();
			$datas   = $model->fetchEntriesOrderByOrdre();
			$request = $this->getRequest();
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('titre','Charte');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('viewarticles',$request->getBaseUrl().'/chartearticle/indexadmin?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('charte/indexAdmin.tpl');
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
			$form    = $this->_getCharteForm($id);
			$model   = $this->_getModel();	
			$modelJeux = $this->_getModelJeux();
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					if($id==0){
						$nb = $model->countEntries();
						$dataform['ordre'] = $nb+1;
					}
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
			
			$form->RemplirJeux($modelJeux->fetchEntries());
			
			
			if($id > 0)
				$smarty->assign('title','Modification Charte');
			else
				$smarty->assign('title', 'Ajout Charte');
			
			$smarty->assign('form', $form);
			$smarty->display('charte/form.tpl');
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
				$data = $model->fetchEntry($id);
				$ordre = $data['ordre'];
				$model->delete($id);
				
				// Decalage des ordres
				$datas = $model->fetchEntriesOrderByOrdre();
				foreach($datas as $mention) {
					if($mention['ordre'] == $ordre+1) {
						$mention['ordre'] = $ordre;
						$model->save($mention['idCharte'], $mention);
						$ordre++;
					}
				}
				
				
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
			
			$model->save($data['idCharte'], $data);
			$model->save($mention['idCharte'], $mention);
			
			$smarty = Zend_Registry::get('view');
	
			$datas   = $model->fetchEntriesOrderByOrdre();
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('titre','Charte');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			if($log->_getTypeConnected('superadmin')){
				$smarty->assign('viewarticles',$request->getBaseUrl().'/chartearticle/indexsuperadmin?id=');
				$smarty->display('charte/indexSuperAdmin.tpl');
			}else{
				$smarty->assign('viewarticles',$request->getBaseUrl().'/chartearticle/indexadmin?id=');
				$smarty->display('charte/indexAdmin.tpl');
			}
			
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
	}

    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/Charte.php';
            $this->_model = new Model_Charte();
        }
        return $this->_model;
    }

	protected function _getModelJeux()
    {
        if (null === $this->_modelJeux) {
            require_once APPLICATION_PATH . '/models/Jeux.php';
            $this->_modelJeux = new Model_Jeux();
        }
        return $this->_modelJeux;
    }

    protected function _getCharteForm($id)
    {
        require_once APPLICATION_PATH . '/forms/Charte.php';
        $form = new Form_Charte();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
