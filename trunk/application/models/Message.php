<?php

class Model_Message
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/Message.php';
            $this->_table = new Model_DbTable_Message;
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
			$where = $table->getAdapter()->quoteInto('idMessage = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchEntryBySujet($idSujet)
    {
		$table = $this->getTable();
		$select = $table->select()
						->from(array('m' => 'message'), array('idMessage', 'idCompte', 'description', 'date_m'))
						->where('idSujet = ?', $idSujet)
						->order('date_m');

		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntryCompteBySujet($idSujet)
    {
		$table = $this->getTable();
		$select = $table->select()
						->from(array('m' => 'message'), array('idCompte'))
						->where('idSujet = ?', $idSujet)
						->distinct('idCompte')
						->order('date_m');

		return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntryLast($idSsCat)
    {
		$table = $this->getTable();
		$select = $table->select()->from('message', array('idCompte', 'date_m'))
									->join('sujet', 'sujet.idSujet=message.idSujet', array('titre', 'idSujet'))
									->join('compte', 'compte.idCompte=message.idCompte', array('idCompte', 'login'))
									->where('idSousCategorie = ?', $idSsCat)
									->order('message.date_m DESC')->limit(1)
									->setIntegrityCheck(false);

		$table = $table->fetchRow($select);
		if(!empty($table))
			return $table->toArray();
		else
			return -1;
    }
	
    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idMessage = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('message','COUNT(idMessage) AS num');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function countEntriesbySsCat($idSsCat)
	{
		$table = $this->getTable();
		$select = $table->select()->from('message','COUNT(idMessage) AS num')->join('sujet', 'sujet.idSujet=message.idSujet', array('idSujet'))->where('idSousCategorie = ?', $idSsCat)->setIntegrityCheck(false);
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idMessage = ?', $id);
		return $table->delete($where);

    }
}
