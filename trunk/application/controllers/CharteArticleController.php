<?php

class CharteArticleController extends Zend_Controller_Action 
{
    protected $_model;
	protected $_modelJeux;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$model  = $this->_getModel();
		$request = $this->getRequest();
		
		$datas = $model->fetchEntriesOrderByOrdre();
		
		$smarty->assign('titre', 'Article');
		$smarty->assign('base_url', $request->getBaseUrl());
		$smarty->assign('datas', $datas);
		$smarty->display('chartearticle/index.tpl');
	}
	
	public function indexsuperadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
			
			$request = $this->getRequest();
			$id = (int)$request->getParam('id', 0);
			
			if(!empty($id)){
				$model   = $this->_getModel();
				$datas   = $model->fetchEntriesByCharte($id);
				$request = $this->getRequest();
				$smarty->assign('base_url',$request->getBaseUrl());
				$smarty->assign('titre','Article');
				$smarty->assign('urladd',$request->getBaseUrl().'/chartearticle/form/?idCharte='.$id);
				$smarty->assign('urlupd',$request->getBaseUrl().'/chartearticle/form/?idCharte='.$id.'&id=');
				$smarty->assign('urldel',$request->getBaseUrl().'/chartearticle/del/?id=');
				$smarty->assign('datas',$datas);
				$smarty->display('chartearticle/indexSuperAdmin.tpl');
			}
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }

    public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')) {
			
			$request = $this->getRequest();
			$id = (int)$request->getParam('id', 0);
			
			if(!empty($id)){
				$model   = $this->_getModel();
				$datas   = $model->fetchEntriesByCharte($id);
				$request = $this->getRequest();
				$smarty->assign('base_url',$request->getBaseUrl());
				$smarty->assign('titre','Article');
				$smarty->assign('urladd',$request->getBaseUrl().'/chartearticle/form/?idCharte='.$id);
				$smarty->assign('urlupd',$request->getBaseUrl().'/chartearticle/form/?idCharte='.$id.'&id=');
				$smarty->assign('urldel',$request->getBaseUrl().'/chartearticle/del/?id=');
				$smarty->assign('datas',$datas);
				$smarty->display('chartearticle/indexAdmin.tpl');
			}
		} else {
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
			$idCharte = (int)$request->getParam('idCharte', 0);
			$form    = $this->_getCharteArticleForm($id, $idCharte);
			$model   = $this->_getModel();	
			$modelCharte = $this->_getModelCharte();
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					if($id==0){
						$nb = $model->countEntries();
						$dataform['ordre'] = $nb+1;
					}
					$dataform['idCharte']=$idCharte;
					$model->save($id,$dataform);
					if($log->_getTypeConnected('superadmin'))
						return $this->_helper->redirector('indexsuperadmin','chartearticle','',array('id'=>$idCharte));
					else
						return $this->_helper->redirector('indexadmin','chartearticle','',array('id'=>$idCharte));
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			if($id > 0)
				$smarty->assign('title','Modification Article');
			else
				$smarty->assign('title', 'Ajout Article');
			
			$smarty->assign('form', $form);
			$smarty->display('chartearticle/form.tpl');
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
				$data = $model->fetchEntry($id);
				$ordre = $data['ordre'];
				$idCharte = $data['idCharte'];
				$model->delete($id);
				// Decalage des ordres
				$datas = $model->fetchEntriesOrderByOrdre();
				foreach($datas as $mention) {
					if($mention['ordre'] == $ordre+1) {
						$mention['ordre'] = $ordre;
						$model->save($mention['idCharteArticle'], $mention);
						$ordre++;
					}
				}
				
				
			}
			if($log->_getTypeConnected('superadmin'))
				return $this->_helper->redirector('indexsuperadmin','chartearticle','',array('id'=>$idCharte));
			else
				return $this->_helper->redirector('indexadmin','chartearticle','',array('id'=>$idCharte));
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	public function changementordreAction()
	{
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
			$request = $this->getRequest();
			$model   = $this->_getModel();
			$ordre   = (int)$request->getParam('ordre', 0);
			$change  = (string)$request->getParam('change');
			$data    = $model->fetchEntryByOrdre($ordre);
			
			if($change == "up") {
				$data['ordre']    = $data['ordre'] - 1;
				$mention          = $model->fetchEntryByOrdre($data['ordre']);
				$mention['ordre'] = $mention['ordre'] + 1;
			} else {
				$data['ordre']    = $data['ordre'] + 1;
				$mention          = $model->fetchEntryByOrdre($data['ordre']);
				$mention['ordre'] = $mention['ordre'] - 1;
			}
			
			$model->save($data['idCharteArticle'], $data);
			$model->save($mention['idCharteArticle'], $mention);
			
			$smarty = Zend_Registry::get('view');
	
			
			$datas = $model->fetchEntriesByCharte($data['idCharte']);
			$smarty->assign('base_url',$request->getBaseUrl());
			$smarty->assign('titre','Article');
			$smarty->assign('urladd',$request->getBaseUrl().'/chartearticle/form/?idCharte='.$data['idCharte']);
			$smarty->assign('urlupd',$request->getBaseUrl().'/chartearticle/form/?idCharte='.$data['idCharte'].'&id=');
			$smarty->assign('urldel',$request->getBaseUrl().'/chartearticle/del/?id=');
			$smarty->assign('datas',$datas);
			if($log->_getTypeConnected('superadmin')){
				$smarty->display('chartearticle/indexSuperAdmin.tpl');
			}else{
				$smarty->display('chartearticle/indexAdmin.tpl');
			}
			
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
	}

    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/CharteArticle.php';
            $this->_model = new Model_CharteArticle();
        }
        return $this->_model;
    }

	protected function _getModelCharte()
    {
        if (null === $this->_modelJeux) {
            require_once APPLICATION_PATH . '/models/Charte.php';
            $this->_modelJeux = new Model_Charte();
        }
        return $this->_modelJeux;
    }

    protected function _getCharteArticleForm($id, $idCharte)
    {
        require_once APPLICATION_PATH . '/forms/CharteArticle.php';
        $form = new Form_CharteArticle();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?idCharte='.$idCharte.'&id='.$id));
		else
			$form->setAction($this->_helper->url('form?idCharte='.$idCharte));
        return $form;
    }
}
