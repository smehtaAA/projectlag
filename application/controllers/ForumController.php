<?php

class ForumController extends Zend_Controller_Action 
{
	
	protected $_modelCategorie;
	protected $_modelSousCategorie;
	protected $_modelSujet;
	protected $_modelMessage;
	protected $_modelConfig;
	protected $_modelCompte;
	protected $_modelLecture;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$modelConfig = $this->_getModelConfig();
		
		$forum_ouvert = $modelConfig->fetchEntrySetting('ouverture_forum');
		
		if ($forum_ouvert['valeur'] == 1) {
			$request = $this->getRequest();
			$modelCategorie = $this->_getModelCategorie();
			$modelSousCategorie = $this->_getModelSousCategorie();
			$modelSujet = $this->_getModelSujet();
			$modelMessage = $this->_getModelMessage();
			$modelCompte = $this->_getModelCompte();
			$modelLecture = $this->_getModelLecture();
			
			$forum_ouvert['valeur'] = 0;
			$nb=null;
			$last_messages=null;
			$sscat=null;

			$log = new SessionLAG();
			
			if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')||$log->_getTypeConnected('joueur'))
				$login=$modelCompte->fetchEntryForum($log->_getUser());
			else
				$login=0;
			
			if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
				$categories=$modelCategorie->fetchEntriesVisiblesAdmin();
				$stats['nb_messages'] = $modelMessage->countEntries();
				$stats['nb_sujets'] = $modelSujet->countEntries();
				$stats['nb_sscat'] = $modelSousCategorie->countEntries();
				$stats['nb_cat'] = $modelCategorie->countEntries();
			} else {
				$categories=$modelCategorie->fetchEntriesVisibles();
				$stats['nb_messages'] = $modelMessage->countEntriesNonAdmin();
				$stats['nb_sujets'] = $modelSujet->countEntriesNonAdmin();
				$stats['nb_sscat'] = $modelSousCategorie->countEntriesNonAdmin();
				$stats['nb_cat'] = $modelCategorie->countEntriesNonAdmin();
			}
			foreach ($categories as $cat) {
				$forum_ouvert['valeur'] = 1;
				if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
					$sscat[$cat['idCategorie']] = $modelSousCategorie->fetchEntryByCategorieVisiblesAdmin($cat['idCategorie']);
				} else {
					$sscat[$cat['idCategorie']] = $modelSousCategorie->fetchEntryByCategorieVisibles($cat['idCategorie']);
				}
				
				foreach ($sscat[$cat['idCategorie']] as $sc) {
					$nb[$sc['idSousCategorie']]['nb_sujets'] = $modelSujet->countEntriesbySousCategorie($sc['idSousCategorie']);
					$nb_message = $modelMessage->countEntriesbySsCat($sc['idSousCategorie']);
					$nb[$sc['idSousCategorie']]['nb_reponses'] = $nb_message-$nb[$sc['idSousCategorie']]['nb_sujets'];
					$last_messages[$sc['idSousCategorie']] = $modelMessage->fetchEntryLast($sc['idSousCategorie']);
					$lecture[$sc['idSousCategorie']] = 1;
					if(($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')||$log->_getTypeConnected('joueur')) && $nb[$sc['idSousCategorie']]['nb_sujets'] != 0) {
						$lecture[$sc['idSousCategorie']] = $modelLecture->fetchEntriesByCompteAndSousCategorie($log->_getUser(),$sc['idSousCategorie']);	
						if($nb[$sc['idSousCategorie']]['nb_sujets']>$lecture[$sc['idSousCategorie']])
							$lecture[$sc['idSousCategorie']]=0;
					}		
				}
			}
			
			// Recuperation Stats Forum
			$stats['nb'] = $modelCompte->countEntriesActif();
			$stats['last'] = $modelCompte->fetchEntryLast();
			$stats['log'] = $modelCompte->fetchEntriesLogField(time()-900, array('login'));
			
			$smarty->assign('lecture', $lecture);
			$smarty->assign('sscat', $sscat);
			$smarty->assign('login', $login);
			$smarty->assign('last_messages', $last_messages);
			$smarty->assign('url_cat', $request->getBaseUrl().'/categorie?id=');
			$smarty->assign('url_sscat', $request->getBaseUrl().'/souscategorie?id=');
			$smarty->assign('nb', $nb);
			$smarty->assign('stats', $stats);
			$smarty->assign('categories', $categories);
			$smarty->assign('base_url', $request->getBaseUrl());
		}
		$smarty->assign('forum_ouvert', $forum_ouvert);
		
		$smarty->display('forum/index.tpl');
	}
	
    public function indexadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Forum');
			$smarty->display('forum/indexAdmin.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
	
	protected function _getModelCategorie() {
		if (null === $this->_modelCategorie) {
			require_once APPLICATION_PATH . '/models/Categorie.php';
			$this->_modelCategorie = new Model_Categorie();
		}
		return $this->_modelCategorie;
	}
	
	protected function _getModelSousCategorie() {
		if (null === $this->_modelSousCategorie) {
			require_once APPLICATION_PATH . '/models/SousCategorie.php';
			$this->_modelSousCategorie = new Model_SousCategorie();
		}
		return $this->_modelSousCategorie;
	}
	
	protected function _getModelSujet() {
		if (null === $this->_modelSujet) {
			require_once APPLICATION_PATH . '/models/Sujet.php';
			$this->_modelSujet = new Model_Sujet();
		}
		return $this->_modelSujet;
	}

	protected function _getModelConfig() {
		if (null === $this->_modelConfig) {
			require_once APPLICATION_PATH . '/models/Config.php';
			$this->_modelConfig = new Model_Config();
		}
		return $this->_modelConfig;
	}
	
	protected function _getModelMessage() {
		if (null === $this->_modelMessage) {
			require_once APPLICATION_PATH . '/models/Message.php';
			$this->_modelMessage = new Model_Message();
		}
		return $this->_modelMessage;
	}
	
	protected function _getModelCompte() {
		if (null === $this->_modelCompte) {
			require_once APPLICATION_PATH . '/models/Compte.php';
			$this->_modelCompte = new Model_Compte();
		}
		return $this->_modelCompte;
	}
	
	protected function _getModelLecture() {
		if (null === $this->_modelLecture) {
			require_once APPLICATION_PATH . '/models/Lecture.php';
			$this->_modelLecture = new Model_Lecture();
		}
		return $this->_modelLecture;
	}
  
}