<?php

class Model_Bug
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH_COMMONS . '/models/DbTable/Bug.php';
            $this->_table = new Model_DbTable_Bug;
        }
        return $this->_table;
    }

    public function save($id,array $data)
    {	
        $table  = $this->getTable();
        $fields = $table->info(Zend_Db_Table_Abstract::COLS);
        foreach ($data as $field => $value) {
            if (!in_array($field, $fields)) {
                unset($data[$field]);
            }
        }
		if($id > 0) {
			$where = $table->getAdapter()->quoteInto('idBug = ?', $id);
			if($data['datedebug'] == "0000-00-00" && $data['statut'] == "Corrige") {
				$date = new Zend_Date();
				$data['datedebug'] = $date->toString('Y-MM-d');	
			}
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }

	public function fetchEntriesOrderByPriority()
    {
		$table = $this->getTable();
        $select = $table->select()->order('datebug DESC')->order('priorite')->where('datedebug = ?', '0000-00-00');

        return $table->fetchAll($select)->toArray();
		
    }
	
	public function fetchEntriesOrderByPriorityCorrige()
    {
		$table = $this->getTable();
        $select = $table->select()->order('priorite')->where('datedebug != ?', '0000-00-00');

        return $table->fetchAll($select)->toArray();
		
    }

    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idBug = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntriesLimitPage($start,$end)
	{
		$select = $this->getTable()->select()->order('datebug DESC')->limitPage($start, $end);
		return $this->getTable()->fetchAll($select)->toArray();
	}
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('bug','COUNT(idBug) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
        	public function delete($id)
    {
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idBug = ?', $id);
		return $table->delete($where);

    }
}
