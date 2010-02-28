<?php

class Admin_ContactController extends Zend_Controller_Action
{
    protected $_model;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$smarty->assign('urladd','contact/form/');
		$smarty->display('contact/index.tpl');
	}
	
	public function remerciementAction()
	{
		$smarty = Zend_Registry::get('view');
		$smarty->display('contact/remerciement.tpl');
	}
	
	public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntries();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			$smarty->assign('title','Contact');
			$smarty->assign('urlview','view/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('contact/indexAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	public function viewAction()
	{
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
			$model  = $this->_getModel();
			$request  = $this->getRequest();
			$base_url = $request->getBaseUrl();
			$id      = (int)$request->getParam('id', 0);
			$data = $model->fetchEntry($id);
			$smarty->assign('base_url',$base_url);
			$smarty->assign('title','Contact');
			$smarty->assign('data',$data);
			$smarty->display('contact/view.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
	}

    public function formAction()
    {
		$smarty  = Zend_Registry::get('view');
		$request = $this->getRequest();
		$id      = (int)$request->getParam('id', 0);
		$form    = $this->_getContactForm($id);
		$model   = $this->_getModel();		

		if ($this->getRequest()->isPost()) {
			if ($form->isValid($request->getPost())) {
                $data = $form->getValues();
                function decode(&$value) {
                    $value = utf8_decode($value);
                }
                array_walk($data, 'decode');
				$model->save($id,$data);
				$this->sendMail($form->getValues());
				return $this->_helper->redirector('remerciement');
			}
		} 
		else {
			if ($id > 0) {
				return $this->_helper->redirector('form','contact');
			}
		}
		
		if($id > 0)
			$smarty->assign('title','Lire Message');
		else
			$smarty->assign('title', 'Formulaire de Contact');
		
		$smarty->assign('form', $form);
		$smarty->display('contact/form.tpl');
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
	
	protected function sendMail($data)
	{
		// Fonction d'envoi du mail sur association.lag@gmail.com	
		$destinataire = 'association.lag@gmail.com'; 
		$subject = "Contact depuis le site Local Arena Games";
		$from  = "From: Contact <".$data['mail'].">\n";
        $from .= "X-Priority: 1\n";
		$from .= "MIME-version: 1.0\n";
		$from .= "Content-type: text/html; charset=utf-8\n";
        $from .= "Content-Transfer-Encoding: 8bit\n\n";
		$msg = "<html><head></head><body>
				<div style='font: normal 12px Arial;'>
				<b>Contact - Local Arena Games</b><br />
				<b>Email :</b> ".$data['mail']."<br />
				<b>Type :</b> ".$data['type']."<br />
				<b>Titre :</b> ".$data['titre']."<br /><br />
				<b>Description :</b> ".$data['description']."</div>
				</body></html>"; 
		mail($destinataire, $subject, $msg, $from);
	}

    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Contact.php';
            $this->_model = new Model_Contact();
        }
        return $this->_model;
    }

    protected function _getContactForm($id)
    {
        require_once APPLICATION_PATH_COMMONS . '/forms/Contact.php';
        $form = new Form_Contact();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
