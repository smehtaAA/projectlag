<?php

class Model_Compte
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/Compte.php';
            $this->_table = new Model_DbTable_Compte;
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

    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idCompte = ?', $id);
		
        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntryByLogin($login)
    {
        $table = $this->getTable();
        $select = $table->select()->where('login = ?', $login);
		
        return $table->fetchRow($select)->toArray();
    }
		
	public function fetchEntryByKey($key)
    {
        $table = $this->getTable();
        $select = $table->select()->where('keyvalidation = ?', $key);
		
        return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('compte','COUNT(idCompte) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idCompte = ?', $id);
		return $table->delete($where);

    }
	
	public function existLog(array $data)
    {
        $table = $this->getTable();
        $select = $table->select()->where('login = ?', $data['login'])->where('password = ?', 'l@g8?'.$data['password'].'pe6r!e8')->where('actif = 1');
		if($table->fetchRow($select)) {
        	return $table->fetchRow($select)->toArray();
		} else {
			return false;
		}
    }
}
