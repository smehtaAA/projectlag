<?php

class Model_DbTable_Grade extends Zend_Db_Table_Abstract
{
    protected $_name    = 'grade';

    public function insert(array $data)
    {
		return parent::insert($data);
    }
}