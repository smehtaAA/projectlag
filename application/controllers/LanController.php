<?php

class LanController extends Zend_Controller_Action 
{
	
	protected $_model;
	protected $_modelLanJeux;
	protected $_modelLanJoueur;
	protected $_modelLanJeuxJoueurTeam;
	protected $_modelCompte;
	protected $_modelConfig;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');			
		$model  = $this->_getModel();
		$modelLanJeux = $this->_getModelLanJeux();
		$modelConfig = $this->_getModelConfig();
		$request = $this->getRequest();
		$lans  = $model->fetchEntriesorderByDateField(array('idLan', 'nom', 'datedeb', 'datefin', 'adresse', 'cp', 'ville', 'extra', 'description'));
		$lan_ouverte = $model->fetchEntryOuverteField(array('idLan'));
		
		foreach($lans as $lan)
		{			
			$chiffre[$lan['idLan']]['insc'] = $model->fetchEntriesCountValide($lan['idLan']);
			$chiffre[$lan['idLan']]['present'] = $model->fetchEntriesCountPresent($lan['idLan']);
			if($lan['idLan']==$lan_ouverte['idLan'])
				$chiffre[$lan['idLan']]['pre_inscrit'] = $model->fetchEntriesCountPreInscrits($lan['idLan']);
				
				
			$key_google = $modelConfig->fetchEntrySetting('key_google');
			//$key_google = 'ABQIAAAADNrtNEKC87esbJai0XIwcRRi_j0U6kJrkFvY4-OX2XYmEAa76BQZy_oGZ_TMY1xEDUSKVtQEddHTnA';
				
			
			if($lan['datedeb']>date('Y-m-y h:i:s')) {
				// API Google Map
				require('../library/My/GoogleMapAPI.class.php');
				$map = new GoogleMapAPI('map','driving_directions');
				$map->setMapType('map');
				$map->setAPIKey($key_google['valeur']);
				// fixe les dimensions de la carte
				$map->setHeight("250");
				$map->setWidth("400");
				// gestion des services
				$map->DisableTypeControls();
				$map->DisableDirections();
				$map->disableZoomEncompass();
				$map->disableOverviewControl();
				$map->disableScaleControl();
				$map->setControlSize('small');
				$map->disableMapControls();
				// definition du zoom
				$map->setZoomLevel(8);
				// ajout du marqueur lan sur la carte
				$map->addMarkerByAddress($lan['adresse'].' '.$lan['ville'].' '.$lan['cp'], $lan['nom'], "<span class='rouge'><strong>$lan[nom]</strong></span><br/>$lan[adresse]<br/>$lan[ville] ($lan[cp])", $lan['nom']);
				// utilisation d'un icone different pour la lan
				$map->addMarkerIcon($request->getBaseUrl().'/images/admin/computer_gmap.png',$request->getBaseUrl().'/images/admin/computer_gmap.png',0,0,10,10);
			}
			$jeux[$lan['idLan']] = $modelLanJeux->fetchEntriesByLanField($lan['idLan'], array(''), array(''), array('nom'));
		}
		

		
		$smarty->assign('lan_ouverte', $lan_ouverte);
		$smarty->assign('lans', $lans);
		$smarty->assign('chiffre', $chiffre);
		$smarty->assign('jeux', $jeux);
		$smarty->assign('map', $map);
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
				$modelCompte = $this->_getModelCompte();
				$modelConfig = $this->_getModelConfig();
				
