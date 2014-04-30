<?php

class Admin_NewsletterMailTypeController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelMail;
    protected $_modelType;

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

            $modelType = $this->_getModelType();
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);

            if ($id > 0) {
                $datas = $model->fetchEntriesByType($id);

                $type = $modelType->fetchEntry($id);

                $smarty->assign('title', 'Mails de ' . $type['nom']);
                $smarty->assign('base_url', $request->getBaseUrl());
                $smarty->assign('urladd', $request->getBaseUrl() . '/newslettermailtype/rattachermail/?id=' . $id);
                $smarty->assign('urlupd', 'form/?id=');
                $smarty->assign('urldel', $request->getBaseUrl() . '/newslettermailtype/del/?id=');
                $smarty->assign('datas', $datas);
                $smarty->display('newsletter/indexmailtypeAdmin.tpl');
            } else {
                $smarty->display('error/errorconnexion.tpl');
            }
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function delAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $model = $this->_getModel();
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            $idt = (int) $request->getParam('idt', 0);

            if ($id != 0) {
                $model->delete($id);

                //return $this->_helper->redirector('indexadmin', 'newslettermailtype','', array('id'=>$idt));
                return $this->_redirect('newslettermailtype/indexadmin?id=' . $idt);
            }
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function formAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $model = $this->_getModel();
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);

            $form = $this->_getNewsletterMailTypeForm($id);

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $model->save($id, $form->getValues());
                    return $this->_helper->redirector('indexadmin');
                }
            } else {
                if ($id > 0) {
                    $data = $model->fetchEntry($id);
                    $form->populate($data);
                }
            }

            $smarty->assign('title', 'Ajouter un mail');
            $smarty->assign('form', $form);
            $smarty->display('newsletter/formmailtype.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function rattachermailAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $model = $this->_getModel();
            $modelType = $this->_getModelType();
            $modelMail = $this->_getModelMail();
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            if ($id > 0) {

                $mail_non_rattache = $model->fetchEntriesNonRattaches($id);
                $mail_rattache = $model->fetchEntriesByType($id);

                $types = $modelType->fetchEntries();

                $smarty->assign('mail_rattache', $mail_rattache);
                $smarty->assign('mail_non_rattache', $mail_non_rattache);
                $smarty->assign('types', $types);
                $smarty->assign('id', $id);

                $smarty->display('newsletter/rattacherMail.tpl');
            }
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function rattachemailAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $model = $this->_getModel();
            $request = $this->getRequest();
            $mail = $request->getParam('mail', '');
            $change = (int) $request->getParam('change', 0);
            $type = (int) $request->getParam('type', 0);
            if ($mail != '') {
                $modelMail = $this->_getModelMail();
                $email = $modelMail->fetchEntryByMail($mail);
                $data['idNewsletterMail'] = $email['idNewsletterMail'];
                $data['idNewsletterType'] = $type;
                if ($change == 1) {
                    $model->save(0, $data);
                } else {
                    $supp = $model->fetchEntryByMailAndType($data['idNewsletterMail'], $data['idNewsletterType']);
                    $model->delete($supp['idNewsletterMailType']);
                }
            }
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/NewsletterMailType.php';
            $this->_model = new Model_NewsletterMailType();
        }
        return $this->_model;
    }

    protected function _getModelMail() {
        if (null === $this->_modelMail) {
            require_once APPLICATION_PATH_COMMONS . '/models/NewsletterMail.php';
            $this->_modelMail = new Model_NewsletterMail();
        }
        return $this->_modelMail;
    }

    protected function _getModelType() {
        if (null === $this->_modelType) {
            require_once APPLICATION_PATH_COMMONS . '/models/NewsletterType.php';
            $this->_modelType = new Model_NewsletterType();
        }
        return $this->_modelType;
    }

    protected function _getNewsletterMailTypeForm() {
        require_once APPLICATION_PATH_COMMONS . '/forms/NewsletterType.php';
        $form = new Form_NewsletterType();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?id=' . $id));
        else
            $form->setAction($this->_helper->url('form'));
        return $form;
    }

}
