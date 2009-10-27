<?php

class Model_News 
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH . '/models/DbTable/News.php';
            $this->_table = new Model_DbTable_News;
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
			$where = $table->getAdapter()->quoteInto('idNews = ?', $id);
			return $table->update($data,$where);
		}
		else
			return $table->insert($data);
    }

    public function fetchEntries()
    {
        return $this->getTable()->fetchAll('1')->toArray();
    }
	
	public function fetchEntriesTypes()
    {
        $table = $this->getTable();
        $select = $table->select()->distinct()->from(array('n' => 'news'), 'type_n')->order('type_n');

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesAsso($array)
    {
        $table = $this->getTable();
        $select = $table->select()->distinct()->from(array('n' => 'news'), $array)->where('n.idPartenaire=0')->order('date');

        return $table->fetchAll($select)->toArray();
    }
	
	public function fetchEntriesPart($array)
    {
        $table = $this->getTable();
        $select = $table->select()->distinct()->from(array('n' => 'news'), $array)->where('n.idPartenaire!=0')->order('date');

        return $table->fetchAll($select)->toArray();
    }

	public function fetchEntriesLimitPage($start,$end)
	{
		$select = $this->getTable()->select()->where('idPartenaire = 0')->order('date DESC')->limitPage($start, $end);
		return $this->getTable()->fetchAll($select)->toArray();
	}
	
	public function fetchEntriesPartenaireLimitPage($start,$end)
	{
		$select = $this->getTable()->select()
									->where('idPartenaire != 0')
									->order('date DESC')
									->limitPage($start, $end)
									->setIntegrityCheck(false);
		return $this->getTable()->fetchAll($select)->toArray();
	}
	
    public function fetchEntry($id)
    {
        $table = $this->getTable();
        $select = $table->select()->where('idNews = ?', $id);

        return $table->fetchRow($select)->toArray();
    }
	
	public function countEntries()
	{
		$table = $this->getTable();
		$select = $table->select()->from('news','COUNT(idNews) AS num')->where('idPartenaire=0');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function countEntriesPartenaires()
	{
		$table = $this->getTable();
		$select = $table->select()->from('news','COUNT(idNews) AS num')->where('idPartenaire!=0');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function countEntriesPartenaire()
	{
		$table = $this->getTable();
		$select = $table->select()->from('news','COUNT(idNews) AS num')->where('idPartenaire!=0');
		$row = $table->fetchRow($select);
        return $row->num;
	}
	
	public function delete($id)
    {	
		$table  = $this->getTable();
		$where = $table->getAdapter()->quoteInto('idNews = ?', $id);
		return $table->delete($where);

    }
}
