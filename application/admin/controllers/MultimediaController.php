<?php

require_once '../library/My/Utils.php';

class Admin_MultimediaController extends Zend_Controller_Action {

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
            $request = $this->getRequest();
            $model = $this->_getModel();
            $datas = $model->fetchEntries();

            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('titre', 'Album Photos');
            $smarty->assign('urladd', 'form/');
            $smarty->assign('urladdphoto', 'formphoto/?id=');
            $smarty->assign('urlviewphoto', 'indexadminphotos/?id=');
            $smarty->assign('urlupd', 'form/?id=');
            $smarty->assign('urldel', 'del/?id=');
            $smarty->assign('datas', $datas);
            $smarty->display('multimedia/indexAdmin.tpl');
        } else {
            $smarty->assign('message', 'Erreur Connexion');
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function formAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            $form = $this->_getMultimediaForm($id);
            $model = $this->_getModel();
            $data = $model->fetchEntry($id);

            if ($this->getRequest()->isPost()) {
                $dataform = $form->getValues();
                $dataform["titre"] = utf8_decode($dataform["titre"]);
                $dataform["dossier"] = valideChaine($dataform["dossier"]);
                if ($id == 0 && !file_exists('images/photos/' . $dataform["dossier"] . '/'))
                    mkdir('images/photos/' . $dataform["dossier"] . '/', 755, true);
                else if ($id > 0 && !file_exists('images/photos/' . $dataform["dossier"] . '/'))
                    rename($data["dossier"], $dataform["dossier"]);

                $model->save($id, $dataform);
                return $this->_helper->redirector('indexadmin');
            } else {
                if ($id > 0) {
                    $data['titre'] = utf8_encode($data['titre']);
                    $form->populate($data);
                }
            }

            if ($id > 0)
                $smarty->assign('title', 'Modification Album Photo');
            else
                $smarty->assign('title', 'Ajout Album Photo');

            $smarty->assign('form', $form);
            $smarty->display('multimedia/form.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function formphotoAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLag();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            $form = $this->_getPhotosForm();
            $model = $this->_getModel();
            $data = $model->fetchEntry($id);

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    //$model->save($id,$form->getValues());
                    return $this->_helper->redirector('indexadmin');
                }
            }

            $smarty->assign('title', 'Ajouter plusieurs photos pour l\'album ' . $data['titre']);

            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('idMultimedia', $id);
            $smarty->assign('form', $form);
            $smarty->display('multimedia/formPhoto.tpl');
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
                $multimedia = $model->fetchEntry($id);
                $dir = 'images/photos/' . $multimedia["dossier"] . '/';
                if (file_exists($dir)) {
                    $dh = opendir($dir);
                    while ($f = readdir($dh)) {
                        if ($f != "." && $f != ".." && $f != ".svn")
                            unlink($dir . $f);
                    }
                    closedir($dh);
                    rmdir($dir);
                }
                $model->delete($id);
            }
            return $this->_helper->redirector('indexadmin');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Multimedia.php';
            $this->_model = new Model_Multimedia();
        }
        return $this->_model;
    }

    protected function _getMultimediaForm($id) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Multimedia.php';
        $form = new Form_Multimedia();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?id=' . $id));
        else
            $form->setAction($this->_helper->url('form'));
        return $form;
    }

    protected function _getPhotosForm($id) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Photos.php';
        $form = new Form_Photos();
        $form->setAction($this->_helper->url('indexadmin'));
        return $form;
    }

}
