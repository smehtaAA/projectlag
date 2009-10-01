<?php

class InscriptionController extends Zend_Controller_Action 
{
	
	protected $_modelLan;
	protected $_modelCharte;
	protected $_modelCompte;
	protected $_modelLanJoueur;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$modelLan = $this->_getModelLan();
		$request = $this->getRequest();
		
		$lan = $modelLan->fetchEntryOuverte();
		
		if($lan==-1) {
			$smarty->assign('titre', 'Aucune Inscription n\'est actuellement ouverte');
		} else {
			$modelCharte=$this->_getModelCharte();
			
			$charte = $modelCharte->fetchEntryAsso();
			$articles = $modelCharte->fetchArticlesAsso();
			
			$smarty->assign('articles', $articles);
			$smarty->assign('url_valide', $request->getBaseUrl().'/inscription/inscription');
			$smarty->assign('url_nonvalide', $request->getBaseUrl());
			
			$smarty->assign('titre', 'Inscription pour la lan '.$lan['nom']);
		}
		
		
		
		
		$smarty->display('inscription/index.tpl');
	}
	
	public function inscriptionAction()
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
				$modelCompte->save(0,$dataform);
				$compte = $modelCompte->fetchEntryByLogin($dataform['login']);
				
				$insc['idLan']=$lan['idLan'];
				$insc['idCompte']=$compte['idCompte'];
				$insc['paiement']=0;
				$insc['validation']=false;
				
				$modelLanJoueur->save(0,$insc);
			}
		}
				
			
		$smarty->assign('titre', 'Inscription pour la lan '.$lan['nom']);
		$smarty->assign('form', $form);
		/*
				$smarty  = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')||$log->_getTypeConnected('joueur')) {
			$request = $this->getRequest();
			
			if($log->_getTypeConnected('joueur')) {
				$this->redirection = 'accueil/indexjoueurmenu';
				$id = $log->_getUser();
			} else {
				$this->redirection = 'compte/indexadmin';
				$id = (int)$request->getParam('id', 0);
			}
			
			$form    = $this->_getCompteForm($id, $log->_getType());
			$formmdp = $this->_getMdpForm($id, $log->_getType());
			$model   = $this->_getModel();

			if ($this->getRequest()->isPost()) {
				if($request->getParam('f') != 'mdp') {
					if ($form->isValid($request->getPost())) {
						$dataform=$form->getValues();
						$datenaissance = $dataform['datenaissance'];
						$dataform['datenaissance'] = substr($datenaissance, 6, 4)."-".substr($datenaissance, 3, 2)."-".substr($datenaissance, 0, 2)." 00:00:00";
						$model->save($id,$dataform);
						return $this->_redirect($this->redirection);
					}
				} else {
					if ($formmdp->isValid($request->getPost())) {
						$val         = $formmdp->getValues();
						$val2        = array('password' => md5($val['newpassword']));
						$model->save($id,$val2);
						return $this->_redirect($this->redirection);
					}
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$date = new Zend_Date($data['datenaissance']);
					$data['datenaissance'] = $date->toString('dd/MM/Y');
					$form->populate($data);
				}
			}
			
			if($log->_getTypeConnected('admin')) {
				if($id > 0)
					$smarty->assign('title','Modification Compte');
				else
					$smarty->assign('title', 'Ajout Compte');
			} else {
					$smarty->assign('title', 'Modifier mon compte');
			}			
			
	
			
			$smarty->assign('form', $form);
			$smarty->assign('formmdp', $formmdp);
			$smarty->display('compte/form.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
		*/
		
		$smarty->display('inscription/inscription.tpl');
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
	
	protected function _getModelCharte()
    {
        if (null === $this->_modelCharte) {
            require_once APPLICATION_PATH . '/models/Charte.php';
            $this->_modelCharte = new Model_Charte();
        }
        return $this->_modelCharte;
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
		$form->setAction($this->_helper->url('inscription'));
		return $form;
    }
}