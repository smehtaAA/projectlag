<?php

class Model_DbTable_Information extends Zend_Db_Table_Abstract
{
    protected $_name    = 'information';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}