<?php

class NewsController extends Zend_Controller_Action 
{
    protected $_model;
	protected $_modelConfig;
	protected $_modelPartenaire;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$model  = $this->_getModel();
		$modelConfig = $this->_getModelConfig();
		$request = $this->getRequest();
		$id = $request->getParam('id', 0);

		$news = $model->fetchEntry($id);
		
		$smarty->assign('base_url', $request->getBaseUrl());
		$smarty->assign('news', $news);
		$smarty->display('news/index.tpl');
	}
	
	public function indexpartenaireAction()
	{
		$smarty = Zend_Registry::get('view');
		
		$model  = $this->_getModel();
		$modelConfig = $this->_getModelConfig();
		$request = $this->getRequest();
		$page = $request->page;

		$config = $modelConfig->fetchEntrySetting('nb_max_news_partenaire_page');

 		$nb_max_news_page = $config['valeur'];
		
		if($nb_max_news_page == 0)
		{
			$nb_max_news_page = 4;
		}
		
		// R�cup�ration du nombre d'enregistrement
		$nb = $model->countEntriesPartenaires();
		// Arrondi � l'entier sup�rieur
		$nb_page = ceil($nb/$nb_max_news_page);
		// Bloque l'acc�s au page sup�rieure au nombre total de page
		if($page > $nb_page) 
		{
			$page=1;
		}
		
		// R�cup�ration du nombre de ligne pour la page voulue
		$datas  = $model->fetchEntriesPartenaireLimitPage($page,$nb_max_news_page);
		
		$pages = null;
		
		for($i=1; $i<=$nb_page; $i++)
		{
			$pages[$i] = $i;
		}

		$smarty->assign('base_url', $request->getBaseUrl());
		$smarty->assign('datas', $datas);
		$smarty->assign('pages', $pages);
		$smarty->assign('url','?page=');
		$smarty->display('news/indexPartenaire.tpl');
	}
	
	public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntriesAsso(array('idNews', 'titre', 'type_n', 'img'));
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','News Asso');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('news/indexAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	public function indexadminpartenaireAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntriesPart(array('idNews', 'titre', 'type_n', 'img'));
			$request = $this->getRequest();
			$smarty->assign('baseurl',$request->getBaseUrl());
			$smarty->assign('total',$model->countEntries());
			$smarty->assign('title','News Partenaires');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlupd','form/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('news/indexAdmin.tpl');
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
			$form    = $this->_getNewsForm($id);
			$model   = $this->_getModel();		
			$modelPartenaire = $this->_getModelPartenaire();
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();					
					if(!empty($dataform["creer_type_n"]))
						$dataform["type_n"] = $dataform["creer_type_n"];
					unset($dataform["creer_type_n"]);
					
					if(empty($dataform['img']))
						unset($dataform['img']);
					else {
						$nom_image = $dataform["titre"];
						require_once '../library/My/Utils.php';
						$chaine_valide = valideChaine($nom_image);
						$ext = explode('.',$dataform["img"]);
						$ancien_nom = $dataform['img'];
						$dataform['img']=$chaine_valide.'.'.$ext[1];
					}
					
					$dataform['titre']=utf8_decode($dataform['titre']);
					
					$model->save($id,$dataform);
					
					// resize picture si image dans formulaire
					if(!empty($dataform['img']))
					{
						require_once '../library/My/PhpThumb/ThumbLib.inc.php'; 
						$thumb = PhpThumbFactory::create('../www/images/news/'.$ancien_nom);
						if ($dataform['idPartenaire']!=0)
							$thumb->resize(300, 300)->save('../www/images/news/'.$dataform["img"]);
						else
							$thumb->resize(140, 140)->save('../www/images/news/'.$dataform["img"]);
						if(file_exists('../www/images/news/'.$ancien_nom))
							unlink('../www/images/news/'.$ancien_nom);
					}
					
					if(!empty($dataform['idPartenaire']))
						return $this->_helper->redirector('indexadminpartenaire');
					else
						return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$data['titre']=utf8_encode($data['titre']);
					$form->populate($data);
				}
			}
			
			$form->RemplirType($model->fetchEntriesTypes());
			$form->RemplirPartenaire($modelPartenaire->fetchEntries());
			
			if($id > 0)
				$smarty->assign('title','Modification News');
			else
				$smarty->assign('title', 'Ajout News');
			
			$smarty->assign('form', $form);
			$smarty->display('news/form.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	public function delAction()
    {
		$log = new SessionLAG();
		if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
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
            require_once APPLICATION_PATH_COMMONS . '/models/News.php';
            $this->_model = new Model_News();
        }
        return $this->_model;
    }
	
    protected function _getModelPartenaire()
    {
        if (null === $this->_modelPartenaire) {
            require_once APPLICATION_PATH_COMMONS . '/models/Partenaire.php';
            $this->_modelPartenaire = new Model_Partenaire();
        }
        return $this->_modelPartenaire;
    }
	
	protected function _getModelConfig()
	{
		if (null === $this->_modelConfig) {
			require_once APPLICATION_PATH_COMMONS . '/models/Config.php';
			$this->_modelConfig = new Model_Config();
		}
		return $this->_modelConfig;
	}

    protected function _getNewsForm($id)
    {
        require_once APPLICATION_PATH_COMMONS . '/forms/News.php';
        $form = new Form_News();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
