<?php

class Model_StaffCompte
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/StaffCompte.php';
            $this->_table = new Model_DbTable_StaffCompte;
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
			$where = $table->getAdapter()->quoteInto('idStaffCompte = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchEntriesByStaff($idStaff)
	{
		$table = $this->getTable();
        $select = $table->select()
						->from(array('sc' => 'staffcompte'))
						->join(array('c' => 'compte'),'c.idCompte=sc.idCompte', array('idCompte', 'nom', 'prenom', 'login', 'email', 'datenaissance', 'msn', 'description', 'site'))
						->where('idStaff = ?', $idStaff)
						->order('c.nom')
						->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
    }

    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idStaffCompte = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchNbByStaff($idStaff)
	{
		$table = $this->getTable();
		$select = $table->select()->from('staffcompte','COUNT(idStaffCompte) AS num')->where('idStaff=?', $idStaff);
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function fetchEntriesNonVides()
	{
		$table = $this->getTable();
				
		$sql = 'SELECT DISTINCT idStaff, nom, ordre FROM staff WHERE EXISTS (SELECT * FROM staffcompte WHERE staffcompte.idStaff=staff.idStaff) ORDER BY ordre';
		
		$stmt = $table->getAdapter()->query($sql);

        return $stmt->fetchAll();
	}
	
	public function fetchEntriesStaffUnik($idStaff)
	{
		$table = $this->getTable();
        $select = $table->select()
						->from(array('sc' => 'staffcompte'), array('idCompte'))
						->where('idStaff = ?', $idStaff);

        return $table->fetchAll($select)->toArray();
	}
	
	public function fetchEntriesStaffUnikCompte($idStaffCompte)
	{
		$table = $this->getTable();
        $select = $table->select()
						->from(array('sc' => 'staffcompte'))
						->join(array('s' => 'staff'),'s.idStaff=sc.idStaff')
						->where('idCompte = ?', $idStaffCompte)
						->order('ordre')
						->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
	}
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('staffcompte','COUNT(idStaffCompte) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idStaffCompte = ?', $id);
		return $table->delete($where);
    }
	
	public function deleteByStaff($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idStaff = ?', $id);
		return $table->delete($where);
    }
}
