<?php

class Model_DbTable_MentionLegale extends Zend_Db_Table_Abstract
{
    protected $_name    = 'mentionlegale';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}