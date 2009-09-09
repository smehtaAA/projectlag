<?php

class Model_DbTable_Partenaire extends Zend_Db_Table_Abstract
{
    protected $_name    = 'partenaire';

    public function insert(array $data)
    {
		$data['date'] = date('Y-m-d H:i:s');
        return parent::insert($data);
    }
}