				$lan=$model->fetchEntryField($id,array('idLan', 'nom', 'adresse', 'ville', 'cp', 'adresse'));
				$joueur = $modelCompte->fetchEntryField($log->_getUser(),array('ville', 'cp'));
				// recuperation des jeus o� le joueur s'est inscrit
				$jeux = $modelLanJeuxJoueurTeam->fetchEntriesJeuxByLan($id);
				$jeux_libres = $modelLanJeuxJoueurTeam->fetchEntriesJeuxLibresByLanJoueur($id, $log->_getUser());
				if(sizeof($jeux_libres)>0)
					$jeuxlibres = 1;
				else
					$jeuxlibres=0;
				
				
				$key_google = $modelConfig->fetchEntrySetting('key_google');
				//$key_google = 'ABQIAAAADNrtNEKC87esbJai0XIwcRRi_j0U6kJrkFvY4-OX2XYmEAa76BQZy_oGZ_TMY1xEDUSKVtQEddHTnA';
				// API Google Map
				require('../library/My/GoogleMapAPI.class.php');
				$map = new GoogleMapAPI('map','driving_directions');
				$map->setMapType('map');
				$map->setAPIKey($key_google['valeur']);
				// fixe les dimensions de la carte
				$map->setHeight("500");
				$map->setWidth("500");
				$map->setDirWidth("300");
				// gestion des services
				$map->disableTypeControls();
				$map->disableDirections();
				$map->disableZoomEncompass();
				$map->disableOverviewControl();
				// definition du zoom
				// $map->setZoomLevel(5);
				// gestion de l'itineraire
				$map->enableDrivingDirections();
				$map->setDrivingDirection(array($joueur['ville'].' '.$joueur['cp'], $lan['adresse'].' '.$lan['ville'].' '.$lan['cp']));
				
				$smarty->assign('jeux_libres', $jeuxlibres);
				$smarty->assign('title','Lan '.$lan['nom']);
				$smarty->assign('map', $map);
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
			$modelConfig = $this->_getModelConfig();
			$modelLanJoueur = $this->_getModelLanJoueur();
			$modelLanJeuxJoueurTeam = $this->_getModelLanJeuxJoueurTeam();
			
			$lan = $model->fetchEntryField($id,array('idLan', 'nom', 'adresse', 'ville', 'cp'));
			
			$key_google = $modelConfig->fetchEntrySetting('key_google');
			
			//$key_google = 'ABQIAAAADNrtNEKC87esbJai0XIwcRRi_j0U6kJrkFvY4-OX2XYmEAa76BQZy_oGZ_TMY1xEDUSKVtQEddHTnA';
			
			// API Google Map
			require('../library/My/GoogleMapAPI.class.php');
			$map = new GoogleMapAPI('map');
			$map->setMapType('map');
			$map->setAPIKey($key_google['valeur']);
			// fixe les dimensions de la carte
			$map->setHeight("500");
			$map->setWidth("830");
			// gestion des services
			$map->disableTypeControls();
			$map->disableDirections();
			$map->enableZoomEncompass();
			$map->disableOverviewControl();
			// definition du zoom
			$map->setZoomLevel(8);
			
			$joueurs = $modelLanJoueur->fetchEntriesByLanField($id, array('idCompte', 'login', 'cp', 'ville', 'img'));
			$jeux = null;
			foreach($joueurs as $j) {
				$jeux[$j['idCompte']] = $modelLanJeuxJoueurTeam->fetchEntriesByLanJoueur_Jeux($lan['idLan'],$j['idCompte']);
				// ajout d'un marqueur joueur sur la carte
				$map->addMarkerByAddress( $j['ville'].' '.$j['cp'], $j['login'], "<span class='rouge'><strong>$j[login]</strong></span><br/>$j[ville] ($j[cp])", $j['login']);
				// met cet icone pour le dernier marqueur pos�
				$map->addMarkerIcon($request->getBaseUrl().'/images/comptes/thumb/'.$j['img'],$request->getBaseUrl().'/images/comptes/thumb/'.$j['img'],0,0,10,10);
			}
			
			// ajout du marqueur lan sur la carte
			$map->addMarkerByAddress($lan['adresse'].' '.$lan['ville'].' '.$lan['cp'], $lan['nom'], "<span class='rouge'><strong>$lan[nom]</strong></span><br/>$lan[adresse]<br/>$lan[ville] ($lan[cp])", $lan['nom']);
			// utilisation d'un icone different pour la lan
			$map->addMarkerIcon($request->getBaseUrl().'/images/admin/computer_gmap.png',$request->getBaseUrl().'/images/admin/computer_gmap.png',0,0,10,10);

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
					
					$dataform['nom'] = utf8_decode($dataform['nom']);
					
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
					$data['nom'] = utf8_encode($data['nom']);
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
	
	protected function _getModelCompte()
    {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }
	
	protected function _getModelConfig()
    {
        if (null === $this->_modelConfig) {
            require_once APPLICATION_PATH . '/models/Config.php';
            $this->_modelConfig = new Model_Config();
        }
        return $this->_modelConfig;
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