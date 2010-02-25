<?php

class Model_DbTable_LanJeux extends Zend_Db_Table_Abstract
{
    protected $_name    = 'lanjeux';

    public function insert(array $data)
    {
		return parent::insert($data);
    }
}