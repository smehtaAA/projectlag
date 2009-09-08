<?php

class Model_DbTable_NewsletterType extends Zend_Db_Table_Abstract
{
    protected $_name    = 'newslettertype';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}