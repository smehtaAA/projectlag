<?php

class Model_DbTable_Multimedia extends Zend_Db_Table_Abstract
{
    protected $_name    = 'multimedia';

    public function insert(array $data)
    {
		$data['date'] = date('Y-m-d H:i:s');
        return parent::insert($data);
    }
}