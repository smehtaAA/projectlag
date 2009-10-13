<?php

class Model_Categorie
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/Categorie.php';
            $this->_table = new Model_DbTable_Categorie;
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
			$where = $table->getAdapter()->quoteInto('idCategorie = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchEntryField($id, $array) {
        $table = $this->getTable();
        $select = $table->select()->from('categorie', $array)->where('idCategorie = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
								
	
	public function fetchEntriesVisiblesAdmin()
	{
		$table = $this->getTable();
		$select = $table->select()->from('categorie', array('idCategorie', 'titre'))->where('visible=1')->order('ordre');

		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesVisibles()
	{
		$table = $this->getTable();
		$select = $table->select()->from('categorie', array('idCategorie', 'titre'))->where('visible=1')->where('admin=0')->order('ordre');

		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesOrderByOrdre()
    {
		$table = $this->getTable();
		$select = $table->select()->order('ordre');
		$stmt = $select->query();

		return $stmt->fetchAll();
    }
	
	public function fetchEntryByOrdre($ordre)
    {
		$table = $this->getTable();
		$select = $table->select()->where('ordre = ?', $ordre);

		return $table->fetchRow($select)->toArray();
    }
	
    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idCategorie = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('categorie','COUNT(idCategorie) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function countEntriesNonAdmin()
	{
		$table = $this->getTable();
		$select = $table->select()->from('categorie','COUNT(idCategorie) AS num')->where('admin=0');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idCategorie = ?', $id);
		return $table->delete($where);

    }
}
