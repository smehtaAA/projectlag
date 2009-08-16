<?php
/*
 * Created on 20 juin 07
 *
 * @author Philippe Le Van (http://www.kitpages.fr)
 * @copyright 2005-2007
 */
class Zend_Controller_Action_Helper_ViewManager extends Zend_Controller_Action_Helper_Abstract {
    private $_view = null;
    public function setView($view) {
        $this->_view = $view;
    }
    public function init()
    {
        $this->getActionController()->view = $this->_view;
    }
}
?>