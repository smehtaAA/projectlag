<?php

class Model_DbTable_NewsletterMail extends Zend_Db_Table_Abstract
{
    protected $_name    = 'newslettermail';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}