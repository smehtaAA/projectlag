<?php

class CharteArticleController extends Zend_Controller_Action 
{
    protected $_model;
	protected $_modelCharte;
	
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
	
	public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			
			$request = $this->getRequest();
			$id = (int)$request->getParam('id', 0);
			
			if(!empty($id)){
				$model   = $this->_getModel();
				$modelCharte   = $this->_getModelCharte();
				$datas   = $model->fetchEntriesByCharte($id);
				$charte = $modelCharte->fetchEntry($id);
				$request = $this->getRequest();
				$smarty->assign('base_url',$request->getBaseUrl());
				if($id==1)
					$smarty->assign('titre','Charte de l\'Association');
				else
					$smarty->assign('titre','Article de la charte '.$charte['nom']);
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
			$smarty->display('chartearticle/indexAdmin.tpl');
			
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
	}

    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/CharteArticle.php';
            $this->_model = new Model_CharteArticle();
        }
        return $this->_model;
    }

	protected function _getModelCharte()
    {
        if (null === $this->_modelCharte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Charte.php';
            $this->_modelCharte = new Model_Charte();
        }
        return $this->_modelCharte;
    }

    protected function _getCharteArticleForm($id, $idCharte)
    {
        require_once APPLICATION_PATH_COMMONS . '/forms/CharteArticle.php';
        $form = new Form_CharteArticle();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?idCharte='.$idCharte.'&id='.$id));
		else
			$form->setAction($this->_helper->url('form?idCharte='.$idCharte));
        return $form;
    }
}
