<?php

class Model_FonctionCompte
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/FonctionCompte.php';
            $this->_table = new Model_DbTable_FonctionCompte;
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
			$where = $table->getAdapter()->quoteInto('idCompte = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchFonction($id)
	{
		$table = $this->getTable();
        $select = $table->select()
					->from(array('fc' => 'FonctionCompte'))
					->join(array('f' => 'fonction'),'fc.idFonction=f.idFonction')
					->where('fc.idCompte = ?', $id)
					->setIntegrityCheck(false);
		
        return $table->fetchAll($select)->toArray();
	}

    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idCompte = ?', $id);
		
        return $table->fetchRow($select)->toArray();
    }
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idCompte = ?', $id);
		return $table->delete($where);

    }
}
