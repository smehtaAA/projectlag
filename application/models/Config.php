<?php

class Model_Config
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/Config.php';
            $this->_table = new Model_DbTable_Config;
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
			$where = $table->getAdapter()->quoteInto('idConfig = ?', $id);
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
        $select = $table->select()->where('idConfig = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntrySetting($setting)
    {
        $table = $this->getTable();
		try {
        	$select = $table->select()->where('setting = ?', $setting);
			return $table->fetchRow($select)->toArray();
		} catch (Exception $e) {
			echo $e;
		}
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('config','COUNT(idConfig) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idConfig = ?', $id);
		return $table->delete($where);

    }
}