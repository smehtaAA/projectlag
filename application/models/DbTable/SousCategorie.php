<?php

class Model_DbTable_SousCategorie extends Zend_Db_Table_Abstract
{
    protected $_name    = 'souscategorie';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}