<?php

class Model_DbTable_Newsletter extends Zend_Db_Table_Abstract
{
    protected $_name    = 'newsletter';

    public function insert(array $data)
    {
		$data['date'] = date('Y-m-d H:i:s');
		$data['IP'] = $_SERVER["REMOTE_ADDR"];
        return parent::insert($data);
    }
}