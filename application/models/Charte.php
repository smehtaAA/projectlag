<?php

class Model_Charte
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/Charte.php';
            $this->_table = new Model_DbTable_Charte;
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
			$where = $table->getAdapter()->quoteInto('idCharte = ?', $id);
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
	
	public function fetchEntriesOrderByOrdreJeux()
    {
		$table = $this->getTable();
		$select = $table->select()->order('ordre')->where('idJeux != 0');
		$stmt = $select->query();

		return $stmt->fetchAll();
    }
	
	public function fetchEntryByOrdre($ordre)
    {
		$table = $this->getTable();
		$select = $table->select()->where('ordre = ?', $ordre);

		return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntryAsso()
    {
		$table = $this->getTable();
		$select = $table->select()->where('idJeux = 0');

		return $table->fetchRow($select)->toArray();
    }
	
	public function fetchArticlesAsso()
	{
		$table = $this->getTable();
		$select = $table->select()
						->from(array('ca' => 'CharteArticle'))
						->where('idCharte = 1')
						->order('ordre')
						->setIntegrityCheck(false);

		return $table->fetchAll($select)->toArray();
	}
	
    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idCharte = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('charte','COUNT(idCharte) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idCharte = ?', $id);
		return $table->delete($where);

    }
}
