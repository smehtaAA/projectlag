<?php

class Model_DbTable_Sujet extends Zend_Db_Table_Abstract
{
    protected $_name    = 'sujet';

    public function insert(array $data)
    {
		$data['date'] = date('Y-m-d H:i:s');
		$data['vu'] = 0;
		$data['visible'] = 1;
		$data['IP'] = $_SERVER["REMOTE_ADDR"];
        return parent::insert($data);
    }
}