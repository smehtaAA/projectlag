<?php

class LanJeuxJoueurTeamController extends Zend_Controller_Action 
{
	
	protected $_model;
	protected $_modelLan;
	protected $_modelJeux;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$smarty->display('jeux/index.tpl');
	}
	
    public function indexsuperadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
			$model  = $this->_getModel();
			$modelLan = $this->_getModelLan();
			$request = $this->getRequest();
			$idLan   = (int)$request->getParam('idLan', 0);
			
			$datas  = $model->fetchEntriesByLan($idLan);
			$lan = $modelLan->fetchEntry($idLan);
			
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','Jeux de la Lan '.$lan['nom']);
			$smarty->assign('urladd',$request->getBaseUrl().'/lanjeux/form/?idLan='.$idLan);
			$smarty->assign('urlupd',$request->getBaseUrl().'/lanjeux/form/?idLan='.$idLan.'&id=');
			$smarty->assign('urldel',$request->getBaseUrl().'/lanjeux/del/?idLan='.$idLan.'&id=');
			$smarty->assign('datas',$datas);
			
			$smarty->display('lanjeux/indexSuperAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	public function viewinscritsAction()
	{
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$modelLan = $this->_getModelLan();
			$request = $this->getRequest();
			$idLan   = (int)$request->getParam('idLan', 0);
			
			$datas  = $model->fetchEntriesByLan($idLan);
			$lan = $modelLan->fetchEntry($idLan);
			
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','Inscrits de la Lan '.$lan['nom']);
			$smarty->assign('urlupd',$request->getBaseUrl().'/lanjeuxjoueurteam/form/?idLan='.$idLan.'&id=');
			$smarty->assign('urldel',$request->getBaseUrl().'/lanjeuxjoueurteam/del/?idLan='.$idLan.'&id=');
			$smarty->assign('datas',$datas);
			
			$smarty->display('lanjeuxjoueurteam/viewinscrits.tpl');
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
			
			$smarty->assign('title','Jeux');
			$smarty->display('jeux/indexAdmin.tpl');
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
			
			$smarty->assign('title','Jeux');
			$smarty->display('jeux/indexAdmin.tpl');
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
			$idLan   = (int)$request->getParam('idLan', 0);
			$form    = $this->_getLanJeuxJoueurTeamForm($id, $idLan);
			$model   = $this->_getModel();		
			$modelLan = $this->_getModelLan();
			$modelJeux = $this->_getModelJeux();
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					$dataform['idLan'] = $idLan;
					if($dataform['validation']==0)
					{	
						$dataform['paiement'] = 0;
					}
					$model->save($id,$dataform);
					return $this->_helper->redirector('viewinscrits','lanjeuxjoueurteam','',array('idLan'=>$idLan));
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			$smarty->assign('title','Modification Inscription');
			
			$smarty->assign('form', $form);
			$smarty->display('lanjeux/form.tpl');
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
			$idLan   = (int)$request->getParam('idLan', 0);
			if ($id > 0) {
				$model = $this->_getModel();
				$model->delete($id);
			}
			return $this->_helper->redirector('viewinscrits','lanjeuxjoueurteam','',array('idLan'=>$idLan));
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
    
	public function activationjoueurAction()
	{
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
			$request = $this->getRequest();
			$model   = $this->_getModel();
			$modelLan = $this->_getModelLan();
			$id   = (int)$request->getParam('idLanJeuxJoueurTeam', 0);
			$idLan   = (int)$request->getParam('idLan', 0);
			$change  = (string)$request->getParam('change');
			$data    = $model->fetchEntry($id);
			$lan = $modelLan->fetchEntry($idLan);
			
			if($change == "a") {
				$data['validation']    = 1;
				$data['paiement'] = $lan['prix'];
			} else {
				$data['validation']    = 0;
				$data['paiement'] = 0;
			}
			
			$model->save($data['idLanJeuxJoueurTeam'], $data);
			
			$smarty = Zend_Registry::get('view');
	
			$datas  = $model->fetchEntriesByLan($idLan);
			$lan = $modelLan->fetchEntry($idLan);
			
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','Inscrits de la Lan '.$lan['nom']);
			$smarty->assign('urlupd',$request->getBaseUrl().'/lanjeuxjoueurteam/form/?idLan='.$idLan.'&id=');
			$smarty->assign('urldel',$request->getBaseUrl().'/lanjeuxjoueurteam/del/?idLan='.$idLan.'&id=');
			$smarty->assign('datas',$datas);
			
			$smarty->display('lanjeuxjoueurteam/viewinscrits.tpl');
			
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
	}
	
	protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/LanJeuxJoueurTeam.php';
            $this->_model = new Model_LanJeuxJoueurTeam();
        }
        return $this->_model;
    }
	
	protected function _getModelLan()
    {
        if (null === $this->_modelLan) {
            require_once APPLICATION_PATH . '/models/Lan.php';
            $this->_modelLan = new Model_Lan();
        }
        return $this->_modelLan;
    }
	
	protected function _getModelJeux()
    {
        if (null === $this->_modelJeux) {
            require_once APPLICATION_PATH . '/models/Jeux.php';
            $this->_modelJeux = new Model_Jeux();
        }
        return $this->_modelJeux;
    }

    protected function _getLanJeuxJoueurTeamForm($id, $idLan)
    {
        require_once APPLICATION_PATH . '/forms/LanJeuxJoueurTeam.php';
        $form = new Form_LanJeuxJoueurTeam();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?idLan='.$idLan.'&id='.$id));
		else
			$form->setAction($this->_helper->url('form/?idLan='.$idLan));
        return $form;
    }
	
}