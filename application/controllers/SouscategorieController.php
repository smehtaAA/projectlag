<?php

class SousCategorieController extends Zend_Controller_Action 
{
	protected $_model;
	protected $_modelSujet;
	protected $_modelCompte;
	protected $_modelCategorie;
	protected $_modelMessage;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$request = $this->getRequest();
		$id = $request->getParam('id',0);
		if($id>0) {
			$modelSousCategorie = $this->_getModel();
			$modelSujet = $this->_getModelSujet();
			$modelCompte = $this->_getModelCompte();
			$modelCategorie = $this->_getModelCategorie();
			$modelMessage = $this->_getModelMessage();
			$log = new SessionLAG();
			if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')||$log->_getTypeConnected('joueur'))
				$login=$modelCompte->fetchEntryForum($log->_getUser());
			else
				$login=0;
			
			$nb=null;
			$last_messages=null;
			$sujets=$modelSujet->fetchEntryBySousCategorie($id);
			foreach ($sujets as $s) {
				
				$nb[$s['idSujet']]['reponses'] = $modelMessage->countEntriesBySujet($s['idSujet']);
				$last_messages[$s['idSujet']] = $modelMessage->fetchEntryLastBySujet($s['idSujet']);
				
			}
			
			
			
			$souscat = $modelSousCategorie->fetchEntryL($id);
			
			$categorie = $modelCategorie->fetchEntryField($souscat['idCategorie'], array('idCategorie', 'titre'));
			
			$fil_arianne['cat'] = array('id'=>$categorie['idCategorie'], 'nom'=>$categorie['titre']);
			$fil_arianne['sscat'] = array('id'=>$souscat['idSousCategorie'],'nom'=>$souscat['titre']);
			
			$smarty->assign('fil_arianne', $fil_arianne);
			$smarty->assign('nb', $nb);
			$smarty->assign('last_messages', $last_messages);
			$smarty->assign('base_url', $request->getBaseUrl());
			$smarty->assign('sujets', $sujets);
			$smarty->assign('login', $login);
			$smarty->assign('souscat', $souscat);
			$smarty->assign('url_addsujet', $request->getBaseUrl().'/sujet/form?idSsCat='.$id);
			$smarty->assign('url_viewsujet', $request->getBaseUrl().'/sujet/index?id=');
			
			$smarty->display('forum/souscategorie/index.tpl');
		} else{
			return $this->_helper->redirector('index', 'forum');
		}
	}
	
    public function indexadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Sous Categorie');
			$smarty->display('forum/souscategorie/indexAdmin.tpl');
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
			$idCat   = (int)$request->getParam('idCat', 0);
			$form    = $this->_getCategorieForm($id,$idCat);
			$model   = $this->_getModel();
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					if($id==0){
						$nb = $model->countEntriesbyCategorie($idCat);
						$dataform['ordre'] = $nb+1;
					}
					$dataform['idCategorie'] = $idCat;
					$model->save($id,$dataform);
					return $this->_helper->redirector('indexadmin','categorie');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			if($id > 0)
				$smarty->assign('title','Modification SousCategorie');
			else
				$smarty->assign('title', 'Ajout SousCategorie');
			
			$smarty->assign('form', $form);
			$smarty->display('forum/souscategorie/form.tpl');
		
		
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
						$model->save($mention['idSousCategorie'], $mention);
						$ordre++;
					}
				}
				
				
			}
			return $this->_helper->redirector('indexadmin','categorie');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/SousCategorie.php';
            $this->_model = new Model_SousCategorie();
        }
        return $this->_model;
    }
	
	protected function _getModelCategorie()
    {
        if (null === $this->_modelCategorie) {
            require_once APPLICATION_PATH . '/models/Categorie.php';
            $this->_modelCategorie = new Model_Categorie();
        }
        return $this->_modelCategorie;
    }
	
	protected function _getModelCompte()
    {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }
	
	protected function _getCategorieForm($id,$idCat)
    {
        require_once APPLICATION_PATH . '/forms/Categorie.php';
        $form = new Form_Categorie();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?idCat='.$idCat.'&id='.$id));
		else
			$form->setAction($this->_helper->url('form?idCat='.$idCat));
        return $form;
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