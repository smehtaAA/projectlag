<?php

class MessageController extends Zend_Controller_Action 
{
	protected $_model;
	protected $_modelMessage;
	protected $_modelCompte;
	protected $_modelGrade;
	
	public function indexAction()
	{
		/*$smarty = Zend_Registry::get('view');
		$request = $this->getRequest();
		*/
		return $this->_helper->redirector('index', 'forum');

	}
	
    public function indexadminAction() 
    {
		/*$smarty = Zend_Registry::get('view');
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
		*/
		return $this->_helper->redirector('index', 'forum');
    }
	
	public function formAction()
	{
		$smarty  = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')||$log->_getTypeConnected('joueur')) {
			$request = $this->getRequest();
			$id      = (int)$request->getParam('id', 0);
			$idSujet   = (int)$request->getParam('idSujet', 0);
			$form    = $this->_getMessageForm($id,$idSujet);
			$modelMessage   = $this->_getModelMessage();
			$modelCompte = $this->_getModelCompte();
			$modelGrade   = $this->_getModelGrade();
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					$dataform['idSujet'] = $idSujet;
					$dataform['idCompte'] = $log->_getUser();
					$modelMessage->save($id,$dataform);
					
					$nb_messages = $modelMessage->countEntriesByCompte($log->_getUser());
					if($log->_getTypeConnected('joueur') && $nb_messages!=-1) {
						$new_grade = $modelGrade->fetchEntryByNbMessages($nb_messages);
						$compte['idGrade']=$new_grade['idGrade'];
						$modelCompte->save($log->_getUser(), $compte);
					}
					
					return $this->_helper->redirector('index','sujet','',array('id'=>$idSujet));
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')||$data['idCompte']==$log->_getUser()) {
						$form->populate($data);
					} else {
						$smarty->display('error/errorconnexion.tpl');
					}
				}
			}
			
			if($id > 0)
				$smarty->assign('title','Modification Sujet');
			else
				$smarty->assign('title', 'Ajout Message');
			
			$smarty->assign('form', $form);
			$smarty->display('forum/message/form.tpl');
		
		
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
				$model = $this->_getModelMessage();
				$modelGrade = $this->_getModelGrade();
				$modelCompte = $this->_getModelCompte();
				$data = $model->fetchEntry($id);
				$model->delete($id);
				
				$nb_messages = $model->countEntriesByCompte($data['idCompte']);
				if($nb_messages!=-1) {
					$new_grade = $modelGrade->fetchEntryByNbMessages($nb_messages);
					$compte['idGrade']=$new_grade['idGrade'];
					$modelCompte->save($data['idCompte'], $compte);
				}
			}
			return $this->_helper->redirector('index','sujet','',array('id'=>$data['idSujet']));
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/Sujet.php';
            $this->_model = new Model_Sujet();
        }
        return $this->_model;
    }
	
	protected function _getModelMessage()
    {
        if (null === $this->_modelMessage) {
            require_once APPLICATION_PATH . '/models/Message.php';
            $this->_modelMessage = new Model_Message();
        }
        return $this->_modelMessage;
    }
	
	protected function _getModelCompte()
    {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }
	
	protected function _getModelGrade()
    {
        if (null === $this->_modelGrade) {
            require_once APPLICATION_PATH . '/models/Grade.php';
            $this->_modelGrade = new Model_Grade();
        }
        return $this->_modelGrade;
    }
	
	protected function _getMessageForm($id,$idSujet)
    {
        require_once APPLICATION_PATH . '/forms/Message.php';
        $form = new Form_Message();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?idSujet='.$idSujet.'&id='.$id));
		else
			$form->setAction($this->_helper->url('form?idSujet='.$idSujet));
        return $form;
    }
}