<?php

class MessageController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelMessage;
    protected $_modelCompte;
    protected $_modelGrade;
    protected $_modelLecture;

    public function __call($method, $args) {
        if ('Action' == substr($method, -6)) {
            return $this->_helper->redirector('index');
        }

        throw new Exception('Invalid method');
    }

    public function indexAction() {
        /* $smarty = Zend_Registry::get('view');
          $request = $this->getRequest();
         */
        return $this->_helper->redirector('index', 'forum');
    }

    public function formAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin') || $log->_getTypeConnected('joueur')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            $idSujet = (int) $request->getParam('idSujet', 0);
            if ($id == 0)
                Zend_Registry::set('modeform', 'ajout');
            else
                Zend_Registry::set('modeform', 'modif');

            $form = $this->_getMessageForm($id, $idSujet);
            $modelMessage = $this->_getModelMessage();
            $modelCompte = $this->_getModelCompte();
            $modelGrade = $this->_getModelGrade();
            $modelLecture = $this->_getModelLecture();
            $modelSujet = $this->_getModel();

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();
                    $dataform['idSujet'] = $idSujet;
                    if ($id == 0)
                        $dataform['idCompte'] = $log->_getUser();
                    else {
                        $dataform['date_edition'] = date('Y-m-d H:i:s');
                        $dataform['auteur_edition'] = $log->_getUser();
                    }

                    $modelMessage->save($id, $dataform);

                    $nb_messages = $modelMessage->countEntriesByCompte($log->_getUser());
                    if ($log->_getTypeConnected('joueur') && $nb_messages != -1) {
                        $new_grade = $modelGrade->fetchEntryByNbMessages($nb_messages);
                        $compte['idGrade'] = $new_grade['idGrade'];
                        $modelCompte->save($log->_getUser(), $compte);
                    }

                    $modelLecture->deleteBySujetNotCompte($idSujet, $log->_getUser());


                    return $this->_redirect('/sujet?id=' . $idSujet);
                }
            } else {
                if ($id > 0) {
                    $data = $modelMessage->fetchEntry($id);
                    if ($log->_getTypeConnected('superadmin') || $data['idCompte'] == $log->_getUser()) {
                        $form->populate($data);
                    } else {
                        $smarty->display('error/errorconnexion.tpl');
                        return $this->_redirect('/sujet?id=' . $idSujet);
                    }
                }
            }

            if ($id > 0)
                $smarty->assign('title', 'Modification Message');
            else
                $smarty->assign('title', 'Ajout Message');




            $sujet = $modelSujet->fetchEntryField($idSujet, array('idSujet', 'titre', 'date_s'));

            $messages = $modelMessage->fetchEntryBySujet($idSujet, 'date_m DESC');
            $compte = $modelMessage->fetchEntryCompteBySujet($idSujet);
            foreach ($compte as $c) {
                $comptes[$c['idCompte']] = $modelCompte->fetchEntryForum($c['idCompte']);
                $comptes[$c['idCompte']]['nb_messages'] = $modelMessage->countEntriesByCompte($c['idCompte']);
            }

            $smarty->assign('comptes', $comptes);
            $smarty->assign('messages', $messages);
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('sujet', $sujet);
            $smarty->assign('form', $form);
            $smarty->display('forum/message/form.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Sujet.php';
            $this->_model = new Model_Sujet();
        }
        return $this->_model;
    }

    protected function _getModelMessage() {
        if (null === $this->_modelMessage) {
            require_once APPLICATION_PATH_COMMONS . '/models/Message.php';
            $this->_modelMessage = new Model_Message();
        }
        return $this->_modelMessage;
    }

    protected function _getModelCompte() {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }

    protected function _getModelGrade() {
        if (null === $this->_modelGrade) {
            require_once APPLICATION_PATH_COMMONS . '/models/Grade.php';
            $this->_modelGrade = new Model_Grade();
        }
        return $this->_modelGrade;
    }

    protected function _getModelLecture() {
        if (null === $this->_modelLecture) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lecture.php';
            $this->_modelLecture = new Model_Lecture();
        }
        return $this->_modelLecture;
    }

    protected function _getMessageForm($id, $idSujet) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Message.php';
        $form = new Form_Message();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?idSujet=' . $idSujet . '&id=' . $id));
        else
            $form->setAction($this->_helper->url('form?idSujet=' . $idSujet));
        return $form;
    }

}
