<?php

class Model_Information
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH_COMMONS . '/models/DbTable/Information.php';
            $this->_table = new Model_DbTable_Information;
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
			$where = $table->getAdapter()->quoteInto('idInformation = ?', $id);
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
        $select = $table->select()->where('idInformation = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntriesAccueil()
    {
        $table = $this->getTable();
        $select = $table->select()->where('affiche = 1')->order('ordre')->limit(3);

        return $table->fetchAll($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('information','COUNT(idInformation) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idInformation = ?', $id);
		return $table->delete($where);

    }
}
