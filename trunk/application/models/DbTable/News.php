<?php

class Model_DbTable_News extends Zend_Db_Table_Abstract
{
    protected $_name    = 'news';

    public function insert(array $data)
    {
		$data['date'] = date('Y-m-d H:i:s');
        return parent::insert($data);
    }
}