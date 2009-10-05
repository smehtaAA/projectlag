<?php

class LanController extends Zend_Controller_Action 
{
	
	protected $_model;
	protected $_modelLanJeux;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');			
		$model  = $this->_getModel();
		$modelLanJeux = $this->_getModelLanJeux();
		$request = $this->getRequest();
		$lans  = $model->fetchEntriesorderByDate();
		
		foreach($lans as $lan)
		{			
			$chiffre[$lan['idLan']]['insc'] = $model->fetchEntriesCount($lan['idLan']);
			$chiffre[$lan['idLan']]['present'] = $model->fetchEntriesCountPresent($lan['idLan']);
			$jeux[$lan['idLan']] = $modelLanJeux->fetchEntriesByLan($lan['idLan']);
		}
		
		$smarty->assign('lans', $lans);
		$smarty->assign('chiffre', $chiffre);
		$smarty->assign('jeux', $jeux);
		$smarty->assign('titre', 'Lans');
		
		$smarty->display('lan/index.tpl');
	}
	
    public function indexadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntriesorderByDate();
			$request = $this->getRequest();
			
			foreach($datas as $lan)
			{
				
				$chiffre[$lan['idLan']][0]['insc'] = $model->fetchEntriesCount($lan['idLan']);
				$chiffre[$lan['idLan']][0]['valide'] = $model->fetchEntriesCountValide($lan['idLan']);
				$chiffre[$lan['idLan']][0]['teams']= $model->fetchEntriesCountTeam($lan['idLan']);
				$chiffre[$lan['idLan']][0]['jeux'] = $model->fetchEntriesCountJeux($lan['idLan']);
			}
			
			
			$smarty->assign('baseurl',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('chiffre', $chiffre);
			$smarty->assign('title','Lan');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			
			$smarty->assign('urlinscrits',$request->getBaseUrl().'/lanjeuxjoueurteam/viewinscrits?idLan=');
			$smarty->assign('urlteams',$request->getBaseUrl().'/lanjeuxjoueurteam/viewteams?idLan=');
			$smarty->assign('urljeux',$request->getBaseUrl().'/lanjeux/indexadmin?idLan=');
			$smarty->assign('urldescription',$request->getBaseUrl().'/lan/description?idLan=');
			
			$smarty->assign('datas',$datas);
			$smarty->display('lan/indexAdmin.tpl');
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
			
			$smarty->assign('title','Accueil');
			$smarty->display('accueil/indexAdmin.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
	
	public function descriptionAction()
	{
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$modelLanJeux = $this->_getModelLanJeux();
			$request = $this->getRequest();
			$id      = (int)$request->getParam('idLan', 0);
			$lan = $model->fetchEntry($id);
			
			$chiffre['insc'] = $model->fetchEntriesCount($lan['idLan']);
			$chiffre['present'] = $model->fetchEntriesCountPresent($lan['idLan']);
			$jeux = $modelLanJeux->fetchEntriesByLan($lan['idLan']);
			
			$smarty->assign('lan', $lan);
			$smarty->assign('chiffre', $chiffre);
			$smarty->assign('jeux', $jeux);
			$smarty->assign('titre', 'Lan '.$lan['nom']);
			$smarty->display('lan/description.tpl');
			
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
			$form    = $this->_getLanForm($id);
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					$datedeb = $dataform['datedeb'];
					$dataform['datedeb'] = substr($datedeb, 6, 4)."-".substr($datedeb, 3, 2)."-".substr($datedeb, 0, 2)." 00:00:00";
					$datefin = $dataform['datefin'];
					$dataform['datefin'] = substr($datefin, 6, 4)."-".substr($datefin, 3, 2)."-".substr($datefin, 0, 2)." 00:00:00";
					$model->save($id,$dataform);
					return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$date = new Zend_Date($data['datedeb']);
					$data['datedeb'] = $date->toString('dd/MM/Y');
					$datef = new Zend_Date($data['datefin']);
					$data['datefin'] = $datef->toString('dd/MM/Y');
					$form->populate($data);
				}
			}
			
			if($id > 0)
				$smarty->assign('title','Modification Lan');
			else
				$smarty->assign('title', 'Ajout Lan');
			
			$smarty->assign('form', $form);
			$smarty->display('lan/form.tpl');
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
            require_once APPLICATION_PATH . '/models/Lan.php';
            $this->_model = new Model_Lan();
        }
        return $this->_model;
    }
	
	protected function _getModelLanJeux()
    {
        if (null === $this->_modelLanJeux) {
            require_once APPLICATION_PATH . '/models/LanJeux.php';
            $this->_modelLanJeux = new Model_LanJeux();
        }
        return $this->_modelLanJeux;
    }


    protected function _getLanForm($id)
    {
        require_once APPLICATION_PATH . '/forms/Lan.php';
        $form = new Form_Lan();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
	
}