<?php

class Model_LanJoueur
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/LanJoueur.php';
            $this->_table = new Model_DbTable_LanJoueur;
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
	
	public function fetchEntriesVille($idLan)
    {
        $table = $this->getTable();
        $select = $table->select()
						->from(array('lj' => 'lanjoueur'), array(''))
						->join(array('c' => 'compte'),'c.idCompte=lj.idCompte', array('ville'))
						->where('idLan = ?', $idLan)
						->distinct('ville')
						->setIntegrityCheck(false);
		
        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesVillePresents($idLan)
    {
        $table = $this->getTable();
        $select = $table->select()
						->from(array('lj' => 'lanjoueur'), array(''))
						->join(array('c' => 'compte'),'c.idCompte=lj.idCompte', array('ville'))
						->where('idLan = ?', $idLan)
						->where('present = 1')
						->distinct('ville')
						->setIntegrityCheck(false);
		
        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesByLan($idLan)
	{
        $table = $this->getTable();
        $select = $table->select()
						->from(array('lj' => 'lanjoueur'))
						->join(array('c' => 'compte'),'c.idCompte=lj.idCompte')
						->where('idLan = ?', $idLan)
						->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
	}
	
	public function fetchEntriesByLanField($idLan, $array)
	{
        $table = $this->getTable();
        $select = $table->select()
						->from(array('lj' => 'lanjoueur'),array('idLanJoueur', 'validation', 'idLan'))
						->join(array('c' => 'compte'),'c.idCompte=lj.idCompte', $array)
						->join(array('ljjt' => 'lanjeuxjoueurteam'),'ljjt.idLanJoueur=lj.idLanJoueur', array(''))
						->join(array('t' => 'team'),'ljjt.idTeam=t.idTeam', array('nom as nom_t'))
						->where('idLan = ?', $idLan)
						->distinct()
						->order('login')
						->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
	}
	
	public function fetchEntriesByLanPresentField($idLan, $array)
	{
        $table = $this->getTable();
        $select = $table->select()
						->from(array('lj' => 'lanjoueur'),array('idLanJoueur', 'validation', 'idLan'))
						->join(array('c' => 'compte'),'c.idCompte=lj.idCompte', $array)
						->join(array('ljjt' => 'lanjeuxjoueurteam'),'ljjt.idLanJoueur=lj.idLanJoueur', array(''))
						->join(array('t' => 'team'),'ljjt.idTeam=t.idTeam', array('nom as nom_t'))
						->where('idLan = ?', $idLan)
						->where('present = 1')
						->distinct()
						->order('login')
						->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
	}
	
	public function fetchEntriesByLanVilleField($idLan, $ville, $array)
	{
        $table = $this->getTable();
        $select = $table->select()
						->from(array('lj' => 'lanjoueur'),array('idLanJoueur', 'validation', 'idLan'))
						->join(array('c' => 'compte'),'c.idCompte=lj.idCompte', $array)
						->join(array('ljjt' => 'lanjeuxjoueurteam'),'ljjt.idLanJoueur=lj.idLanJoueur', array(''))
						->join(array('t' => 'team'),'ljjt.idTeam=t.idTeam', array('nom as nom_t'))
						->where('idLan = ?', $idLan)
						->where('c.ville = ?', $ville)
						->distinct()
						->order('login')
						->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
	}
	
	public function fetchEntriesByLanVillePresentsField($idLan, $ville, $array)
	{
        $table = $this->getTable();
        $select = $table->select()
						->from(array('lj' => 'lanjoueur'),array('idLanJoueur', 'validation', 'idLan'))
						->join(array('c' => 'compte'),'c.idCompte=lj.idCompte', $array)
						->join(array('ljjt' => 'lanjeuxjoueurteam'),'ljjt.idLanJoueur=lj.idLanJoueur', array(''))
						->join(array('t' => 'team'),'ljjt.idTeam=t.idTeam', array('nom as nom_t'))
						->where('idLan = ?', $idLan)
						->where('c.ville = ?', $ville)
						->where('present = 1')
						->distinct()
						->order('login')
						->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
	}

	public function fetchEntriesByLanAndJoueur($idLan,$idCompte)
	{
        $table = $this->getTable();
        $select = $table->select()
						->from(array('lj' => 'lanjoueur'))
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
	
    public function fetchEntryField($id, $array)
    {
        $table = $this->getTable();
        $select = $table->select()->from('lanjoueur', $array)->where('idLanJoueur = ?', $id);

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
