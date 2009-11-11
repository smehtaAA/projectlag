<?php

class Model_PlanSite
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/PlanSite.php';
            $this->_table = new Model_DbTable_PlanSite;
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
			$where = $table->getAdapter()->quoteInto('idPlansite = ?', $id);
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
        $select = $table->select()->where('idPlansite = ?', $id);
        if($table->fetchRow($select) != null)
            return $table->fetchRow($select)->toArray();
        else
            return null;
    }

    public function fetchEntryByTitle($url)
    {
        $table = $this->getTable();
        $select = $table->select()->where('url = ?', $url);
        
        if($table->fetchRow($select) != null)
            return $table->fetchRow($select)->toArray();
        else
            return null;
    }

	public function delete($id)
    {
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idPlansite = ?', $id);
		return $table->delete($where);

    }
}
