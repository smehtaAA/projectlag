<?php

class ForumController extends Zend_Controller_Action 
{
	
	protected $_modelCategorie;
	protected $_modelSousCategorie;
	protected $_modelSujet;
	protected $_modelMessage;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$modelCategorie = $this->_getModelCategorie();
		$modelSousCategorie = $this->_getModelSousCategorie();
		$modelSujet = $this->_getModelSujet();
		$modelMessage = $this->_getModelMessage();
		
		$categories=$modelCategorie->fetchEntriesVisibles();
		foreach ($categories as $cat) {
			$sscat[$cat['idCategorie']] = $modelSousCategorie->fetchEntryByCategorieVisibles($cat['idCategorie']);
			
			foreach ($sscat[$cat['idCategorie']] as $sc) {
				$nb[$sc['idSousCategorie']]['nb_sujets'] = $modelSujet->countEntriesbySousCategorie($sc['idSousCategorie']);
				$nb[$sc['idSousCategorie']]['nb_reponses'] = $modelMessage->countEntriesbySujet($sc['idSousCategorie']);
			}
		}
		
		$smarty->assign('sscat', $sscat);
		$smarty->assign('nb', $nb);
		$smarty->assign('categories', $categories);
		
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
	
	protected function _getModelMessage() {
		if (null === $this->_modelMessage) {
			require_once APPLICATION_PATH . '/models/Message.php';
			$this->_modelMessage = new Model_Message();
		}
		return $this->_modelMessage;
	}
  
}