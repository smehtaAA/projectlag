<?php

class RechercheController extends Zend_Controller_Action
{
	protected $_model;
	
    public function indexAction()
    {
        $smarty = Zend_Registry::get('view');
	$model = $this->_getModel();
		
        $request     = $this->getRequest();
        $query = $request->getParam('q', "");
        $query_html = htmlentities(utf8_decode($query));
        $query = split(" ",$query);
        $query_html = split(" ",$query_html);

        if($query!="")
        {
            $news = $model->fetchNews($query, $query_html);
            $newsp = $model->fetchNewsP($query, $query_html);
            $lan = $model->fetchLan($query, $query_html);


            $smarty->assign('news', $news);
            $smarty->assign('lan', $lan);
            $smarty->assign('newsp', $newsp);
            $smarty->assign('query', $request->getParam('q', ""));
            $smarty->assign('baseurl', $request->getBaseUrl());


            $smarty->display('recherche/index.tpl');
        } else {

            return $this->_helper->redirector('form');
        }



        
     }

	
    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH . '/models/Recherche.php';
            $this->_model = new Model_Recherche();
        }
        return $this->_model;
    }
	
}