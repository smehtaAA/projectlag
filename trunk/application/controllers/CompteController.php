<?php

class CompteController extends Zend_Controller_Action 
{
	
	protected $_model;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$smarty->display('compte/index.tpl');
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
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','Compte');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('compte/indexAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	public function indexjoueurAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('joueur')) {
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			
			
			//$formmdp = $this->_getMdpForm($id, $log->_getType());
			
			
			
			$smarty->assign('titre','Mon Compte');
			$smarty->display('compte/indexJoueur.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }
	
	public function formAction()
    {
		$smarty  = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')||$log->_getTypeConnected('joueur')) {
			$request = $this->getRequest();
			
			if($log->_getTypeConnected('joueur')) {
				$this->redirection = 'accueil/index';
				$id = $log->_getUser();
			} else {
				if($log->_getInterfaceAdmin()) {
					$this->redirection = 'compte/indexadmin';
					$id = (int)$request->getParam('id', 0);
				} else {
					$this->redirection = 'accueil/index';
					$id = $log->_getUser();
				}
			}
			
			$form    = $this->_getCompteForm($id, $log->_getType());
			$formmdp = $this->_getMdpForm($id, $log->_getType());
			$model   = $this->_getModel();

			if ($this->getRequest()->isPost()) {
				if($request->getParam('f') != 'mdp') {
					if ($form->isValid($request->getPost())) {
						$dataform=$form->getValues();
						$datenaissance = $dataform['datenaissance'];
						$dataform['datenaissance'] = substr($datenaissance, 6, 4)."-".substr($datenaissance, 3, 2)."-".substr($datenaissance, 0, 2)." 00:00:00";
						
						if(empty($dataform['img']))
							unset($dataform['img']);
						else {
							$nom_image = $dataform["login"];
							require_once '../library/My/Utils.php';
							$chaine_valide = valideChaine($nom_image);
							$ext = explode('.',$dataform["img"]);
							$ancien_nom = $dataform['img'];
							$dataform['img']=$chaine_valide.'.'.$ext[1];
						}
						
						$dataform['nom'] = utf8_decode($dataform['nom']);
						$dataform['prenom'] = utf8_decode($dataform['prenom']);
						$dataform['jeuxprefere'] = utf8_decode($dataform['jeuxprefere']);
						$dataform['configpc'] = utf8_decode($dataform['configpc']);
						$dataform['citationpreferee'] = utf8_decode($dataform['citationpreferee']);
						$dataform['description'] = utf8_decode($dataform['description']);
						$dataform['ville'] = utf8_decode($dataform['ville']);
						$dataform['login'] = utf8_decode($dataform['login']);
						
						$model->save($id,$dataform);
						
						// resize picture si image dans formulaire
						if(!empty($dataform['img']))
						{
							require_once '../library/My/PhpThumb/ThumbLib.inc.php'; 
							$thumb = PhpThumbFactory::create('../public/images/comptes/tmp/'.$ancien_nom);
							$thumb->resize(100, 100)->save('../public/images/comptes/'.$dataform["img"]);
							$thumb->resize(25, 25)->save('../public/images/comptes/thumb/'.$dataform["img"]);
							if(file_exists('../public/images/comptes/tmp/'.$ancien_nom))
								unlink('../public/images/comptes/tmp/'.$ancien_nom);
						}
						
						return $this->_redirect($this->redirection);
					}
				} else {
					if ($formmdp->isValid($request->getPost())) {
						$val         = $formmdp->getValues();
						$val2['password'] = sha1('l@g8?'.$val['newpassword'].'pe6r!e8');
						$model->save($id,$val2);
						return $this->_redirect($this->redirection);
					}
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$date = new Zend_Date($data['datenaissance']);
					$data['datenaissance'] = $date->toString('dd/MM/Y');
					$data['nom'] = utf8_encode($data['nom']);
					$data['prenom'] = utf8_encode($data['prenom']);
					$data['jeuxprefere'] = utf8_encode($data['jeuxprefere']);
					$data['configpc'] = utf8_encode($data['configpc']);
					$data['citationpreferee'] = utf8_encode($data['citationpreferee']);
					$data['description'] = utf8_encode($data['description']);
					$data['ville'] = utf8_encode($data['ville']);
					$data['login'] = utf8_encode($data['login']);
					$form->populate($data);
					$smarty->assign('img',$data['img']);
				}
			}
			
			if($log->_getTypeConnected('admin')) {
				if($id > 0)
					$smarty->assign('title','Modification Compte');
				else
					$smarty->assign('title', 'Ajout Compte');
			} else {
					$smarty->assign('title', 'Modifier mon compte');
			}			
			
	
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('form', $form);
			$smarty->assign('formmdp', $formmdp);
			$smarty->display('compte/form.tpl');
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
            require_once APPLICATION_PATH . '/models/Compte.php';
            $this->_model = new Model_Compte();
        }
        return $this->_model;
    }

    protected function _getCompteForm($id,$type)
    {
        require_once APPLICATION_PATH . '/forms/Compte.php';
        if(($type == 'admin'||$type=='superadmin') && !empty($id)) {
			Zend_Registry::set('modeform', 'modif');
			$form = new Form_Compte();
			$form->setAction($this->_helper->url('form/?id='.$id));
		} else {
			if($type == 'admin'||$type=='superadmin')
				Zend_Registry::set('modeform', 'ajout');
			else
				Zend_Registry::set('modeform', 'modif');
			
			$form = new Form_Compte();
			$form->setAction($this->_helper->url('form'));
		}
		return $form;
    }
	
	protected function _getMdpForm($id, $type)
    {
        require_once APPLICATION_PATH . '/forms/Mdp.php';
		
		if($type == 'admin' && !empty($id)) {
			Zend_Registry::set('modeform', 'modif');
			$form = new Form_Mdp();
			$form->setAction($this->_helper->url('form/?f=mdp&id='.$id));
		} else {
			if($type == 'admin')
				Zend_Registry::set('modeform', 'ajout');
			else
				Zend_Registry::set('modeform', 'modif');

			$form = new Form_Mdp();
			$form->setAction($this->_helper->url('form/?f=mdp'));
		}
		
        return $form;
    }
	
}