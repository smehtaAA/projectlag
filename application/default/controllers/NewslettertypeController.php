<?php

class NewsletterTypeController extends Zend_Controller_Action 
{
    protected $_model;
    protected $_modelNewsletterMailType;
	
	public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
                        $modelNewsletterMailType = $this->_getModelNewsletterMailType();
			$request = $this->getRequest();
			$datas  = $model->fetchEntries();
                        foreach($datas as $d)
                            $nb[$d['idNewsletterType']] = $modelNewsletterMailType->countEntriesByType($d['idNewsletterType']);


                        // Faire la liste ici
			// création d'un tableau avec smarty et dans ce tableau ajouter une colonne modifier et supprimer
			// je n'ai pas encore gérer le order pour le fetchEntries mais ne pas oublier
                        $smarty->assign('nb', $nb);
			$smarty->assign('title','Type des NewsLetter');
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('urlvoir', $request->getBaseUrl().'/newslettermailtype/indexadmin/?id=');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('newsletter/indextypeAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
	}
	
	public function formAction()
	{
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
			$model  = $this->_getModel();
			$request = $this->getRequest();
			$id = (int) $request->getParam('id', 0);
			
			$form = $this->_getNewsletterTypeForm($id);
			
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$model->save($id,$form->getValues());
					return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			$smarty->assign('title', 'Ajouter un type');
			$smarty->assign('form', $form);
			$smarty->display('newsletter/formtype.tpl');
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
            require_once APPLICATION_PATH . '/models/NewsletterType.php';
            $this->_model = new Model_NewsletterType();
        }
        return $this->_model;
    }

    protected function _getModelNewsletterMailType()
    {
        if (null === $this->_modelNewsletterMailType) {
            require_once APPLICATION_PATH . '/models/NewsletterMailType.php';
            $this->_modelNewsletterMailType = new Model_NewsletterMailType();
        }
        return $this->_modelNewsletterMailType;
    }
	   
	protected function _getNewsletterTypeForm($id)
    {
        require_once APPLICATION_PATH . '/forms/NewsletterType.php';
        $form = new Form_NewsletterType();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
	
}