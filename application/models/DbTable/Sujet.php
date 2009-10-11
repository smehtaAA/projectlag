<?php

class Model_DbTable_Sujet extends Zend_Db_Table_Abstract
{
    protected $_name    = 'sujet';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}