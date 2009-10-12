<?php

class NewsletterMailController extends Zend_Controller_Action 
{
    protected $_model;

	public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
		$request = $this->getRequest();
			$datas  = $model->fetchEntries();
			// Faire la liste ici
			// création d'un tableau avec smarty et dans ce tableau ajouter une colonne modifier et supprimer
			// je n'ai pas encore gérer le order pour le fetchEntries mais ne pas oublier
			$smarty->assign('title','Newsletter Mail');
			$smarty->assign('base_url', $request->getBaseUrl());
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('newsletter/indexmailAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }

    public function formAction()
    {
		$smarty  = Zend_Registry::get('view');
		$request = $this->getRequest();
		$id      = (int)$request->getParam('id', 0);
		$form    = $this->_getNewsletterMailForm($id);
		$model   = $this->_getModel();
		$log = new SessionLAG();

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
		
		if($id > 0)
			$smarty->assign('title','Modifier Mail Newsletter');
		else
			$smarty->assign('title', 'Ajouter Mail Newsletter');
		
		$smarty->assign('form', $form);
		$smarty->display('newsletter/formmail.tpl');
    }
	
	public function delAction()
    {
		$log = new SessionLAG();
		$smarty  = Zend_Registry::get('view');
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
            require_once APPLICATION_PATH . '/models/NewsletterMail.php';
            $this->_model = new Model_NewsletterMail();
        }
        return $this->_model;
    }

    protected function _getNewsletterMailForm($id)
    {
        require_once APPLICATION_PATH . '/forms/NewsletterMail.php';
        $form = new Form_NewsletterMail();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
