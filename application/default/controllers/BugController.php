<?php

class BugController extends Zend_Controller_Action {

    protected $_model;

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('index');
        }

        throw new Exception('Invalid method');
    }

    public function indexadminAction() {
        return $this->_helper->redirector('form');
    }
    public function remerciementAction() {
        // Page de remerciement
        $smarty = Zend_Registry::get('view');
        $model = $this->_getModel();
        $request = $this->getRequest();

        $smarty->assign('titre', 'Signaler un bug');
        $smarty->assign('base_url', $request->getBaseUrl());
        $smarty->display('bug/remerciement.tpl');
    }

    public function formAction() {
        $smarty = Zend_Registry::get('view');

        $request = $this->getRequest();
        $id = (int) $request->getParam('id', 0);
        $log = new SessionLAG();
        $form = $this->_getBugForm($id, $log->_getType());
        $model = $this->_getModel();

        if ($this->getRequest()->isPost()) {
            if ($form->isValid($request->getPost())) {
                $dataform = $form->getValues();

                function decode(&$value) {
                    $value = utf8_decode($value);
                }

                array_walk($dataform, 'decode');
                $model->save($id, $dataform);
                if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
                    return $this->_helper->redirector('indexadmin');
                } else {
                    $this->sendMail($form->getValues());
                    return $this->_helper->redirector('remerciement');
                }
            }
        } else {
            if ($id > 0 && $log->_getTypeConnected('admin')) {
                $data = $model->fetchEntry($id);
                $form->populate($data);
            }
        }


        if ($id > 0)
            $smarty->assign('title', 'Bug');
        else
            $smarty->assign('title', 'Signaler un bug');

        $smarty->assign('form', $form);
        $smarty->display('bug/form.tpl');
    }

    protected function sendMail($data) {
        // Fonction d'envoi du mail sur association.lag@gmail.com
        $destinataire = 'association.lag@gmail.com';
        $subject = "Bug depuis le site Local Arena Games";
        $from = "From: Bug - Local Arena Games <bug@asso-lag.fr>\n";
        $from .= "X-Priority: 1\n";
        $from .= "MIME-version: 1.0\n";
        $from .= "Content-type: text/html; charset=utf-8\n";
        $from .= "Content-Transfer-Encoding: 8bit\n\n";
        $msg = "<html><head></head><body>
				<div style='font: normal 12px Arial;'>
				<b>Signaler bug - Local Arena Games</b><br /><br />
				<b>Categorie :</b> " . $data['categorie'] . "<br />
				<b>Navigateur :</b> " . $data['navigateur'] . "<br />
				<b>Titre :</b> " . $data['titre'] . "<br /><br />
				<b>Description :</b> " . $data['description'] . "</div>
				</body></html>";
        mail($destinataire, $subject, $msg, $from);
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Bug.php';
            $this->_model = new Model_Bug();
        }
        return $this->_model;
    }

    protected function _getBugForm($id, $type) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Bug.php';

        if (($id > 0 && $type == 'admin') || ($id > 0 && $type == 'superadmin'))
            Zend_Registry::set('modeform', 'modif');
        else
            Zend_Registry::set('modeform', 'ajout');

        $form = new Form_Bug();

        if ($id > 0)
            $form->setAction($this->_helper->url('form/?id=' . $id));
        else
            $form->setAction($this->_helper->url('form'));

        return $form;
    }

}
