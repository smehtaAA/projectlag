<?php

class Admin_InformationController extends Zend_Controller_Action {

    protected $_model;

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('indexadmin');
        }

        throw new Exception('Invalid method');
    }

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $log->_setInterface_admin(true);
            return $this->_helper->redirector('indexadmin');
        } else {
            $smarty->assign('message', 'Erreur Connexion');
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function indexadminAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $model = $this->_getModel();
            $datas = $model->fetchEntries();
            $request = $this->getRequest();
            /* Coder une fonction pour trouver le nombre de joueurs dans les teams */
            $smarty->assign('baseurl', $request->getBaseUrl());
            $smarty->assign('total', $model->countEntries());
            $smarty->assign('title', 'Information');
            $smarty->assign('urladd', 'form/');
            $smarty->assign('urlupd', 'form/?id=');
            $smarty->assign('urldel', 'del/?id=');
            $smarty->assign('datas', $datas);
            $smarty->display('information/indexAdmin.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function formAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            $form = $this->_getInformationForm($id);
            $model = $this->_getModel();

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();

                    if (empty($dataform['img']))
                        unset($dataform['img']);
                    else {
                        $nom_image = $dataform["titre"];
                        require_once '../library/My/Utils.php';
                        $chaine_valide = valideChaine($nom_image);
                        $ext = explode('.', $dataform["img"]);
                        $ancien_nom = $dataform['img'];
                        $dataform['img'] = $chaine_valide . '.' . $ext[1];
                    }


                    $model->save($id, $dataform);

// resize picture si image dans formulaire
                    if (!empty($dataform['img'])) {
                        require_once '../library/My/PhpThumb/ThumbLib.inc.php';
                        $thumb = PhpThumbFactory::create('../public/images/info/' . $ancien_nom);
                        $thumb->adaptiveResize(475, 225)->save('../public/images/info/' . $dataform["img"]);
                        $thumb->adaptiveResize(75, 50)->save('../public/images/info/thumb/' . $dataform["img"]);
                        if (file_exists('../public/images/info/' . $ancien_nom))
                            unlink('../public/images/info/' . $ancien_nom);
                    }

                    return $this->_helper->redirector('indexadmin');
                }
            } else {
                if ($id > 0) {
                    $data = $model->fetchEntry($id);
                    $form->populate($data);
                }
            }

            if ($id > 0)
                $smarty->assign('title', 'Modification Information');
            else
                $smarty->assign('title', 'Ajout Information');

            $smarty->assign('form', $form);
            $smarty->display('information/form.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function delAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            if ($id > 0) {
                $model = $this->_getModel();
                $model->delete($id);
            }
            return $this->_helper->redirector('indexadmin');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Information.php';
            $this->_model = new Model_Information();
        }
        return $this->_model;
    }

    protected function _getInformationForm($id) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Information.php';
        $form = new Form_Information();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?id=' . $id));
        else
            $form->setAction($this->_helper->url('form'));
        return $form;
    }

}
