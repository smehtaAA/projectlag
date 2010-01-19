<?php

class JeuxController extends Zend_Controller_Action 
{
	
	protected $_model;
	
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
			$datas  = $model->fetchEntries();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','Jeux');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('jeux/indexAdmin.tpl');
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
			$form    = $this->_getJeuxForm($id);
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					$datesortie = $dataform['datesortie'];
					$dataform['datesortie'] = substr($datesortie, 6, 4)."-".substr($datesortie, 3, 2)."-".substr($datesortie, 0, 2)." 00:00:00";
					if(!empty($dataform["creer_type"]))
						$dataform["type"] = $dataform["creer_type"];
					unset($dataform["creer_type"]);															$dataform["type"] = utf8_decode($dataform["type"]);					$dataform["titre"] = utf8_decode($dataform["titre"]);					
					$model->save($id,$dataform);
					return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$date = new Zend_Date($data['datesortie']);
					$data['datesortie'] = $date->toString('dd/MM/Y');										$dataform["type"] = utf8_encode($dataform["type"]);					$dataform["titre"] = utf8_encode($dataform["titre"]);
					$form->populate($data);
				}
			}
			
			$form->RemplirType($model->fetchEntriesTypes());
			
			if($id > 0)
				$smarty->assign('title','Modification Jeux');
			else
				$smarty->assign('title', 'Ajout Jeux');
			
			$smarty->assign('form', $form);
			$smarty->display('jeux/form.tpl');
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
            require_once APPLICATION_PATH . '/models/Jeux.php';
            $this->_model = new Model_Jeux();
        }
        return $this->_model;
    }

    protected function _getJeuxForm($id)
    {
        require_once APPLICATION_PATH . '/forms/Jeux.php';
        $form = new Form_Jeux();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
	
}