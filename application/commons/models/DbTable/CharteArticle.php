<?php

class Model_DbTable_CharteArticle extends Zend_Db_Table_Abstract
{
    protected $_name    = 'chartearticle';

    public function insert(array $data)
    {
		return parent::insert($data);
    }
}