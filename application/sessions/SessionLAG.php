<?php

class SessionLAG 
{
	public function _getTypeConnected($type)
	{
		$isconnected = false;
		$defaultNamespace = new Zend_Session_Namespace();
		if(Zend_Session::sessionExists() && $defaultNamespace->type == $type) {
			$isconnected = true;
		}
		return $isconnected;
	}
	
	public function _getUser() {
		$defaultNamespace = new Zend_Session_Namespace();
		return $defaultNamespace->userid; 
	}
	
	public function _getType() {
		$defaultNamespace = new Zend_Session_Namespace();
		return $defaultNamespace->type; 
	}
	
	public function _setInterface_admin($interface) {
		$defaultNamespace = new Zend_Session_Namespace();
		$defaultNamespace->interface_admin = $interface; 
	}
}