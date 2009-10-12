<?php

class Model_DbTable_Message extends Zend_Db_Table_Abstract
{
    protected $_name    = 'message';

    public function insert(array $data)
    {
		$data['date'] = date('Y-m-d H:i:s');
		$data['ip'] = $_SERVER["REMOTE_ADDR"];
        return parent::insert($data);
    }
}