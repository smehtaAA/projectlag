<?php

class Model_Sujet
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/Sujet.php';
            $this->_table = new Model_DbTable_Sujet;
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
			$where = $table->getAdapter()->quoteInto('idSujet = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchEntriesOrderByOrdre()
    {
		$table = $this->getTable();
		$select = $table->select()->order('ordre');
		$stmt = $select->query();

		return $stmt->fetchAll();
    }
	
	public function fetchEntryBySousCategorie($idssCat)
    {
		$table = $this->getTable();
		$select = $table->select()->where('idSousCategorie = ?', $idssCat)->order('date DESC');

		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntryByCategorieVisibles($idssCat)
    {
		$table = $this->getTable();
		$select = $table->select()->where('idSousCategorie = ?', $idssCat)->where('visible=1')->order('ordre');

		return $table->fetchAll($select)->toArray();
    }
	
    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idSujet = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('sujet','COUNT(idSujet) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function countEntriesbySousCategorie($idssCat)
	{
		$table = $this->getTable();
		$select = $table->select()->from('sujet','COUNT(idSujet) AS num')->where('idSousCategorie = ?', $idssCat);
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idSujet = ?', $id);
		return $table->delete($where);

    }
}
