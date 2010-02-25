<?php

class BugController extends Zend_Controller_Action 
{
    protected $_model;
	
	public function remerciementAction()
	{
		// Page de remerciement
		$smarty = Zend_Registry::get('view');
		$model  = $this->_getModel();
		$request = $this->getRequest();
		
		$smarty->assign('titre', 'Signaler un bug');
		$smarty->assign('base_url', $request->getBaseUrl());
		$smarty->display('bug/remerciement.tpl');
	}

    public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
			$model  = $this->_getModel();
			$request = $this->getRequest();
			$id = $request->getParam('id',0);

                        if ($log->_getTypeConnected('superadmin'))
                            $smarty->assign('superadmin', 1);
                        else
                            $smarty->assign('superadmin', 0);
                        
			
			// Affichage des priorités
			$priorite['0'] = 'Inconnu';
			$priorite['1'] = 'Urgent';
			$priorite['2'] = 'Haute';
			$priorite['3'] = 'Normal';
			$priorite['4'] = 'Faible';
			$priorite['5'] = 'Aucune';
			$smarty->assign('priorite', $priorite);
			$smarty->assign('base_url',$request->getBaseUrl());
			
			if($id>0) {
				$bug = $model->fetchEntry($id);
				if($bug['datedebug'] == "0000-00-00")
					$corrige=false;
				else
					$corrige=true;
				$smarty->assign('bug', $bug);
				$smarty->assign('corrige', $corrige);
				$smarty->assign('titre', 'Bug');
				$smarty->display('bug/bug.tpl');
			} else {
				
				$table=$request->getParam('table');
				$sort=$request->getParam('sort');
				$ordre=$request->getParam('ordre');
				
				if($table=='bug'){
					$bugs  = $model->fetchEntriesOrderByPriorityParam($sort,$ordre);
					$bugs_corrige  = $model->fetchEntriesOrderByPriorityCorrige();
				}elseif($table=="debug"){
					$bugs  = $model->fetchEntriesOrderByPriority();
					$bugs_corrige  = $model->fetchEntriesOrderByPriorityCorrigeParam($sort,$ordre);
				}else{
					$bugs  = $model->fetchEntriesOrderByPriority();
					$bugs_corrige  = $model->fetchEntriesOrderByPriorityCorrige();
				}
				
				$smarty->assign('titre','Bugs');
				$smarty->assign('urlview', 'indexadmin/?id=');
				$smarty->assign('urlupd',$request->getBaseUrl().'/bug/resoudre/?id=');
				$smarty->assign('urldel',$request->getBaseUrl().'/bug/del/?id=');
				$smarty->assign('urltri', $request->getBaseUrl().'/bug/indexadmin/?');
				$smarty->assign('bugs_corrige',$bugs_corrige);
				$smarty->assign('bugs',$bugs);
				$smarty->display('bug/indexAdmin.tpl');
			}
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }

    public function formAction()
    {
		$smarty  = Zend_Registry::get('view');
		
			$request = $this->getRequest();
			$id      = (int)$request->getParam('id', 0);
			$log     = new SessionLAG();
			$form    = $this->_getBugForm($id,$log->_getType());
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
                    function decode(&$value) {
                        $value = utf8_decode($value);
                    }
                    array_walk($dataform, 'decode');
					$model->save($id,$dataform);
					if ($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
						return $this->_helper->redirector('indexadmin');
					} else {
                        $this->sendMail($form->getValues());
						return $this->_helper->redirector('remerciement');
					}
				}
			} else {
				if ($id > 0 && $log->_getTypeConnected('admin')) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			
			if($id > 0)
				$smarty->assign('title','Bug');
			else
				$smarty->assign('title', 'Signaler un bug');
			
			$smarty->assign('form', $form);
			$smarty->display('bug/form.tpl');

    }

	public function resoudreAction()
	{
		
			$smarty  = Zend_Registry::get('view');
		
			$request = $this->getRequest();
			$id      = (int)$request->getParam('id', 0);
			$log     = new SessionLAG();
			$form    = $this->_getBugForm($id,$log->_getType());
			$model   = $this->_getModel();		
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();		
					$model->save($id,$form->getValues());
					if ($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
						return $this->_helper->redirector('indexadmin');
					} else {
						$smarty->display('error/errorconnexion.tpl');
					}
				}
			} else {
				if ($id > 0 && ($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin'))) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			
			if($id > 0)
				$smarty->assign('title','Resoudre un Bug');
			
			$smarty->assign('data', $data);
			$smarty->assign('form', $form);
			$smarty->display('bug/resoudre.tpl');
		
	}

	protected function sendMail($data)
	{
		// Fonction d'envoi du mail sur association.lag@gmail.com
		$destinataire = 'association.lag@gmail.com';
		$subject = "Bug depuis le site Local Arena Games";
		$from  = "From: Bug - Local Arena Games <bug@asso-lag.fr>\n";
        $from .= "X-Priority: 1\n";
		$from .= "MIME-version: 1.0\n";
		$from .= "Content-type: text/html; charset=utf-8\n";
        $from .= "Content-Transfer-Encoding: 8bit\n\n";
		$msg = "<html><head></head><body>
				<div style='font: normal 12px Arial;'>
				<b>Signaler bug - Local Arena Games</b><br /><br />
				<b>Categorie :</b> ".$data['categorie']."<br />
				<b>Navigateur :</b> ".$data['navigateur']."<br />
				<b>Titre :</b> ".$data['titre']."<br /><br />
				<b>Description :</b> ".$data['description']."</div>
				</body></html>";
		mail($destinataire, $subject, $msg, $from);
	}

    public function delAction()
    {
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
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
            require_once APPLICATION_PATH_COMMONS . '/models/Bug.php';
            $this->_model = new Model_Bug();
        }
        return $this->_model;
    }

    protected function _getBugForm($id, $type)
    {
        require_once APPLICATION_PATH_COMMONS . '/forms/Bug.php';
		
		if (($id > 0 && $type == 'admin') || ($id > 0 && $type == 'superadmin') )
			Zend_Registry::set('modeform', 'modif');
		else
			Zend_Registry::set('modeform', 'ajout');
		
        $form = new Form_Bug();

		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
			
        return $form;
    }
}
