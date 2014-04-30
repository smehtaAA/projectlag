<?php

class SujetController extends Zend_Controller_Action {

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
        $smarty = Zend_Registry::get('view');
        $request = $this->getRequest();
        $id = $request->getParam('id', 0);
        if ($id > 0) {
            $model = $this->_getModel();
            $modelMessage = $this->_getModelMessage();
            $modelCompte = $this->_getModelCompte();
            $modelLecture = $this->_getModelLecture();

            $log = new SessionLAG();
            if ($log->_getTypeConnected('superadmin') || $log->_getTypeConnected('admin') || $log->_getTypeConnected('joueur')) {
                $login = $modelCompte->fetchEntryForum($log->_getUser());
                if ($modelLecture->fetchEntriesByCompteAndSujet($log->_getUser(), $id) == 0)
                    $modelLecture->save(0, array('idCompte' => $log->_getUser(), 'idSujet' => $id));
            } else
                $login = 0;

            $sujet = $model->fetchEntryAuteur($id);
            $sujet['vu'] ++;
            $model->save($id, $sujet);

            $messages = $modelMessage->fetchEntryBySujet($id, 'date_m');
            $compte = $modelMessage->fetchEntryCompteBySujet($id);
            $comptes = null;
            foreach ($compte as $c) {
                $comptes[$c['idCompte']] = $modelCompte->fetchEntryForum($c['idCompte']);
                $comptes[$c['idCompte']]['nb_messages'] = $modelMessage->countEntriesByCompte($c['idCompte']);
            }
            $date = new Zend_Date();

            $fil_arianne = $model->fetchFilArianne($id);

            $smarty->assign('fil_arianne', $fil_arianne);
            $smarty->assign('datedujour', $date->toString('YYYY-M-dd HH:mm:ss'));
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('sujet', $sujet);
            $smarty->assign('login', $login);
            $smarty->assign('comptes', $comptes);
            $smarty->assign('messages', $messages);
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('url_del_message', $request->getBaseUrl() . '/message/del?id=');
            $smarty->assign('url_upd_message', $request->getBaseUrl() . '/message/form?idSujet=' . $sujet['idSujet'] . '&id=');
            $smarty->assign('url_del_sujet', $request->getBaseUrl() . '/sujet/del?id=');
            $smarty->assign('url_cloture_sujet', $request->getBaseUrl() . '/sujet/cloture?id=');
            $smarty->assign('url_reponse', $request->getBaseUrl() . '/message/form?idSujet=' . $sujet['idSujet']);

            $smarty->display('forum/sujet/index.tpl');
        } else {
            return $this->_helper->redirector('index', 'forum');
        }
    }

    public function formAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin') || $log->_getTypeConnected('joueur')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('id', 0);
            $idSsCat = (int) $request->getParam('idSsCat', 0);
            $form = $this->_getSujetForm($id, $idSsCat);
            $model = $this->_getModel();
            $modelMessage = $this->_getModelMessage();
            $modelGrade = $this->_getModelGrade();
            $modelCompte = $this->_getModelCompte();

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();
                    $dataform['idSousCategorie'] = $idSsCat;
                    $dataform['idCompte'] = $log->_getUser();
                    $dataform['titre'] = utf8_decode($dataform['titre']);


                    $idSujet = $model->save($id, $dataform);
                    $dataform['idSujet'] = $idSujet;



                    $modelMessage->save(0, $dataform);

                    $nb_messages = $modelMessage->countEntriesByCompte($log->_getUser());
                    if ($log->_getTypeConnected('joueur') && $nb_messages != -1) {
                        $new_grade = $modelGrade->fetchEntryByNbMessages($nb_messages);
                        $compte['idGrade'] = $new_grade['idGrade'];
                        $modelCompte->save($log->_getUser(), $compte);
                    }

                    return $this->_helper->redirector('index', 'sujet', '', array('id' => $idSujet));
                }
            } else {
                if ($id > 0) {
                    $data = $model->fetchEntry($id);
                    $data['titre'] = utf8_encode($data['titre']);
                    $form->populate($data);
                }
            }

            if ($id > 0)
                $smarty->assign('title', 'Modification Sujet');
            else
                $smarty->assign('title', 'Ajout Sujet');

            $smarty->assign('form', $form);
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->display('forum/sujet/form.tpl');
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
                $modelGrade = $this->_getModelGrade();
                $modelCompte = $this->_getModelCompte();
                $modelMessage = $this->_getModelMessage();
                $data = $model->fetchEntry($id);
                $model->delete($id);

                $mess = $modelMessage->fetchEntryBySujet($data['idSujet'], 'date_m');
                foreach ($mess as $m) {
                    $message = $modelMessage->fetchEntry($m['idMessage']);
                    $modelMessage->delete($m['idMessage']);

                    $nb_messages = $modelMessage->countEntriesByCompte($message['idCompte']);
                    if ($nb_messages != -1) {
                        $new_grade = $modelGrade->fetchEntryByNbMessages($nb_messages);
                        $compte['idGrade'] = $new_grade['idGrade'];
                        $modelCompte->save($message['idCompte'], $compte);
                    }
                }
            }
            return $this->_helper->redirector('index', 'souscategorie', '', array('id' => $data['idSousCategorie']));
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function clotureAction() {
        $log = new SessionLAG();
        $request = $this->getRequest();
        $idSujet = (int) $request->getParam('id', 0);
        $a = (int) $request->getParam('a', 0);
        $model = $this->_getModel();
        $sujet = $model->fetchEntryAuteur($idSujet);

        //if($log->_getTypeConnected('admin')||$log->_getTypeConnected('superadmin')) {

        if ($a == 1) {
            if ($log->_getTypeConnected('superadmin') || ($log->_getTypeConnected('admin') && ($sujet['nom'] == 'joueur' || $sujet['nom'] == 'admin')) || ($log->_getUser() == $sujet['idCompte'])) {
                if ($idSujet > 0) {
                    $model->save($idSujet, array('bloque' => $a));
                }
                return $this->_redirect('/sujet?id=' . $idSujet);
            }
        } elseif ($a == 0) {
            if ($log->_getTypeConnected('superadmin') || ($log->_getTypeConnected('admin') && ($sujet['nom'] == 'joueur' || $log->_getUser() == $sujet['idCompte']))) {
                if ($idSujet > 0) {
                    $model->save($idSujet, array('bloque' => $a));
                }
                return $this->_redirect('/sujet?id=' . $idSujet);
            }
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

    protected function _getModelGrade() {
        if (null === $this->_modelGrade) {
            require_once APPLICATION_PATH_COMMONS . '/models/Grade.php';
            $this->_modelGrade = new Model_Grade();
        }
        return $this->_modelGrade;
    }

    protected function _getModelCompte() {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }

    protected function _getModelLecture() {
        if (null === $this->_modelLecture) {
            require_once APPLICATION_PATH_COMMONS . '/models/Lecture.php';
            $this->_modelLecture = new Model_Lecture();
        }
        return $this->_modelLecture;
    }

    protected function _getSujetForm($id, $idSsCat) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Sujet.php';
        $form = new Form_Sujet();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?idSsCat=' . $idSsCat . '&id=' . $id));
        else
            $form->setAction($this->_helper->url('form?idSsCat=' . $idSsCat));
        return $form;
    }

}
