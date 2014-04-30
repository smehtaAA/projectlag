<?php

defined('APPLICATION_PATH')
        or define('APPLICATION_PATH', dirname(__FILE__));

defined('APPLICATION_PATH_COMMONS')
        or define('APPLICATION_PATH_COMMONS', dirname(__FILE__) . '/commons');

defined('APPLICATION_ENVIRONMENT')
        or define('APPLICATION_ENVIRONMENT', 'development');

require_once(APPLICATION_PATH . '/../library/Smarty/Smarty.class.php');
require_once(APPLICATION_PATH . '/../library/Smarty/SmartyBC.class.php');
require_once(APPLICATION_PATH . '/../library/ZSJoin/View/Smarty.php');
require_once(APPLICATION_PATH_COMMONS . '/sessions/SessionLAG.php');

Zend_Session::start();

/* $defaultNamespace = new Zend_Session_Namespace();

  if (!isset($defaultNamespace->initialized)) {
  Zend_Session::regenerateId();
  $defaultNamespace->initialized = true;
  } */

$language_code = 'fr_FR';
setlocale(LC_ALL, $language_code, 'fra');
setlocale(LC_TIME, $language_code, 'fra');

// passage du chemin des views pour smarty :
// pour le module default mettre "/default"
// pour le module admin mettre "/admin"
// en attendant j'ai mis '/defaul' car les parties sont pas encore séparées
// PS : penser à déplacer les commmuns dans le dossier commons
// et de voir les modification de chemins à apporter

$view = new ZSJoin_View_Smarty('/default');
Zend_Registry::set('view', $view);
$locale = new Zend_Locale('fr_FR');
Zend_Registry::set('Zend_Locale', $locale);



$frontController = Zend_Controller_Front::getInstance();
$frontController->setParam('noViewRenderer', true);
$frontController->setControllerDirectory(array('default' => APPLICATION_PATH . '/default/controllers', 'admin' => APPLICATION_PATH . '/admin/controllers'));
$frontController->setParam('env', APPLICATION_ENVIRONMENT);
$frontController->setParam('useDefaultControllerAlways', true);

/*
  $controllerName = Zend_Controller_Front::getInstance()->getRequest()->getControllerName();
  $actionName = $frontController->getRequest()->getActionName();
  try {
  $interface_admin = Zend_Registry::get('interface_admin');
  } catch (Exception $e) {
  }
  if (empty($interface_admin)) {
  $interface_admin = false;
  Zend_Registry::set('interface_admin', $interface_admin);
  }
  if($interface_admin){
  $interface_admin = true;
  Zend_Registry::set('interface_admin', $interface_admin);
  }
 */

//Zend_Registry::set('interface_admin', 'toto');

$defaultNamespace = new Zend_Session_Namespace();
if (isset($defaultNamespace->userid)) {
    if (($defaultNamespace->type == 'superadmin' || $defaultNamespace->type == 'admin') && $defaultNamespace->interface_admin)
        $layoutname = 'layout_admin';
    elseif ($defaultNamespace->type == 'joueur' || $defaultNamespace->type == 'superadmin' || $defaultNamespace->type == 'admin')
        $layoutname = 'layout';
} else
    $layoutname = 'layout';

$options = array(
    'layout' => $layoutname,
    'layoutPath' => APPLICATION_PATH_COMMONS . '/layouts/scripts/',
);

Zend_Layout::startMvc($options);

$view = Zend_Layout::getMvcInstance()->getView();
$view->doctype('XHTML11');
$view->setEncoding('UTF-8');

$configuration = new Zend_Config_Ini(APPLICATION_PATH_COMMONS . '/config/app.ini', APPLICATION_ENVIRONMENT);

try {
    $dbAdapter = Zend_Db::factory($configuration->database);
    $dbAdapter->getConnection();
} catch (Zend_Db_Adapter_Exception $e) {
    echo $e->getMessage();
}

Zend_Db_Table_Abstract::setDefaultAdapter($dbAdapter);

$registry = Zend_Registry::getInstance();
$registry->configuration = $configuration;
$registry->dbAdapter = $dbAdapter;

require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
$modelCompte = new Model_Compte();
if (isset($defaultNamespace->userid)) {
    $modelCompte->save($defaultNamespace->userid, array('last_time_connexion' => time()));
}

unset($frontController, $view, $configuration, $dbAdapter, $registry);

