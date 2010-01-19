<?php

class Model_LanJoueur
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/lanjoueur.php';
            $this->_table = new Model_DbTable_lanjoueur;
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
			$where = $table->getAdapter()->quoteInto('idLanJoueur = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchEntriesByJoueur($id)
	{
		$table = $this->getTable();
		$select = $table->select()
							->from(array('lj' => 'lanjoueur'))
							->join(array('l'=>'lan'),'l.idLan=lj.idLan')
							->where('lj.idCompte = ?', $id)
							->setIntegrityCheck(false);
		
		
		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesByLan($idLan)
	{
        $table = $this->getTable();
        $select = $table->select()
						->from(array('lj' => 'LanJoueur'))
						->join(array('c' => 'Compte'),'c.idCompte=lj.idCompte')
						->where('idLan = ?', $idLan)
						->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
	}
	
	public function fetchEntriesByLanAndJoueur($idLan,$idCompte)
	{
        $table = $this->getTable();
        $select = $table->select()
						->from(array('lj' => 'LanJoueur'))
						->where('idLan = ?', $idLan)
						->where('idCompte = ?', $idCompte)
						->setIntegrityCheck(false);

        return $table->fetchRow($select)->toArray();
	}
	
    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idLanJoueur = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('lanjoueur','COUNT(idLanJoueur) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idLanJoueur = ?', $id);
		return $table->delete($where);

    }
}
