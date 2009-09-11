<?php

class Model_LanJeuxJoueurTeam
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/LanJeuxJoueurTeam.php';
            $this->_table = new Model_DbTable_LanJeuxJoueurTeam;
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
			$where = $table->getAdapter()->quoteInto('idLanJeuxJoueurTeam = ?', $id);
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
        $select = $table->select()->where('idLanJeuxJoueurTeam = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntriesByLan_Teams($idLan)
    {
        $table = $this->getTable();
        $select = $table->select()
							->from(array('ljjt' => 'lanjeuxjoueurteam'))
							->join(array('l'=>'lan'),'l.idLan=ljjt.idLan')
							->join(array('c'=>'compte'),'c.idCompte=ljjt.idCompte')
							->where('ljjt.idLan = ?', $idLan)
							->distinct('nom')
							->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesByLan_Team($idLan)
    {
        $table = $this->getTable();
        $select = $table->select()
							->from(array('ljjt' => 'lanjeuxjoueurteam'))
							->join(array('l'=>'lan'),'l.idLan=ljjt.idLan')
							->join(array('lj'=>'lanjeux'),'lj.idJeux=ljjt.idJeux')
							->join(array('c'=>'compte'),'c.idCompte=ljjt.idCompte')
							->where('ljjt.idLan = ?', $idLan)
							->where('lj.idLan = ?', $idLan)
							->order('lj.ordre')
							->distinct('nom')
							->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesByLanAndJeux($idLan, $idJeux)
	{
        $table = $this->getTable();
        $select = $table->select()
							->from(array('ljjt' => 'lanjeuxjoueurteam'), '')
							->join(array('t'=>'team'),'t.idTeam=ljjt.idTeam')
							->where('ljjt.idLan = ?', $idLan)
							->where('ljjt.idJeux = ?', $idJeux)
							->order('nom')
							->distinct('t.idTeam')
							->distinct('ljjt.idTeam')
							->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
	}
	
	public function fetchEntriesByLanAndJeuxAndTeam($idLan, $idJeux, $idTeam)
	{
        $table = $this->getTable();
        $select = $table->select()
							->from(array('ljjt' => 'lanjeuxjoueurteam'))
							->join(array('c'=>'compte'),'c.idCompte=ljjt.idCompte')
							->where('ljjt.idLan = ?', $idLan)
							->where('ljjt.idJeux = ?', $idJeux)
							->where('ljjt.idTeam = ?', $idTeam)
							->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
	}
	
	public function fetchEntriesByLan($idLan)
    {
        $table = $this->getTable();
        $select = $table->select()
							->from(array('ljjt' => 'lanjeuxjoueurteam'))
							->join(array('l'=>'lan'),'l.idLan=ljjt.idLan')
							->join(array('c'=>'compte'),'c.idCompte=ljjt.idCompte')
							->join(array('t'=>'team'),'t.idTeam=ljjt.idTeam')
							->where('ljjt.idLan = ?', $idLan)
							->order('ljjt.dateins')
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
		$select = $table->select()->from('lanjeuxjoueurteam','COUNT(idLanJeuxJoueurTeam) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idLanJeuxJoueurTeam = ?', $id);
		return $table->delete($where);

    }
}
