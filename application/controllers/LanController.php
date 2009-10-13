<?php

class LanController extends Zend_Controller_Action 
{
	
	protected $_model;
	protected $_modelLanJeux;
	protected $_modelLanJoueur;
	protected $_modelLanJeuxJoueurTeam;
	
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
		$smarty->assign('base_url', $request->getBaseUrl());
		
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
			$modelLanJoueur=$this->_getModelLanJoueur();
			$model=$this->_getModel();
			$id = $request->getParam('id',0);
			
			if($id==0) {
				$lans = $modelLanJoueur->fetchEntriesByJoueur($log->_getUser());
	
				$smarty->assign('lans', $lans);
				$smarty->assign('title','Mes Lans');
				$smarty->display('lan/indexJoueur.tpl');
			} else {
				
				$modelLanJeux = $this->_getModelLanJeux();
				$modelLanJeuxJoueurTeam = $this->_getModelLanJeuxJoueurTeam();
				
				$lan=$model->fetchEntryField($id,array('idLan', 'nom', 'adresse', 'ville'));
				// recuperation des jeus où le joueur s'est inscrit
				$jeux = $modelLanJeuxJoueurTeam->fetchEntriesJeuxByLan($id);
				$jeux_libres = $modelLanJeuxJoueurTeam->fetchEntriesJeuxLibresByLanJoueur($id, $log->_getUser());
				if(sizeof($jeux_libres)>0)
					$jeuxlibres = 1;
				else
					$jeuxlibres=0;
				
				$smarty->assign('jeux_libres', $jeuxlibres);
				
				//$smarty->assign('test', $test);
				$smarty->assign('title','Lan '.$lan['nom']);
				
				$smarty->assign('lan', $lan);
				$smarty->assign('jeux', $jeux);
				$smarty->assign('urladdjeu', $request->getBaseUrl().'/inscription/ajoutjeu');
				
				$smarty->display('lan/indexJoueurLan.tpl');
			}
				
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
	
	public function viewinscritsAction()
	{
		$smarty = Zend_Registry::get('view');
		$request = $this->getRequest();
		$id =(int)$request->getParam('id', 0);
		if($id>0) {
		
			$model  = $this->_getModel();
			$modelLanJoueur = $this->_getModelLanJoueur();
			$modelLanJeuxJoueurTeam = $this->_getModelLanJeuxJoueurTeam();
			
			
			$lan = $model->fetchEntryField($id,array('idLan', 'nom', 'adresse', 'ville'));
			
			require('../library/My/GoogleMapAPI.class.php');
			$map = new GoogleMapAPI('map');
			$map->setAPIKey('ABQIAAAADNrtNEKC87esbJai0XIwcRRi_j0U6kJrkFvY4-OX2XYmEAa76BQZy_oGZ_TMY1xEDUSKVtQEddHTnA');

			$map->setHeight("500");
			$map->setWidth("830");
			$map->disableTypeControls();
			$map->setMapType('map');
			$map->disableDirections();
			$map->disableZoomEncompass();
			$map->setZoomLevel(8);
			$map->disableOverviewControl();
			
			$joueurs = $modelLanJoueur->fetchEntriesByLanField($id, array('idCompte', 'login', 'cp', 'ville'));
			$jeux = null;
			foreach($joueurs as $j) {
				$jeux[$j['idCompte']] = $modelLanJeuxJoueurTeam->fetchEntriesByLanJoueur_Jeux($lan['idLan'],$j['idCompte']);
				$map->addMarkerByAddress( $j['ville'].' '.$j['cp'], $j['login'], "", $j['login']);
				$map->addMarkerIcon($request->getBaseUrl().'/images/admin/users.png',$request->getBaseUrl().'/images/admin/users.png',0,0,10,10);
			}
			
			
			$map->addMarkerByAddress( $lan['ville'], $lan['nom'], "", $lan['nom']);
			$map->addMarkerIcon($request->getBaseUrl().'/images/admin/computer.png',$request->getBaseUrl().'/images/admin/computer.png',0,0,10,10);

			$smarty->assign('lan', $lan);
			$smarty->assign('base_url', $request->getBaseUrl());
			$smarty->assign('joueurs', $joueurs);
			$smarty->assign('jeux', $jeux);
			$smarty->assign('map', $map);
			$smarty->assign('title', 'Inscrits de la lan '.$lan['nom']);
			$smarty->display('lan/viewinscrits.tpl');
			
		} else {
			return $this->_helper->redirector('index');
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
					$dataform['datedeb'] = substr($datedeb, 6, 4)."-".substr($datedeb, 3, 2)."-".substr($datedeb, 0, 2)." ".$dataform['heuredeb'].":".$data['minutedeb'].":00";
					$datefin = $dataform['datefin'];
					$dataform['datefin'] = substr($datefin, 6, 4)."-".substr($datefin, 3, 2)."-".substr($datefin, 0, 2)." ".$dataform['heurefin'].":".$data['minutefin'].":00";
					
					if($dataform['inscription']==1) {
						$d=new Zend_Date();
						$dataform['date_inscription'] = $d->toString('YYYY-MM-dd');
					}
					
					$model->save($id,$dataform);
					return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$date = new Zend_Date($data['datedeb']);
					$data['datedeb'] = $date->toString('dd/MM/Y');
					$data['heuredeb'] = $date->toString('H');
					$data['minutedeb'] = $date->toString('mm');
					$datef = new Zend_Date($data['datefin']);
					$data['datefin'] = $datef->toString('dd/MM/Y');
					$data['heurefin'] = $datef->toString('H');
					$data['minutefin'] = $datef->toString('mm');
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
	
	protected function _getModelLanJoueur()
    {
        if (null === $this->_modelLanJoueur) {
            require_once APPLICATION_PATH . '/models/LanJoueur.php';
            $this->_modelLanJoueur = new Model_LanJoueur();
        }
        return $this->_modelLanJoueur;
    }
	
	protected function _getModelLanJeux()
    {
        if (null === $this->_modelLanJeux) {
            require_once APPLICATION_PATH . '/models/LanJeux.php';
            $this->_modelLanJeux = new Model_LanJeux();
        }
        return $this->_modelLanJeux;
    }
	
	protected function _getModelLanJeuxJoueurTeam()
    {
        if (null === $this->_modelLanJeuxJoueurTeam) {
            require_once APPLICATION_PATH . '/models/LanJeuxJoueurTeam.php';
            $this->_modelLanJeuxJoueurTeam = new Model_LanJeuxJoueurTeam();
        }
        return $this->_modelLanJeuxJoueurTeam;
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