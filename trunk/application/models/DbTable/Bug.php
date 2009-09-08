<?php

class Model_DbTable_Bug extends Zend_Db_Table_Abstract
{
    protected $_name    = 'bug';

    public function insert(array $data)
    {
		$date = new Zend_Date();
		$data['datebug'] = $date->toString('Y-MM-d');
		$data['statut'] = "Non lu";
        return parent::insert($data);
    }
}