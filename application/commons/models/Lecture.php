<?php

class Model_Lecture
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH_COMMONS . '/models/DbTable/Lecture.php';
            $this->_table = new Model_DbTable_Lecture;
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
			$where = $table->getAdapter()->quoteInto('idGrade = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchEntriesByCompteAndSujet($idCompte, $idSujet)
    {
		$table = $this->getTable();
		$select = $table->select()->where('idCompte = ?', $idCompte)->where('idSujet = ?', $idSujet);
		$temp = $table->fetchRow($select);
		if(isset($temp))
			return 1;
		else
			return 0;
    }
	
	public function fetchEntriesByCompteAndSousCategorie($idCompte, $idSousCategorie)
    {
		$table = $this->getTable();
		$select = $table->select()
						->from('lecture', 'COUNT(lecture.idSujet) AS num')
						->join('sujet', 'sujet.idSujet=lecture.idSujet', array(''))
						->where('lecture.idCompte = ?', $idCompte)
						->where('sujet.idSousCategorie = ?', $idSousCategorie)
						->setIntegrityCheck(false);
		$temp = $table->fetchRow($select);
		if(isset($temp))
			return $temp->num;
		else
			return 0;
    }
	
	public function fetchEntriesByCompteAndCategorie($idCompte, $idCategorie)
    {
		$table = $this->getTable();
		$select = $table->select()
						->from('sujet', array(''))
						->join('souscategorie', 'souscategorie.idSousCategorie=sujet.idSousCategorie', array('idSousCategorie'))
						->where('idCompte = ?', $idCompte)
						->where('idCategorie = ?', $idCategorie)
						->setIntegrityCheck(false);
		$temp = $table->fetchAll($select);
		if(isset($temp))
			return $temp->toArray();
		else
			return 0;
    }
    
    public function deleteBySujet($idSujet)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idSujet = ?', $idSujet);
		return $table->delete($where);
    }
		
	public function deleteByCompte($idCompte)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idCompte = ?', $idCompte);
		return $table->delete($where);
    }
	
	public function deleteBySujetNotCompte($idSujet,$idCompte)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idSujet = '.$idSujet , 'idCompte != '.$idCompte);
		return $table->delete($where);
    }
}
