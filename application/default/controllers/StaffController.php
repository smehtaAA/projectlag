<?php

class StaffController extends Zend_Controller_Action {

    protected $_model;
    protected $_modelStaffCompte;

    public function indexAction() {
        $smarty = Zend_Registry::get('view');
        $model = $this->_getModel();
        $modelStaffCompte = $this->_getModelStaffCompte();
        $request = $this->getRequest();
        $staff = $modelStaffCompte->fetchEntriesNonVides();
        $comptes = null;
        foreach ($staff as $s)
            $comptes[$s['idStaff']] = $modelStaffCompte->fetchEntriesByStaff($s['idStaff']);



        /*
          -------------------------------------------
          fonction permettant d'afficher les multi staff
          -------------------------------------------
          $staffcompte = null;
          $multistaff = null;
          foreach($staff as $s)
          $multistaff[$s['idStaff']] = false;

          $staffunik = $model->fetchEntriesUnik();
          foreach($staffunik as $su)
          {
          $c[$su['idStaff']] = $modelStaffCompte->fetchEntriesStaffUnik($su['idStaff']);
          foreach($c[$su['idStaff']] as $cs)
          {
          $staffcompte[$su['idStaff']] = $modelStaffCompte->fetchEntriesStaffUnikCompte($cs['idCompte']);
          $multistaff[$su['idStaff']] = true;

          }
          }

          $smarty->assign('multistaff',$multistaff);
          $smarty->assign('staffcomptes',$staffcompte); */

        $date = new Zend_Date();

        $smarty->assign('datedujour', $date->toString('YYYY-M-dd'));
        $smarty->assign('comptes', $comptes);
        $smarty->assign('titre', 'Staff');
        $smarty->assign('base_url', $request->getBaseUrl());

        $smarty->assign('staffs', $staff);

        $smarty->display('staff/index.tpl');
    }

    protected function _getModel() {
        if (null === $this->_model) {
            require_once APPLICATION_PATH_COMMONS . '/models/Staff.php';
            $this->_model = new Model_Staff();
        }
        return $this->_model;
    }

    protected function _getModelStaffCompte() {
        if (null === $this->_modelStaffCompte) {
            require_once APPLICATION_PATH_COMMONS . '/models/StaffCompte.php';
            $this->_modelStaffCompte = new Model_StaffCompte();
        }
        return $this->_modelStaffCompte;
    }

}
