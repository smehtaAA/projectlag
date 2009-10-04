<?php

class Model_DbTable_StaffCompte extends Zend_Db_Table_Abstract
{
    protected $_name    = 'staffcompte';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}