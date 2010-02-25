<?php

class Model_DbTable_Staff extends Zend_Db_Table_Abstract
{
    protected $_name    = 'staff';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}