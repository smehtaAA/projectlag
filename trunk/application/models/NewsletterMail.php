<?php

class Model_NewsletterMail
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/NewsletterMail.php';
            $this->_table = new Model_DbTable_NewsletterMail;
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
			$where = $table->getAdapter()->quoteInto('idNewsletterMail = ?', $id);
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
        $select = $table->select()->where('idNewsletterMail = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function fetchEntryByMail($mail)
	{
        $table = $this->getTable();
        $select = $table->select()->where('mail = ?', $mail);

		$temp = $table->fetchRow($select);
		if(isset($temp))
        	return $temp->toArray();
		else
			return -1;
    }
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idNewsletterMail = ?', $id);
		return $table->delete($where);

    }
}
