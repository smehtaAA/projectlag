<?php

class Model_Grade
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH_COMMONS . '/models/DbTable/Grade.php';
            $this->_table = new Model_DbTable_Grade;
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
			$where = $table->getAdapter()->quoteInto('idGrade = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchEntriesOrderByNbMessages()
    {
		$table = $this->getTable();
		$select = $table->select()->order('nbmessages_mini');
		$stmt = $select->query();

		return $stmt->fetchAll();
    }
	
    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idGrade = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
    public function fetchEntryByNbMessages($nb)
    {
        $table = $this->getTable();
        $select = $table->select()->where('nbmessages_mini <= ?', $nb)->where('nbmessages_maxi >= ?', $nb);

        return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('grade','COUNT(idGrade) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idGrade = ?', $id);
		return $table->delete($where);

    }
}
