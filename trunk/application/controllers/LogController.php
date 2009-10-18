<?php

class LogController extends Zend_Controller_Action 
{
    protected $_model;
	protected $_modelFonctionCompte;

	protected function connexion($userid,$type)
	{
		$defaultNamespace = new Zend_Session_Namespace();
		$defaultNamespace->userid = $userid;
		$defaultNamespace->type = $type;
		$defaultNamespace->interface_admin = false;
	}
	
	public function indexAction()
    {
        $smarty  = Zend_Registry::get('view');
		$request = $this->getRequest();
		$smarty->assign('title', 'Connexion');
		$defaultNamespace = new Zend_Session_Namespace();
		
		if(Zend_Session::sessionExists() && empty($defaultNamespace->userid)) {
			$form  = $this->_getLogForm();
			$model = $this->_getModel();
			$modelFonctionCompte = $this->_getModelFonctionCompte();
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					$dataform['password'] = sha1('l@g8?'.$dataform['password'].'pe6r!e8');
					$dataform['login'] = utf8_decode($dataform['login']);
					$existlog = $model->existLog($dataform);
					if($existlog != NULL) {
						$userid = 'idCompte';
						$fonction = $modelFonctionCompte->fetchFonction($existlog[$userid]);
						$min=200;
						foreach($fonction as $f) {
							if($f['ordre']<$min) {
								$min = $f['ordre'];
								$nom = $f['nom'];
							}
						}
						$this->connexion($existlog[$userid],$nom);
						return $this->_redirect('/accueil/index');
					} else {
						$message = "Erreur de connexion : votre login ou mot de passe n'est pas valide. Vous n'avez peut &ecirc;tre pas encore activ&eacute; votre compte via le mail que vous avez re&ccedil;u lors de votre inscription.";
						$smarty->assign('message', $message);
						$smarty->display('error/errorconnexion.tpl');
						return NULL;
					}
				}
			}

			$smarty->assign('form',$form);
			$smarty->display('log/form.tpl');
		} else {
			$smarty->assign('message', 'Vous êtes déjà connecté');
			$smarty->display('error/errorconnexion.tpl');
		}        
    }
	
	public function deconnexionAction()
	{
		if(Zend_Session::sessionExists()) {
			$defaultNamespace = new Zend_Session_Namespace();
			$defaultNamespace->userid = '';
			$defaultNamespace->type = '';
			$defaultNamespace->interface_admin = '';
			Zend_Session::destroy();
			return $this->_redirect('/accueil/index');
		}
	}
	
	protected function _getModel()
    {
		require_once APPLICATION_PATH . '/models/Compte.php';
		$this->_model = new Model_Compte();

        return $this->_model;
    }

	protected function _getModelFonctionCompte()
    {
		require_once APPLICATION_PATH . '/models/FonctionCompte.php';
		$this->_modelFonctionCompte = new Model_FonctionCompte();

        return $this->_modelFonctionCompte;
    }
	
	public function _getLogForm()
	{
		require_once APPLICATION_PATH . '/forms/Log.php';
        $form = new Form_Log();
		$form->setAction($this->_helper->url('index'));
        return $form;
	}
		
	public function _getTypeConnected($type)
	{
		$isconnected = false;
		$defaultNamespace = new Zend_Session_Namespace();
		if(Zend_Session::sessionExists() && $defaultNamespace->type == $type) {
			$isconnected = true;
		}
		return $isconnected;
	}
}