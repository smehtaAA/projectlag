<?php

class Admin_ConfigController extends Zend_Controller_Action {

    protected $_model;

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
            $request = $this->getRequest();
            $model = $this->_getModel();

            $base_url = $request->getBaseUrl();
            $datas = $model->fetchEntries();

            $smarty->assign('base_url', $base_url);
            $smarty->assign('datas', $datas);
            $smarty->assign('titre', 'Page de Configuration');
            $smarty->display('config/indexAdmin.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function formAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $model = $this->_getModel();
            $id = (int) $request->getParam('id', 0);
            $data = $model->fetchEntry($id);

            $form = $this->_getConfigForm($id);
            if ($this->getRequest()->isPost()) {

                if ($form->isValid($request->getPost())) {
                    $valform = $form->getValues();
                    $model->save($id, $valform);
                    //$smarty->assign('day',$d[2]);
                    //$smarty->assign('debug',$valform['date']);
                    return $this->_helper->redirector('indexadmin');
                    //$smarty->display('reunion/debug.tpl');
                }
            } else {
                if ($id > 0) {
                    $data = $model->fetchEntry($id);
                    $form->populate($data);
                }
            }
            if ($id > 0)
                $smarty->assign('title', 'Modification Configuration');

            $smarty->assign('form', $form);
            $smarty->assign('data', $data);
            $smarty->display('config/form.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Config.php';
            $this->_model = new Model_Config();
        }
        return $this->_model;
    }

    protected function _getConfigForm($id) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Config.php';
        $form = new Form_Config();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?id=' . $id));
        else
            $form->setAction($this->_helper->url('form'));
        return $form;
    }

}
