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
	
	public function fetchEntryForum($id)
    {
        $table = $this->getTable();
        $select = $table->select()->from(array('c'=>'compte'), array('idCompte','login', 'img'))
								->join(array('g' => 'grade'),'g.idGrade=c.idGrade')
								->where('c.idCompte = ?', $id)
								->setIntegrityCheck(false);
		
        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntryByLogin($login)
    {
        $table = $this->getTable();
        $select = $table->select()->where('login = ?', $login);
		
        $temp=$table->fetchRow($select);
		
		if(isset($temp))
        	return $temp->toArray();
		else
			return -1;
    }
		
	public function fetchEntryByKeyAndMail($key)
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
        $select = $table->select()->where('login = ?', $data['login'])->where('password = ?', $data['password'])->where('actif = 1');
		if($table->fetchRow($select)) {
        	return $table->fetchRow($select)->toArray();
		} else {
			return false;
		}
    }
}
