<?php

class Model_Staff
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/Staff.php';
            $this->_table = new Model_DbTable_Staff;
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
			$where = $table->getAdapter()->quoteInto('idStaff = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        $table = $this->getTable();
        $select = $table->select()->order('ordre');

        return $table->fetchAll($select)->toArray();
    }

    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idStaff = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntriesUnik()
	{
		$table = $this->getTable();
		$select = $table->select()->where('unik = ?', "1");

		return $table->fetchAll($select)->toArray();
	}
	
	public function fetchEntryByOrdre($ordre)
    {
		$table = $this->getTable();
		$select = $table->select()->where('ordre = ?', $ordre);

		return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('staff','COUNT(idStaff) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idStaff = ?', $id);
		return $table->delete($where);

    }
}
