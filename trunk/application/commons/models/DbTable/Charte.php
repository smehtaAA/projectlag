<?php

class Model_DbTable_Charte extends Zend_Db_Table_Abstract
{
    protected $_name    = 'charte';

    public function insert(array $data)
    {
		return parent::insert($data);
    }
}