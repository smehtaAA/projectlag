<?php

class Model_DbTable_Config extends Zend_Db_Table_Abstract
{
    protected $_name    = 'config';
	
    public function insert(array $data)
    {
        return parent::insert($data);
    }

}
