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
        $form    = $this->_getRechercheForm();
        $form->populate(array('q'=>$query));
        $smarty->assign('form', $form);
        
        if($query!="")
        {
            
            $query_html = htmlentities(utf8_decode($query));
            $query = split(" ",$query);
            $query_html = split(" ",$query_html);
            $news = $model->fetchNews($query, $query_html);
            $newsp = $model->fetchNewsP($query, $query_html);
            $lan = $model->fetchLan($query, $query_html);
            $forum = $model->fetchForum($query, $query_html);


            $smarty->assign('recherche', 1);
            $smarty->assign('news', $news);
            
            $smarty->assign('forum', $forum);
            $smarty->assign('lan', $lan);
            $smarty->assign('newsp', $newsp);
            $smarty->assign('query', $request->getParam('q', ""));
            $smarty->assign('baseurl', $request->getBaseUrl());


            $smarty->display('recherche/index.tpl');
        } else {
            $smarty->assign('recherche', 0);
            $smarty->display('recherche/index.tpl');
        }



        
     }

     public function formAction()
     {
         $smarty = Zend_Registry::get('view');
         $form    = $this->_getRechercheForm();


         $smarty->display('recherche/form.tpl');
     }

	
    protected function _getModel()
    {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Recherche.php';
            $this->_model = new Model_Recherche();
        }
        return $this->_model;
    }

    protected function _getRechercheForm()
    {
        require_once APPLICATION_PATH_COMMONS . '/forms/Recherche.php';
        $form = new Form_Recherche();
        $form->setAction($this->_helper->url('index'));
        return $form;
    }
	
}