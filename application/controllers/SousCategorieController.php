<?php

class SousCategorieController extends Zend_Controller_Action 
{
	protected $_model;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$smarty->display('forum/souscategorie/index.tpl');
	}
	
    public function indexsuperadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			$smarty->assign('title','Sous Categorie');
			$smarty->display('forum/souscategorie/indexSuperAdmin.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
	
	public function indexadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')) {
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
						$nb = $model->countEntries();
						$dataform['ordre'] = $nb+1;
					}
					$dataform['idCategorie'] = $idCat;
					$model->save($id,$dataform);
					if($log->_getTypeConnected('superadmin'))
						return $this->_helper->redirector('indexsuperadmin','categorie');
					else
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
	
	protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/SousCategorie.php';
            $this->_model = new Model_SousCategorie();
        }
        return $this->_model;
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
  
}