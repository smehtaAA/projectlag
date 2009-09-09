<?php

class MentionLegaleController extends Zend_Controller_Action 
{
    protected $_model;
	protected $_modelConfig;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$model  = $this->_getModel();
		$request = $this->getRequest();
		
		$datas = $model->fetchEntriesOrderByOrdre();
		
		$smarty->assign('titre', 'Mentions L&eacute;gales');
		$smarty->assign('base_url', $request->getBaseUrl());
		$smarty->assign('datas', $datas);
		$smarty->display('mentionlegale/index.tpl');
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
			$smarty->assign('titre','Mentions L&eacute;gales');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('mentionlegale/indexSuperAdmin.tpl');
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
			$smarty->assign('titre','Mentions L&eacute;gales');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('mentionlegale/indexAdmin.tpl');
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
			$form    = $this->_getMentionLegaleForm($id);
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					if($id==0){
						$nb = $model->countEntries();
						$dataform['ordre'] = $nb+1;
					}
					$model->save($id,$dataform);
					if ($log->_getTypeConnected('admin')) {
						return $this->_helper->redirector('indexadmin');
					} elseif ($log->_getTypeConnected('superadmin')){
						return $this->_helper->redirector('indexsuperadmin');
					}
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			
			if($id > 0)
				$smarty->assign('title','Modification Mention L&eacute;gale');
			else
				$smarty->assign('title', 'Ajout Mention L&eacute;gale');
			
			$smarty->assign('form', $form);
			$smarty->display('mentionlegale/form.tpl');
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
						$model->save($mention['idMentionLegale'], $mention);
						$ordre++;
					}
				}
				
				
			}
			if ($log->_getTypeConnected('admin')) {
				return $this->_helper->redirector('indexadmin');
			} elseif ($log->_getTypeConnected('superadmin')){
				return $this->_helper->redirector('indexsuperadmin');
			}
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
			
			$model->save($data['idMentionLegale'], $data);
			$model->save($mention['idMentionLegale'], $mention);
			
			$smarty = Zend_Registry::get('view');
	
			$datas   = $model->fetchEntriesOrderByOrdre();
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('titre','Mentions L&eacute;gales');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			if ($log->_getTypeConnected('admin')) {
				$smarty->display('mentionlegale/indexAdmin.tpl');
			} elseif ($log->_getTypeConnected('superadmin')){
				$smarty->display('mentionlegale/indexSuperAdmin.tpl');
			}
			
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
	}

    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/MentionLegale.php';
            $this->_model = new Model_MentionLegale();
        }
        return $this->_model;
    }

    protected function _getMentionLegaleForm($id)
    {
        require_once APPLICATION_PATH . '/forms/MentionLegale.php';
        $form = new Form_MentionLegale();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
