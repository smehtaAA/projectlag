<?php

class Model_DbTable_LanJoueur extends Zend_Db_Table_Abstract
{
    protected $_name    = 'lanjoueur';

    public function insert(array $data)
    {
		$data['dateins'] = date('Y-m-d H:i:s');
		return parent::insert($data);
    }
}