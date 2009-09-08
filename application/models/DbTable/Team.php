<?php

class Model_DbTable_Team extends Zend_Db_Table_Abstract
{
    protected $_name    = 'team';

    public function insert(array $data)
    {
		return parent::insert($data);
    }
}