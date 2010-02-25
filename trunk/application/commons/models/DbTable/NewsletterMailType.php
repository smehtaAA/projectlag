<?php

class Model_DbTable_NewsletterMailType extends Zend_Db_Table_Abstract
{
    protected $_name    = 'newslettermailtype';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}