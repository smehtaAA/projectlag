<?php

class LanJeuxController extends Zend_Controller_Action 
{
	
	protected $_model;
	protected $_modelLan;
	protected $_modelJeux;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$smarty->display('jeux/index.tpl');
	}
	
    public function indexadminAction() 
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
			$smarty->assign('title','Jeux de la Lan '.$lan['nom']);
			$smarty->assign('urladd',$request->getBaseUrl().'/lanjeux/form/?idLan='.$idLan);
			$smarty->assign('urlupd',$request->getBaseUrl().'/lanjeux/form/?idLan='.$idLan.'&id=');
			$smarty->assign('urldel',$request->getBaseUrl().'/lanjeux/del/?idLan='.$idLan.'&id=');
			$smarty->assign('datas',$datas);
			
			$smarty->display('lanjeux/indexAdmin.tpl');
		} else {
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
			$form    = $this->_getLanJeuxForm($id, $idLan);
			$model   = $this->_getModel();		
			$modelLan = $this->_getModelLan();
			$modelJeux = $this->_getModelJeux();
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					$dataform['idLan'] = $idLan;
					if($id==0)
					{
						$nb = $model->countEntriesByLan($idLan);	
						$dataform['ordre'] = $nb+1;
					}
					$model->save($id,$dataform);
					return $this->_helper->redirector('indexadmin','lanjeux','',array('idLan'=>$idLan));
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			$form->RemplirJeux($modelJeux->fetchEntries());
			
			if($id > 0)
				$smarty->assign('title','Modification Jeux');
			else
				$smarty->assign('title', 'Ajout Jeux');
			
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
			return $this->_helper->redirector('indexadmin','lanjeux','',array('idLan'=>$idLan));
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
			$modelLan = $this->_getModelLan();
			$idLanJeux   = (int)$request->getParam('idLanJeux', 0);
                        $idLan = (int)$request->getParam('idLan', 0);
			$change  = (string)$request->getParam('change');
			$data    = $model->fetchEntry($idLanJeux);
			
			if($change == "up") {
				$data['ordre']    = $data['ordre'] - 1;
				$mention          = $model->fetchEntryByOrdreAndLan($idLan,$data['ordre']);
				$mention['ordre'] = $mention['ordre'] + 1;
			} else {
				$data['ordre']    = $data['ordre'] + 1;
				$mention          = $model->fetchEntryByOrdreAndLan($idLan,$data['ordre']);
				$mention['ordre'] = $mention['ordre'] - 1;
			}
			
			$model->save($data['idLanJeux'], $data);
			$model->save($mention['idLanJeux'], $mention);

                        return $this->_helper->redirector('indexadmin','lanjeux','',array('idLan'=>$idLan));
			
			/*$smarty = Zend_Registry::get('view');
	
			$datas  = $model->fetchEntriesByLan($idLan);
			$lan = $modelLan->fetchEntry($idLan);
			
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','Jeux de la Lan '.$lan['nom']);
			$smarty->assign('urladd',$request->getBaseUrl().'/lanjeux/form/?idLan='.$idLan);
			$smarty->assign('urlupd',$request->getBaseUrl().'/lanjeux/form/?idLan='.$idLan.'&id=');
			$smarty->assign('urldel',$request->getBaseUrl().'/lanjeux/del/?idLan='.$idLan.'&id=');
			$smarty->assign('datas',$datas);
			
			$smarty->display('lanjeux/indexAdmin.tpl');*/
			
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
	}
	
	protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/LanJeux.php';
            $this->_model = new Model_LanJeux();
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

    protected function _getLanJeuxForm($id, $idLan)
    {
        require_once APPLICATION_PATH . '/forms/LanJeux.php';
        $form = new Form_LanJeux();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?idLan='.$idLan.'&id='.$id));
		else
			$form->setAction($this->_helper->url('form/?idLan='.$idLan));
        return $form;
    }
	
}