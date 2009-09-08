<?php

class BugController extends Zend_Controller_Action 
{
    protected $_model;
	
	public function remerciementAction()
	{
		// Page de remerciement
		$smarty = Zend_Registry::get('view');
		$model  = $this->_getModel();
		$request = $this->getRequest();
		
		
		$smarty->assign('titre', 'Signaler un bug');
		$smarty->assign('base_url', $request->getBaseUrl());
		$smarty->display('bug/remerciement.tpl');
	}
	
	public function indexsuperadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
			$model  = $this->_getModel();
			$request = $this->getRequest();
			$mode      = $request->getParam('mode');
			if($mode=="consult") {
				$datas  = $model->fetchEntriesOrderByPriorityCorrige();
			}else {
				$datas  = $model->fetchEntriesOrderByPriority();
			}
			
			// Affichage des priorités
			$priorite['1'] = 'Urgent';
			$priorite['2'] = 'Haute';
			$priorite['3'] = 'Normal';
			$priorite['4'] = 'Faible';
			$priorite['5'] = 'Aucune';
			$smarty->assign('priorite', $priorite);
			
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('titre','Bugs');
			$smarty->assign('mode', $mode);
			$smarty->assign('urlconsult', 'indexsuperadmin');
			$smarty->assign('urlupd','resoudre/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('bug/indexSuperAdmin.tpl');
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
			$request = $this->getRequest();
			$mode      = $request->getParam('mode');
			if($mode=="consult") {
				$datas  = $model->fetchEntriesOrderByPriorityCorrige();
			}else {
				$datas  = $model->fetchEntriesOrderByPriority();
			}
			
			// Affichage des priorités
			$priorite['1'] = 'Urgent';
			$priorite['2'] = 'Haute';
			$priorite['3'] = 'Normal';
			$priorite['4'] = 'Faible';
			$priorite['5'] = 'Aucune';
			$smarty->assign('priorite', $priorite);
			
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('titre','Bugs');
			$smarty->assign('mode', $mode);
			$smarty->assign('urlconsult', 'indexadmin');
			$smarty->assign('urlupd','resoudre/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('bug/indexAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }

    public function formAction()
    {
		$smarty  = Zend_Registry::get('view');
		
			$request = $this->getRequest();
			$id      = (int)$request->getParam('id', 0);
			$log     = new SessionLAG();
			$form    = $this->_getBugForm($id,$log->_getType());
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();		
					$model->save($id,$dataform);
					if ($log->_getTypeConnected('admin')) {
						return $this->_helper->redirector('indexadmin');
					} else {
						return $this->_helper->redirector('remerciement');
					}
				}
			} else {
				if ($id > 0 && $log->_getTypeConnected('admin')) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			
			if($id > 0)
				$smarty->assign('title','Bug');
			else
				$smarty->assign('title', 'Signaler un bug');
			
			$smarty->assign('form', $form);
			$smarty->display('bug/form.tpl');

    }

	public function resoudreAction()
	{
		
			$smarty  = Zend_Registry::get('view');
		
			$request = $this->getRequest();
			$id      = (int)$request->getParam('id', 0);
			$log     = new SessionLAG();
			$form    = $this->_getBugForm($id,$log->_getType());
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();		
					$model->save($id,$dataform);
					if ($log->_getTypeConnected('admin')) {
						return $this->_helper->redirector('indexadmin');
					} else {
						$smarty->display('error/errorconnexion.tpl');
					}
				}
			} else {
				if ($id > 0 && $log->_getTypeConnected('admin')) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			
			if($id > 0)
				$smarty->assign('title','Resoudre un Bug');
			
			$smarty->assign('data', $data);
			$smarty->assign('form', $form);
			$smarty->display('bug/resoudre.tpl');
		
	}

    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/Bug.php';
            $this->_model = new Model_Bug();
        }
        return $this->_model;
    }

    protected function _getBugForm($id, $type)
    {
        require_once APPLICATION_PATH . '/forms/Bug.php';
		
		if ($id > 0 && $type == 'admin')
			Zend_Registry::set('modeform', 'modif');
		else
			Zend_Registry::set('modeform', 'ajout');
		
        $form = new Form_Bug();

		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
			
        return $form;
    }
}
