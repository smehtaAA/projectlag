<?php

class SiteController extends Zend_Controller_Action 
{
	public function indexadminAction() 
    {
		$smarty   = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$smarty->assign('titre','Site');
			$smarty->display('site/indexAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
}
