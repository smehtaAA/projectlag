<?php

class Model_DbTable_Compte extends Zend_Db_Table_Abstract
{
    protected $_name    = 'compte';

    public function insert(array $data)
    {
		$data['dateins'] = date('Y-m-d H:i:s');
		$data['dateco'] = date('Y-m-d H:i:s');
		$data['IP'] = $_SERVER["REMOTE_ADDR"];
        return parent::insert($data);
    }
}