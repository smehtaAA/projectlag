<?php

class InscriptionController extends Zend_Controller_Action 
{
	
	protected $_modelLan;
	protected $_modelCharte;
	protected $_modelCompte;
	protected $_modelLanJoueur;
	protected $_modelFonctionCompte;
	protected $_modelLanJeux;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$modelLan = $this->_getModelLan();
		$request = $this->getRequest();
		
		$lan = $modelLan->fetchEntryOuverte();
		
		if($lan==-1) {
			$smarty->assign('titre', 'Aucune Inscription n\'est actuellement ouverte');
			$smarty->assign('ouverte', false);
		} else {
			$modelCharte=$this->_getModelCharte();
			
			$charte = $modelCharte->fetchEntryAsso();
			$articles = $modelCharte->fetchArticlesAsso();
			$smarty->assign('ouverte', true);
			$smarty->assign('articles', $articles);
			$smarty->assign('url_valide', $request->getBaseUrl().'/inscription/inscription');
			$smarty->assign('url_nonvalide', $request->getBaseUrl());
			
			$smarty->assign('titre', 'Inscription pour la lan '.$lan['nom']);
		}
		
		
		
		
		$smarty->display('inscription/index.tpl');
	}
	
	public function inscriptionAction()
	{
		$log = new SessionLAG();
		if($log->_getTypeConnected('joueur')) {
			return $this->_helper->redirector('inscriptionlan','inscription');
		} else {
			$smarty = Zend_Registry::get('view');
			$request = $this->getRequest();
			$smarty->assign('title', 'Connexion');
			$defaultNamespace = new Zend_Session_Namespace();
			
			if(Zend_Session::sessionExists() && empty($defaultNamespace->userid)) {
				$form  = $this->_getLogForm();
				$model = $this->_getModelCompte();
				$modelFonctionCompte = $this->_getModelFonctionCompte();
		
				if ($this->getRequest()->isPost()) {
					if ($form->isValid($request->getPost())) {
						$existlog = $model->existLog($form->getValues());
						if($existlog != NULL) {
							$userid = 'idCompte';
							$fonction = $modelFonctionCompte->fetchFonction($existlog[$userid]);
							$min=200;
							foreach($fonction as $f) {
								if($f['ordre']<$min) {
									$min = $f['ordre'];
									$nom = $f['nom'];
								}
							}
							$this->connexion($existlog[$userid],$nom);
							return $this->_redirect('/inscription/inscriptionlan');
						} else {
							$form = "Erreur de connexion : votre login ou mot de passe n'est pas valide. Votre compte n'est peut être pas encore activé par un administrateur.";
						}
					}
				}
				$smarty->assign('creer_compte', $request->getBaseUrl().'/inscription/inscriptionmembre');
				$smarty->assign('form',$form);
				$smarty->display('inscription/inscription.tpl');
			}
		}
	}
	
	protected function connexion($userid,$type)
	{
		$defaultNamespace = new Zend_Session_Namespace();
		$defaultNamespace->userid = $userid;
		$defaultNamespace->type = $type;
	}
	
	public function validationAction()
	{
		$smarty = Zend_Registry::get('view');
		$smarty->display('inscription/validation.tpl');
	}
	
	public function inscriptionmembreAction()
	{
		$smarty = Zend_Registry::get('view');
		$modelLan = $this->_getModelLan();
		$request = $this->getRequest();
		$lan = $modelLan->fetchEntryOuverte();
		
		$form    = $this->_getCompteForm();
		
		if ($this->getRequest()->isPost()) {
			if ($form->isValid($request->getPost())) {
				$modelCompte = $this->_getModelCompte();
				$modelLanJoueur = $this->_getModelLanJoueur();
				$dataform=$form->getValues();
				$datenaissance = $dataform['datenaissance'];
				$dataform['datenaissance'] = substr($datenaissance, 6, 4)."-".substr($datenaissance, 3, 2)."-".substr($datenaissance, 0, 2)." 00:00:00";
				$dataform['password'] = 'l@g8?'.md5($dataform['password']).'pe6r!e8';
				$modelCompte->save(0,$dataform);
				
				$compte = $modelCompte->fetchEntryByLogin($dataform['login']);
				
				$modelFonctionCompte = $this->_getModelFonctionCompte();
				$f['idCompte'] = $compte['idCompte'];
				$f['idFonction'] = 3;
				$modelFonctionCompte->save(0,$f);
				
				return $this->_redirect('/inscription/validation');
				
				
				/* Code permettant l'inscription à une LAN
				Ce morceau de code doit etre déplacé à l'endroit voulu
				$compte = $modelCompte->fetchEntryByLogin($dataform['login']);
				$insc['idLan']=$lan['idLan'];
				$insc['idCompte']=$compte['idCompte'];
				$insc['paiement']=0;
				$insc['validation']=false;
				
				$modelLanJoueur->save(0,$insc);
				*/
			}
		}
				
			
		$smarty->assign('titre', 'Inscription pour la lan '.$lan['nom']);
		$smarty->assign('form', $form);
		$smarty->display('inscription/inscriptionMembre.tpl');
	}
	
	public function inscriptionlanAction()
	{
		$log = new SessionLAG();
		if($log->_getTypeConnected('joueur')) {
			$smarty = Zend_Registry::get('view');
			$modelLan = $this->_getModelLan();
			$modelCompte = $this->_getModelCompte();
			$modelLanJeux=$this->_getModelLanJeux();
			$id=$log->_getUser();
			$lan=$modelLan->fetchEntryOuverte();
			$joueur=$modelCompte->fetchEntry($id);
			$jeux=$modelLanJeux->fetchEntriesByLan($lan['idLan']);
			
			$form=$this->_getInscriptionLanForm();
			
			$form->RemplirJeux($jeux);
			
			$smarty->assign('form', $form);
			
			$smarty->assign('lan', $lan);
			$smarty->assign('jeux', $jeux);
			$smarty->assign('joueur', $joueur);
			$smarty->display('inscription/inscriptionlan.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
		
	}
	
	protected function _getModelCompte()
    {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }
	
	protected function _getModelLan()
    {
        if (null === $this->_modelLan) {
            require_once APPLICATION_PATH . '/models/Lan.php';
            $this->_modelLan = new Model_Lan();
        }
        return $this->_modelLan;
    }
	
	protected function _getModelLanJeux()
    {
        if (null === $this->_modelLanJeux) {
            require_once APPLICATION_PATH . '/models/LanJeux.php';
            $this->_modelLanJeux = new Model_LanJeux();
        }
        return $this->_modelLanJeux;
    }
	
	protected function _getModelCharte()
    {
        if (null === $this->_modelCharte) {
            require_once APPLICATION_PATH . '/models/Charte.php';
            $this->_modelCharte = new Model_Charte();
        }
        return $this->_modelCharte;
    }
	
	public function _getLogForm()
	{
		require_once APPLICATION_PATH . '/forms/Log.php';
        $form = new Form_Log();
		$form->setAction($this->_helper->url('inscription'));
        return $form;
	}
	
	protected function _getModelFonctionCompte()
	{
        if (null === $this->_modelFonctionCompte) {
            require_once APPLICATION_PATH . '/models/FonctionCompte.php';
            $this->_modelFonctionCompte = new Model_FonctionCompte();
        }
        return $this->_modelFonctionCompte;
	}
	
	protected function _getModelLanJoueur()
    {
        if (null === $this->_modelLanJoueur) {
            require_once APPLICATION_PATH . '/models/LanJoueur.php';
            $this->_modelLanJoueur = new Model_LanJoueur();
        }
        return $this->_modelLanJoueur;
    }
	
	protected function _getCompteForm()
    {
        require_once APPLICATION_PATH . '/forms/Compte.php';
        Zend_Registry::set('modeform', 'inscription');
		$form = new Form_Compte();
		$form->setAction($this->_helper->url('inscriptionmembre'));
		return $form;
    }
	
	protected function _getInscriptionLanForm()
    {
        require_once APPLICATION_PATH . '/forms/InscriptionLan.php';
		$form = new Form_InscriptionLan();
		$form->setAction($this->_helper->url('inscriptionlan'));
		return $form;
    }
}