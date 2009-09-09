<?php

class Model_Lien 
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/Lien.php';
            $this->_table = new Model_DbTable_Lien;
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
			$where = $table->getAdapter()->quoteInto('idLien = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }

    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idLien = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntriesLimitPage($start,$end)
	{
		$select = $this->getTable()->select()->order('idLien')->limitPage($start, $end);
		return $this->getTable()->fetchAll($select)->toArray();
	}
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('lien','COUNT(idLien) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idLien = ?', $id);
		return $table->delete($where);

    }
}
