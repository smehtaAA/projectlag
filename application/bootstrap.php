<?php

defined('APPLICATION_PATH')
    or define('APPLICATION_PATH', dirname(__FILE__));

defined('APPLICATION_ENVIRONMENT')
    or define('APPLICATION_ENVIRONMENT', 'development');
	
require_once(APPLICATION_PATH . '/../library/Smarty/Smarty.class.php');
require_once(APPLICATION_PATH . '/sessions/SessionLAG.php');

Zend_Session::start();

/*$defaultNamespace = new Zend_Session_Namespace();

if (!isset($defaultNamespace->initialized)) {
    Zend_Session::regenerateId();
    $defaultNamespace->initialized = true;
}*/

$language_code = 'fr_FR';
setlocale (LC_ALL, $language_code,'fra');
setlocale(LC_TIME, $language_code,'fra');

$view = new ZSJoin_View_Smarty();
Zend_Registry::set('view', $view);

$locale = new Zend_Locale('fr_FR');
Zend_Registry::set('Zend_Locale', $locale);



$frontController = Zend_Controller_Front::getInstance();
$frontController->setParam('noViewRenderer', true);
$frontController->setControllerDirectory(APPLICATION_PATH . '/controllers');
$frontController->setParam('env', APPLICATION_ENVIRONMENT);
/*
$controllerName = Zend_Controller_Front::getInstance()->getRequest()->getControllerName(); 
$actionName = $frontController->getRequest()->getActionName();

$interface_admin = Zend_Registry::get('interface_admin');
if (empty($interface_admin) || ($controllerName=='accueil' && $actionName=='index') ) {
	$interface_admin = false;
	Zend_Registry::set('interface_admin', $interface_admin);
}
if($interface_admin || ($controllerName=='accueil' && $actionName=='indexadminmenu')){
	$interface_admin = true;
	Zend_Registry::set('interface_admin', $interface_admin);
}

*/
$defaultNamespace = new Zend_Session_Namespace();
if(isset($defaultNamespace->userid)) {
	if(($defaultNamespace->type == 'superadmin' || $defaultNamespace->type == 'admin'))
		$layoutname = 'layout_admin';
	elseif($defaultNamespace->type == 'joueur')
		$layoutname = 'layout_joueur';
}
else
	$layoutname = 'layout';

$options = array(
    'layout'     => $layoutname,
    'layoutPath' => APPLICATION_PATH . '/layouts/scripts/',
);

Zend_Layout::startMvc($options);

$view = Zend_Layout::getMvcInstance()->getView();
$view->doctype('XHTML11');
$view->setEncoding('UTF-8');

$configuration = new Zend_Config_Ini(APPLICATION_PATH . '/config/app.ini', APPLICATION_ENVIRONMENT);

try {
	$dbAdapter = Zend_Db::factory($configuration->database);
	$dbAdapter->getConnection();
} catch (Zend_Db_Adapter_Exception $e){
	echo $e->getMessage();
}

Zend_Db_Table_Abstract::setDefaultAdapter($dbAdapter);

$registry = Zend_Registry::getInstance();
$registry->configuration = $configuration;
$registry->dbAdapter     = $dbAdapter;

unset($frontController, $view, $configuration, $dbAdapter, $registry);

