<?php

class Model_DbTable_PlanSite extends Zend_Db_Table_Abstract
{
    protected $_name    = 'plansite';

    public function insert(array $data)
    {
        return parent::insert($data);
    }
}