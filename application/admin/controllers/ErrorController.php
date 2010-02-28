<?php 

class Admin_ErrorController extends Zend_Controller_Action
{ 
	
	public function indexadminAction() 
	{
		$smarty = Zend_Registry::get('view');
		$smarty->assign('message','Index du Controller Error');
		$smarty->display('error/error.tpl');
		
	}
	
    public function errorAction() 
    { 
        // Ensure the default view suffix is used so we always return good 
        // content
		$smarty = Zend_Registry::get('view');
        // Grab the error object from the request
        $errors = $this->_getParam('error_handler'); 

        // $errors will be an object set as a parameter of the request object, 
        // type is a property
        switch ($errors->type) { 
            case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_CONTROLLER: 
            case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_ACTION: 

                // 404 error -- controller or action not found 
                $this->getResponse()->setHttpResponseCode(404); 
                $smarty->assign('message','Page not found'); 
                break; 
            default: 
                // application error 
                $this->getResponse()->setHttpResponseCode(500); 
                $smarty->assign('message','Application error'); 
                break; 
        } 

        // pass the environment to the view script so we can conditionally 
        // display more/less information
        $smarty->assign('env',$this->getInvokeArg('env')); 
        
        // pass the actual exception object to the view
        $smarty->assign('exceptionM',$errors->exception->getMessage());
		$smarty->assign('exceptionT',$errors->exception->getTraceAsString()); 
        
        // pass the request to the view
        $smarty->assign('request',var_dump($errors->request->getParams())); 
		$smarty->display('error/error.tpl');
    } 
}
