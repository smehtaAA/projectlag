<?php

class Model_DbTable_FonctionCompte extends Zend_Db_Table_Abstract
{
    protected $_name    = 'fonctioncompte';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}