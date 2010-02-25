<?php

class Model_DbTable_Jeux extends Zend_Db_Table_Abstract
{
    protected $_name    = 'jeux';

    public function insert(array $data)
    {
		return parent::insert($data);
    }
}