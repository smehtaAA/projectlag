<?php

class Model_DbTable_Lecture extends Zend_Db_Table_Abstract
{
    protected $_name    = 'lecture';

    public function insert(array $data)
    {
		return parent::insert($data);
    }
}