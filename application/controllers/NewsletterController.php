<?php

class NewsletterController extends Zend_Controller_Action 
{
    protected $_model;
	protected $_modelype;
	protected $_modelConfig;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$smarty->display('newsletter/index.tpl');
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
			$smarty->assign('title','Newsletter');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('newsletter/indexAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }

    public function formAction()
    {
		$smarty  = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')) {
			$request = $this->getRequest();
			$id      = (int)$request->getParam('id', 0);
			$form    = $this->_getNewsletterForm($id);
			$model   = $this->_getModel();
			$modelType = $this->_getModelType();
			$types = $modelType->fetchEntries();
			$form->RemplirType($types);
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$this->sendMail($form->getValues());
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
				$smarty->assign('title','Lire Newsletter');
			else
				$smarty->assign('title', 'Envoyer Newsletter');
			
			$smarty->assign('form', $form);
			$smarty->display('newsletter/form.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	public function delAction()
    {
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')) {
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
            require_once APPLICATION_PATH . '/models/Newsletter.php';
            $this->_model = new Model_Newsletter();
        }
        return $this->_model;
    }
	
	protected function _getModelType()
	{
		if (null === $this->_modelype) {
            require_once APPLICATION_PATH . '/models/NewsletterType.php';
            $this->_modelype = new Model_NewsletterType();
        }
        return $this->_modelype;
    }
	
	protected function _getModelConfig()
	{
		if (null === $this->_modelConfig) {
			require_once APPLICATION_PATH . '/models/Config.php';
			$this->_modelConfig = new Model_Config();
		}
		return $this->_modelConfig;
	}

    protected function _getNewsletterForm($id)
    {
        require_once APPLICATION_PATH . '/forms/Newsletter.php';
        $form = new Form_Newsletter();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
	
	protected function sendMail($form)
	{
		$modelConfig = $this->_getModelConfig();
		$config = $modelConfig->fetchEntrySetting('mail');
		
		/*$conf = array('auth' => 'login',
                'username' => 'maxime.me',
                'password' => '123apple098');

		$transport = new Zend_Mail_Transport_Smtp('smtp.gmail.com', $conf);
		Zend_Mail::setDefaultTransport($transport);
		
		$mail = new Zend_Mail();
		$mail->setBodyText('test');
		$mail->setFrom('maxime.me@gmail', 'Mont Notre Dame');
		$mail->addTo('maxime.me@gmail.com', 'Some Recipient');
		$mail->setSubject('te');
		$mail->send($transport);	*/
	}
}
