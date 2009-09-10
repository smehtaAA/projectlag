<?php

class Model_DbTable_LanJeuxJoueurTeam extends Zend_Db_Table_Abstract
{
    protected $_name    = 'lanjeuxjoueurteam';

    public function insert(array $data)
    {
		return parent::insert($data);
    }
}