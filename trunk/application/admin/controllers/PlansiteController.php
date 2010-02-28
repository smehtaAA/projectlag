<?php

class Admin_PlansiteController extends Zend_Controller_Action
{
    protected $_model;

	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$model  = $this->_getModel();
		$request = $this->getRequest();
		$base_url = $request->getBaseUrl();
		$smarty->assign('base_url',$base_url);

        $plansite = $model->fetchEntries();
        $smarty->assign('plansite', $plansite);
        $smarty->display('plansite/index.tpl');
	}

	public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntriesOrderByOrdre();
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
            if($log->_getTypeConnected('superadmin'))
                $smarty->assign('urldel','del/?id=');
            else
                $smarty->assign('urldel','');

			$smarty->assign('datas',$datas);
			$smarty->display('plansite/indexAdmin.tpl');
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
			$form    = $this->_getPlansiteForm($id);
			$model   = $this->_getModel();

			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					if($id==0){
						$nb = $model->countEntries();
						$dataform['ordre'] = $nb+1;
					}
					if(empty($dataform['logo']))
						unset($dataform['logo']);
					else {
						$nom_image = $dataform["titre"];
						require_once '../library/My/Utils.php';
						$chaine_valide = valideChaine($nom_image);
						$ext = explode('.',$dataform["logo"]);
						$ancien_nom = $dataform['logo'];
						$dataform['logo']=$chaine_valide.'.'.$ext[1];
					}
					if(!empty($dataform["creer_type"]))
						$dataform["type"] = $dataform["creer_type"];
					unset($dataform["creer_type"]);
					$model->save($id,$dataform);

				return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}

			$form->RemplirType($model->fetchEntriesTypes());

			if($id > 0)
				$smarty->assign('title','Modification Plan du Site');
			else
				$smarty->assign('title', 'Ajout Plan du Site');

			$smarty->assign('form', $form);
			$smarty->display('news/form.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
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
            require_once APPLICATION_PATH_COMMONS . '/models/PlanSite.php';
            $this->_model = new Model_PlanSite();
        }
        return $this->_model;
    }

    protected function _getPlansiteForm($id)
    {
        require_once APPLICATION_PATH_COMMONS . '/forms/PlanSite.php';
        $form = new Form_PlanSite();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
