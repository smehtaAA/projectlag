<?php

class SiteController extends Zend_Controller_Action 
{
	public function indexsuperadminAction() 
    {
		$smarty   = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
			$smarty->assign('titre','Site');
			$smarty->display('site/indexSuperAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
    public function indexadminAction() 
    {
		$smarty   = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')) {
		$smarty->assign('titre','Site');
		$smarty->display('site/indexAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
}
