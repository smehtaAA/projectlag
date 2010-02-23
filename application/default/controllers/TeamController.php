<?php

class TeamController extends Zend_Controller_Action 
{
	
	protected $_model;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$smarty->display('team/index.tpl');
	}
	
    public function indexadminAction() 
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntries();
			$request = $this->getRequest();
			/* Coder une fonction pour trouver le nombre de joueurs dans les teams */

                        foreach($datas as $t){
                            $nb[$t['idTeam']] = $model->countEntriesByTeam($t['idTeam']);
                        }

                        $smarty->assign('nb', $nb);
			$smarty->assign('baseurl',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','Team');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('team/indexAdmin.tpl');
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
			
			$smarty->assign('title','Team');
			$smarty->display('team/indexAdmin.tpl');
		} else {
			$smarty->assign('message', 'Erreur Connexion');
			$smarty->display('error/errorconnexion.tpl');
		}  
    }

    public function viewmembresAction()
    {
        $smarty = Zend_Registry::get('view');
	$log = new SessionLAG();
	if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
            $request = $this->getRequest();
            $id = $request->getParam('id', 0);
            if($id != 0) {

                $model = $this->_getModel();
                $membres = $model->fetchMembresField($id, array('idCompte', 'login'));

                $smarty->assign('title', 'Membres de la team : '.$membres[0]['nom']);

                $smarty->assign('membres', $membres);
                $smarty->assign('urlfiche', $request->getBaseUrl().'/compte/viewfiche?id=');
                $smarty->assign('baseurl', $request->getBaseUrl());
                $smarty->display('team/viewmembres.tpl');
            }
        }
    }
	
	public function formAction()
    {
		$smarty  = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
			$request = $this->getRequest();
			$id      = (int)$request->getParam('id', 0);
			$form    = $this->_getLanForm($id);
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					$datedeb = $dataform['datedeb'];
					$dataform['datedeb'] = substr($datedeb, 6, 4)."-".substr($datedeb, 3, 2)."-".substr($datedeb, 0, 2)." 00:00:00";
					$datefin = $dataform['datefin'];
					$dataform['datefin'] = substr($datefin, 6, 4)."-".substr($datefin, 3, 2)."-".substr($datefin, 0, 2)." 00:00:00";
					$model->save($id,$dataform);
					return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			if($id > 0)
				$smarty->assign('title','Modification Team');
			else
				$smarty->assign('title', 'Ajout Team');
			
			$smarty->assign('form', $form);
			$smarty->display('lan/form.tpl');
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
            require_once APPLICATION_PATH . '/models/Team.php';
            $this->_model = new Model_Team();
        }
        return $this->_model;
    }

    protected function _getLanForm($id)
    {
        require_once APPLICATION_PATH . '/forms/Team.php';
        $form = new Form_Team();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
	
}