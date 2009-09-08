<?php

class Model_DbTable_Lan extends Zend_Db_Table_Abstract
{
    protected $_name    = 'lan';

    public function insert(array $data)
    {
		return parent::insert($data);
    }
}