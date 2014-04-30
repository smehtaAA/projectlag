<?php

class Admin_StaffController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelCompte;
    protected $_modelStaffCompte;

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
            $modelStaffCompte = $this->_getModelStaffCompte();
            $request = $this->getRequest();
            /* Coder une fonction pour trouver le nombre de joueurs dans les teams */

            $staff = $model->fetchEntries();
            $comptes = null;
            $nb = null;
            foreach ($staff as $s) {
                $comptes[$s['idStaff']] = $modelStaffCompte->fetchEntriesByStaff($s['idStaff']);
                $nb[$s['idStaff']] = $modelStaffCompte->fetchNbByStaff($s['idStaff']);
            }

            $smarty->assign('titre', 'Staff');
            $smarty->assign('staff', $staff);
            $smarty->assign('comptes', $comptes);
            $smarty->assign('nb', $nb);
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('urlupdstaff', $request->getBaseUrl() . '/staff/form?idStaff=');
            $smarty->assign('urladdstaff', $request->getBaseUrl() . '/staff/form');
            $smarty->assign('urldelstaff', $request->getBaseUrl() . '/staff/del?idStaff=');
            $smarty->assign('urldelstaffcompte', $request->getBaseUrl() . '/staff/delstaffcompte?idStaffCompte=');
            $smarty->assign('urllinkcompte', $request->getBaseUrl() . '/staff/liercompte?idStaff=');
            $smarty->display('staff/indexAdmin.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function liercompteAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $idStaff = (int) $request->getParam('idStaff', 0);
            $id = (int) $request->getParam('id', 0);
            $form = $this->_getStaffCompteForm($id, $idStaff);
            $model = $this->_getModel();
            $modelStaffCompte = $this->_getModelStaffCompte();
            $modelCompte = $this->_getModelCompte();
            $staff = $model->fetchEntry($idStaff);
            $comptes = $modelCompte->fetchEntries();

            $form->RemplirComptes($comptes);


            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();
                    $dataform['idStaff'] = $idStaff;
                    $modelStaffCompte->save($id, $dataform);
                    return $this->_helper->redirector('indexadmin');
                }
            } else {
                if ($id > 0) {
                    $data = $model->fetchEntry($id);
                    $form->populate($data);
                }
            }
            $smarty->assign('titre', 'Choix du staff ' . $staff['nom']);
            $smarty->assign('form', $form);
            $smarty->display('staff/liercompte.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function formAction() {
        $smarty = Zend_Registry::get('view');
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('idStaff', 0);
            $form = $this->_getStaffForm($id);
            $model = $this->_getModel();

            if ($this->getRequest()->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $dataform = $form->getValues();
                    if ($id == 0) {
                        $nb = $model->countEntries();
                        $dataform['ordre'] = $nb + 1;
                    }
                    $model->save($id, $dataform);
                    return $this->_helper->redirector('indexadmin');
                }
            } else {
                if ($id > 0) {
                    $data = $model->fetchEntry($id);
                    $form->populate($data);
                }
            }

            if ($id > 0)
                $smarty->assign('titre', 'Modification Staff');
            else
                $smarty->assign('titre', 'Ajout Staff');

            $smarty->assign('form', $form);
            $smarty->display('staff/form.tpl');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function delstaffcompteAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('idStaffCompte', 0);
            if ($id > 0) {
                $modelStaffCompte = $this->_getModelStaffCompte();
                $modelStaffCompte->delete($id);
            }
            return $this->_helper->redirector('indexadmin');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function delAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $id = (int) $request->getParam('idStaff', 0);
            if ($id > 0) {
                $model = $this->_getModel();
                $modelStaffCompte = $this->_getModelStaffCompte();
                $modelStaffCompte->deleteByStaff($id);
                $data = $model->fetchEntry($id);
                $ordre = $data['ordre'];
                $model->delete($id);

                // Decalage des ordres
                $datas = $model->fetchEntries();
                foreach ($datas as $staff) {
                    if ($staff['ordre'] == $ordre + 1) {
                        $staff['ordre'] = $ordre;
                        $model->save($staff['idStaff'], $staff);
                        $ordre++;
                    }
                }
            }
            return $this->_helper->redirector('indexadmin');
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    public function changementordreAction() {
        $log = new SessionLAG();
        if ($log->_getTypeConnected('admin') || $log->_getTypeConnected('superadmin')) {
            $request = $this->getRequest();
            $model = $this->_getModel();
            $ordre = (int) $request->getParam('ordre', 0);
            $change = (string) $request->getParam('change');
            $data = $model->fetchEntryByOrdre($ordre);

            if ($change == "up") {
                $data['ordre'] = $data['ordre'] - 1;
                $staff = $model->fetchEntryByOrdre($data['ordre']);
                $staff['ordre'] = $staff['ordre'] + 1;
            } else {
                $data['ordre'] = $data['ordre'] + 1;
                $staff = $model->fetchEntryByOrdre($data['ordre']);
                $staff['ordre'] = $staff['ordre'] - 1;
            }

            $model->save($data['idStaff'], $data);
            $model->save($staff['idStaff'], $staff);

            /* Code a remplacer si on modifie l'action indexamin */
            $smarty = Zend_Registry::get('view');
            $modelStaffCompte = $this->_getModelStaffCompte();
            $request = $this->getRequest();

            $staff = $model->fetchEntries();
            $comptes = null;
            $nb = null;
            foreach ($staff as $s) {
                $comptes[$s['idStaff']] = $modelStaffCompte->fetchEntriesByStaff($s['idStaff']);
                $nb[$s['idStaff']] = $modelStaffCompte->fetchNbByStaff($s['idStaff']);
            }

            $smarty->assign('titre', 'Staff');
            $smarty->assign('staff', $staff);
            $smarty->assign('comptes', $comptes);
            $smarty->assign('nb', $nb);
            $smarty->assign('base_url', $request->getBaseUrl());
            $smarty->assign('urlupdstaff', $request->getBaseUrl() . '/staff/form?idStaff=');
            $smarty->assign('urladdstaff', $request->getBaseUrl() . '/staff/form');
            $smarty->assign('urldelstaff', $request->getBaseUrl() . '/staff/del?idStaff=');
            $smarty->assign('urldelstaffcompte', $request->getBaseUrl() . '/staff/delstaffcompte?idStaffCompte=');
            $smarty->assign('urllinkcompte', $request->getBaseUrl() . '/staff/liercompte?idStaff=');
            $smarty->display('staff/indexAdmin.tpl');
            /* ----------------------------------------------- */
        } else {
            $smarty->display('error/errorconnexion.tpl');
        }
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Staff.php';
            $this->_model = new Model_Staff();
        }
        return $this->_model;
    }

    protected function _getModelCompte() {
        if (null === $this->_modelCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/Compte.php';
            $this->_modelCompte = new Model_Compte();
        }
        return $this->_modelCompte;
    }

    protected function _getModelStaffCompte() {
        if (null === $this->_modelStaffCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/StaffCompte.php';
            $this->_modelStaffCompte = new Model_StaffCompte();
        }
        return $this->_modelStaffCompte;
    }

    protected function _getStaffForm($id) {
        require_once APPLICATION_PATH_COMMONS . '/forms/Staff.php';
        $form = new Form_Staff();
        if ($id > 0)
            $form->setAction($this->_helper->url('form/?idStaff=' . $id));
        else
            $form->setAction($this->_helper->url('form'));
        return $form;
    }

    protected function _getStaffCompteForm($id, $idStaff) {
        require_once APPLICATION_PATH_COMMONS . '/forms/StaffCompte.php';
        $form = new Form_StaffCompte();
        if ($id > 0)
            $form->setAction($this->_helper->url('liercompte/?idStaff=' . $idStaff . '&id=' . $id));
        else
            $form->setAction($this->_helper->url('liercompte?idStaff=' . $idStaff));
        return $form;
    }

}
