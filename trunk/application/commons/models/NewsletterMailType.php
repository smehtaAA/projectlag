<?php

class Model_NewsletterMailType
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH_COMMONS . '/models/DbTable/NewsletterMailType.php';
            $this->_table = new Model_DbTable_NewsletterMailType;
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
			$where = $table->getAdapter()->quoteInto('idNewsletterMailType = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchEntriesByType($id)
    {
        $table = $this->getTable();
        $select = $table->select()
				->from(array('m' => 'newslettermail'), array('mail'))
				->join(array('mt' => 'newslettermailtype'),'mt.idNewsletterMail=m.idNewsletterMail')
				->join(array('t' => 'newslettertype'),'mt.idNewsletterType=t.idNewsletterType')
				->where('mt.idNewsletterType = ?', $id)
				->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesMailByType($id)
    {
        $table = $this->getTable();
        $select = $table->select()
				->from(array('m' => 'newslettermail'), array('mail'))
				->join(array('mt' => 'newslettermailtype'),'mt.idNewsletterMail=m.idNewsletterMail', array(''))
				->join(array('t' => 'newslettertype'),'mt.idNewsletterType=t.idNewsletterType', array(''))
				->where('mt.idNewsletterType = ?', $id)
				->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesByMail($id)
    {
        $table = $this->getTable();
        $select = $table->select()
				->from(array('m' => 'newslettermail'), array('mail'))
				->join(array('mt' => 'newslettermailtype'),'mt.idNewsletterMail=m.idNewsletterMail')
				->join(array('t' => 'newslettertype'),'mt.idNewsletterType=t.idNewsletterType')
				->where('mt.idNewsletterMail = ?', $id)
				->setIntegrityCheck(false);

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesNonRattaches($id)
	{
		$table = $this->getTable();
				
		$sql = 'SELECT * FROM  newslettermail WHERE NOT EXISTS (
																SELECT NULL FROM  newslettermailtype WHERE  newslettermailtype.idNewsletterMail =  newslettermail.idNewsletterMail AND newslettermailtype.idNewsletterType=?)';
		
		$stmt = $table->getAdapter()->query($sql,$id);

        return $stmt->fetchAll();
	}

    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idNewsletterMailType = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntryByMailAndType($idMail, $idType)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idNewsletterMail = ?', $idMail)->where('idNewsletterType = ?', $idType);

        return $table->fetchRow($select)->toArray();
    }

    public function countEntriesByType($idType)
    {
        $table = $this->getTable();
        $select = $table->select()->from('newslettermailtype', 'COUNT(DISTINCT idNewsletterMail) as num')->where('idNewsletterType=?', $idType);

        $row = $table->fetchRow($select);
        return $row->num;

    }
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idNewsletterMailType = ?', $id);
		return $table->delete($where);

    }
	
	public function deleteByMail($idMail)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idNewsletterMail = ?', $idMail);
		return $table->delete($where);

    }
}
