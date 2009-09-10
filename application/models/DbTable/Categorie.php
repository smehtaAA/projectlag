<?php

class Model_DbTable_Categorie extends Zend_Db_Table_Abstract
{
    protected $_name    = 'categorie';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}