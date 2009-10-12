<?php

class Model_Partenaire
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/Partenaire.php';
            $this->_table = new Model_DbTable_Partenaire;
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
			$where = $table->getAdapter()->quoteInto('idPartenaire = ?', $id);
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

        return $table->fetchAll($select)->toArray();
    }
    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idPartenaire = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntriesTypes()
    {
        $table = $this->getTable();
        $select = $table->select()->distinct()->from(array('p' => 'partenaire'), 'type')->order('type');

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesL()
    {
        $table = $this->getTable();
        $select = $table->select()->distinct()->from(array('p' => 'partenaire'), array('titre', 'idPartenaire', 'logo', 'lien'))->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesType($type)
    {
        $table = $this->getTable();
        $select = $table->select()->where('type = ?', $type);

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntryByOrdre($ordre)
	{
		$table = $this->getTable();
        $select = $table->select()->where('ordre = ?', $ordre);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntryRandom()
	{
		$table = $this->getTable();
				
		$sql = 'SELECT idPartenaire, logo, titre, lien FROM partenaire ORDER BY RAND() LIMIT 1';
		
		$stmt = $table->getAdapter()->query($sql);

        return $stmt->fetchAll();
	}
	
	public function fetchEntriesLimitPage($start,$end)
	{
		$select = $this->getTable()->select()->limitPage($start, $end);
		return $this->getTable()->fetchAll($select)->toArray();
	}
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('partenaire','COUNT(idPartenaire) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idPartenaire = ?', $id);
		return $table->delete($where);

    }
}
