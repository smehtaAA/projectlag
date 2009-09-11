<?php

class Model_Lan 
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/Lan.php';
            $this->_table = new Model_DbTable_Lan;
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
			$where = $table->getAdapter()->quoteInto('idLan = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchEntriesorderByDate()
    {
        $table = $this->getTable();
        $select = $table->select()->order('datedeb DESC');

        return $table->fetchAll($select)->toArray();
    }
	
    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idLan = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntriesCount($idLan)
    {
        $table = $this->getTable();
		$select = $table->select()
							->from(array('ljjt' => 'lanjeuxjoueurteam'), array('COUNT(DISTINCT ljjt.idCompte) as insc', 'COUNT(DISTINCT ljjt.idTeam) as teams'))
							->where('ljjt.idLan = ?', $idLan)
							->setIntegrityCheck(false);
		
		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesCountJeux($idLan)
    {
        $table = $this->getTable();
		$select = $table->select()
							->from(array('lj' => 'lanjeux'), array('idLan', 'COUNT(DISTINCT lj.idJeux) as jeux'))
							->where('lj.idLan = ?', $idLan)
							->setIntegrityCheck(false);
		
		return $table->fetchRow($select)->jeux;
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('lan','COUNT(idLan) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idLan = ?', $id);
		return $table->delete($where);

    }
}
