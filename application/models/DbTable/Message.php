<?php

class Model_DbTable_Message extends Zend_Db_Table_Abstract
{
    protected $_name    = 'message';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}