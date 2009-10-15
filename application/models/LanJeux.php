<?php

class Model_LanJeux 
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/LanJeux.php';
            $this->_table = new Model_DbTable_LanJeux;
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
			$where = $table->getAdapter()->quoteInto('idLanJeux = ?', $id);
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
        $select = $table->select()->where('idLanJeux = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntriesByLan($idLan)
    {
        $table = $this->getTable();
        $select = $table->select()
							->from(array('lj' => 'lanjeux'), array('tournoi', 'nbmaxteam', 'nbmaxjoueur', 'nbmaxjoueurparteam'))
							->join(array('l'=>'lan'),'l.idLan=lj.idLan', array(''))
							->join(array('j'=>'jeux'),'j.idJeux=lj.idJeux', array('idJeux', 'nom'))
							->where('lj.idLan = ?', $idLan)
							->order('ordre')
							->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesByLanField($idLan, $array_lj, $array_l, $array_j)
    {
        $table = $this->getTable();
        $select = $table->select()
							->from(array('lj' => 'lanjeux'), $array_lj)
							->join(array('l'=>'lan'),'l.idLan=lj.idLan', $array_l)
							->join(array('j'=>'jeux'),'j.idJeux=lj.idJeux', $array_j)
							->where('lj.idLan = ?', $idLan)
							->order('ordre')
							->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
    }
	
	public function countEntriesByLan($idLan)
	{
		$table = $this->getTable();
		$select = $table->select()->from('lanjeux','COUNT(idLanJeux) AS num')->where('idLan = ?', $idLan);
		$row = $table->fetchRow($select);
        return $row->num;
		
	}
	
	public function fetchEntryByOrdreAndLan($idLan, $ordre)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idLan = ?', $idLan)->where('ordre = ?', $ordre);

        return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('lanjeux','COUNT(idLanJeux) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idLanJeux = ?', $id);
		return $table->delete($where);

    }
}
