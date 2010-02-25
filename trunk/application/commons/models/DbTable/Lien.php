<?php

class Model_DbTable_Lien extends Zend_Db_Table_Abstract
{
    protected $_name    = 'lien';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}