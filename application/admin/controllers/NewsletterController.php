<?php

class Admin_NewsletterController extends Zend_Controller_Action
{
    protected $_model;
	protected $_modelype;
	protected $_modelMailType;
	protected $_modelMail;
	protected $_modelConfig;
	
	public function indexAction()
	{
		$smarty = Zend_Registry::get('view');
		$smarty->display('newsletter/index.tpl');
	}
	
	public function indexadminAction()
    {
		$smarty = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')||$log->_getTypeConnected('admin')) {
			$model  = $this->_getModel();
			$datas  = $model->fetchEntries();
			$request = $this->getRequest();
                        if($log->_getTypeConnected('superadmin'))
                                $smarty->assign('superadmin', 1);
                        else
                                $smarty->assign('superadmin', 0);
			$smarty->assign('baseurl',$request->getBaseUrl());
			$smarty->assign('title','Newsletter');
			$smarty->assign('urladd','form/');
			$smarty->assign('urlview','view/?id=');
			$smarty->assign('urlsend','send/?id=');
			$smarty->assign('urldel','del/?id=');
			$smarty->assign('datas',$datas);
			$smarty->display('newsletter/indexAdmin.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }

    public function sendAction()
    {
        $smarty  = Zend_Registry::get('view');
	$log = new SessionLAG();
	if($log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = $request->getParam('id', 0);
            if($id != 0) {
                $model = $this->_getModel();
                $n = $model->fetchEntry($id);

                $this->sendMail($n);
                return $this->_helper->redirector('indexadmin', 'newsletter');
            }
        } else {
            $smarty->display('error/errorconnexion.tpl');
	}


    }

    public function viewAction()
    {
        $smarty  = Zend_Registry::get('view');
	$log = new SessionLAG();
	if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = $request->getParam('id', 0);
            if($id != 0) {
                $model = $this->_getModel();
                $n = $model->fetchEntry($id);

                $smarty->assign('baseurl', $request->getBaseUrl());
                $smarty->assign('n', $n);
                $smarty->display('newsletter/view.tpl');
            } else {
                return $this->_helper->redirector('index', 'accueil');
            }
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
			$form    = $this->_getNewsletterForm($id);
			$model   = $this->_getModel();
			$modelType = $this->_getModelType();
			$types = $modelType->fetchEntries();
			$form->RemplirType($types);
	
			if ($this->getRequest()->isPost()) {
				if ($form->isValid($request->getPost())) {
					$dataform = $form->getValues();
					$dataform['idAdmin'] = $log->_getUser();
					$model->save($id,$dataform);
					
					if(!empty($dataform['img'])) {
						$nom_image = $dataform["titre"];
						require_once '../library/My/Utils.php';
						$chaine_valide = valideChaine($nom_image);
						$ext = explode('.',$dataform["img"]);
						$ancien_nom = $dataform['img'];
						$dataform['img'] = $chaine_valide.'.'.$ext[1];

						require_once '../library/My/PhpThumb/ThumbLib.inc.php'; 
						$thumb = PhpThumbFactory::create('../www/images/newsletter/tmp/'.$ancien_nom);
							$thumb->resize(400, 400)->save('../www/images/newsletter/'.$dataform["img"]);
						if(file_exists('../www/images/newsletter/tmp/'.$ancien_nom))
							unlink('../www/images/newsletter/tmp/'.$ancien_nom);
					}
					
					$this->sendMail($dataform);
					
					return $this->_helper->redirector('indexadmin');
				}
			} else {
				if ($id > 0) {
					$data = $model->fetchEntry($id);
					$form->populate($data);
				}
			}
			
			if($id > 0)
				$smarty->assign('title','Lire Newsletter');
			else
				$smarty->assign('title', 'Envoyer Newsletter');
			
			$smarty->assign('form', $form);
			$smarty->display('newsletter/form.tpl');
		} else {
			$smarty->display('error/errorconnexion.tpl');
		}
    }
	
	protected function sendMail($info) 
	{
		//$destinataire = "antoine.moraux@gmail.com"; 
		$subject = $info['titre'];
		$from  = "From: Local Arena Games <contact@asso-lag.fr>\n";
		$from .= "MIME-version: 1.0\n";
		$from .= "Content-type: text/html; charset=iso-8859-1\n";	
		$msg = "<html><head></head><body>
				<div style='font: normal 12px Arial;'>
				<b>Association - Local Arena Games</b><br />
				<b>Site  :</b> <a href='http://www.asso-lag.fr' target='_blank'>www.asso-lag.fr</a><br /><br />

				".$info["description"];
				
		if(!empty($info["img"]))
			$msg .=	"<br /><br /><img src='http://www.asso-lag.fr/images/newsletter/".$info["img"]."' align='center' border='0' />";
			
				
		$msg .=	"<br /><br /><div style='font: normal 11px Arial;'>Petit rappel : <a href='http://www.asso-lag.fr' target='_blank'>www.asso-lag.fr</a></div>
				</body></html>"; 
		
		$modelMail = $this->_getModelMailType();
		foreach($info['types'] as $idType) {
			$personnes = $modelMail->fetchEntriesMailByType($idType['types']);
			foreach($personnes as $personne) {
				mail($personne['mail'], $subject, $msg, $from);
			}
		}
	}
	
	public function delAction()
    {
            $smarty  = Zend_Registry::get('view');
		$log = new SessionLAG();
		if($log->_getTypeConnected('superadmin')) {
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
            require_once APPLICATION_PATH_COMMONS . '/models/Newsletter.php';
            $this->_model = new Model_Newsletter();
        }
        return $this->_model;
    }
	
	protected function _getModelType()
	{
		if (null === $this->_modelype) {
            require_once APPLICATION_PATH_COMMONS . '/models/NewsletterType.php';
            $this->_modelype = new Model_NewsletterType();
        }
        return $this->_modelype;
    }
	
	protected function _getModelMailType()
	{
		if (null === $this->_modelMailType) {
            require_once APPLICATION_PATH_COMMONS . '/models/NewsletterMailType.php';
            $this->_modelMailType = new Model_NewsletterMailType();
        }
        return $this->_modelMailType;
    }
	
	protected function _getModelMail()
	{
		if (null === $this->_modelMail) {
            require_once APPLICATION_PATH_COMMONS . '/models/NewsletterMail.php';
            $this->_modelMail = new Model_NewsletterMail();
        }
        return $this->_modelMail;
    }
	
	protected function _getModelConfig()
	{
		if (null === $this->_modelConfig) {
			require_once APPLICATION_PATH_COMMONS . '/models/Config.php';
			$this->_modelConfig = new Model_Config();
		}
		return $this->_modelConfig;
	}

    protected function _getNewsletterForm($id)
    {
        require_once APPLICATION_PATH_COMMONS . '/forms/Newsletter.php';
        $form = new Form_Newsletter();
		if($id > 0)
			$form->setAction($this->_helper->url('form/?id='.$id));
		else
			$form->setAction($this->_helper->url('form'));
        return $form;
    }
}
