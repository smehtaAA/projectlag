<?php

class Model_SousCategorie
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/SousCategorie.php';
            $this->_table = new Model_DbTable_SousCategorie;
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
			$where = $table->getAdapter()->quoteInto('idSousCategorie = ?', $id);
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
	
	public function fetchEntryByOrdreAndCategorie($ordre, $idCat)
    {
		$table = $this->getTable();
		$select = $table->select()->where('idCategorie = ?', $idCat)->where('ordre = ?', $ordre);

		return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntryByCategorie($idCat)
    {
		$table = $this->getTable();
		$select = $table->select()->from('souscategorie', $array)->where('idCategorie = ?', $idCat)->order('ordre');

		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntryByCategorieField($idCat, $array)
    {
		$table = $this->getTable();
		$select = $table->select()->where('idCategorie = ?', $idCat)->where('admin=0')->order('ordre');

		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntryByCategorieAdminField($idCat, $array)
    {
		$table = $this->getTable();
		$select = $table->select()->where('idCategorie = ?', $idCat)->order('ordre');

		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntryByCategorieVisibles($idCat)
    {
		$table = $this->getTable();
		$select = $table->select()->from('souscategorie', array('idSousCategorie', 'titre', 'description'))->where('idCategorie = ?', $idCat)->where('visible=1')->where('admin=0')->order('ordre');

		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntryByCategorieVisiblesAdmin($idCat)
    {
		$table = $this->getTable();
		$select = $table->select()->from('souscategorie', array('idSousCategorie', 'titre', 'description'))->where('idCategorie = ?', $idCat)->where('visible=1')->order('ordre');

		return $table->fetchAll($select)->toArray();
    }
	
    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idSousCategorie = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
    public function fetchEntryL($id)
    {
        $table = $this->getTable();
        $select = $table->select()->from('souscategorie', array('idSousCategorie', 'titre', 'idCategorie'))->where('idSousCategorie = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('souscategorie','COUNT(idSousCategorie) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function countEntriesbyCategorie($idCat)
	{
		$table = $this->getTable();
		$select = $table->select()->from('souscategorie','COUNT(idSousCategorie) AS num')->where('idCategorie = ?', $idCat);
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idSousCategorie = ?', $id);
		return $table->delete($where);

    }
}
