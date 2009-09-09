<?php

class Model_DbTable_Fonction extends Zend_Db_Table_Abstract
{
    protected $_name    = 'fonction';

    public function insert(array $data)
    {
		return parent::insert($data);
    }
}