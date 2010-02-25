<?php

class Model_Recherche
{
    protected $_table;

    public function getTable()
    {
        if (null === $this->_table) {
            require_once APPLICATION_PATH_COMMONS . '/models/DbTable/Recherche.php';
            $this->_table = new Model_DbTable_Recherche;
        }
        return $this->_table;
    }

    public function fetchNews($query, $query_html)
    {
        $table = $this->getTable();
        /*$select = $table->select()->from('news');
        foreach($query as $q) {
             $select = $select->where("description LIKE '%".$q."%'");
        }

        foreach($query_html as $qh) {
             $select = $select->Orwhere("description LIKE '%".$qh."%'");
        }
        $select = $select->where('idPartenaire=0')->setIntegrityCheck(false);
        $temp = $table->fetchAll($select)->toArray();


        */

	$sql = 'SELECT * FROM news WHERE idPartenaire=0 AND ((';
        foreach($query as $q) {
             $sql = $sql."(description LIKE '%".$q."%' OR titre LIKE '%".utf8_decode($q)."%') AND ";
        }

        $sql = substr($sql, 0, strlen($sql)-5);
        $sql.=') OR ( ';

        foreach($query_html as $qh) {
             $sql = $sql."description LIKE '%".$qh."%' AND ";
        }

        $sql = substr($sql, 0, strlen($sql)-5);
        $sql.='))';


	$stmt = $table->getAdapter()->query($sql);

        $temp= $stmt->fetchAll();

        //return $sql;

        if(!empty($temp))
            return $temp;
        else
            return -1;

    }

    public function fetchLan($query, $query_html)
    {
        $table = $this->getTable();
	$sql = 'SELECT * FROM lan WHERE (';
        foreach($query as $q) {
             $sql = $sql."(description LIKE '%".$q."%' OR nom LIKE '%".utf8_decode($q)."%' OR extra LIKE '%".$q."%') AND ";
        }

        $sql = substr($sql, 0, strlen($sql)-5);
        $sql.=') OR ( ';

        foreach($query_html as $qh) {
             $sql = $sql."(description LIKE '%".$qh."%' OR extra LIKE '%".$qh."%') AND ";
        }

        $sql = substr($sql, 0, strlen($sql)-5);
        $sql.=')';

	$stmt = $table->getAdapter()->query($sql);

        $temp=$stmt->fetchAll();

        //return $sql;

        if(!empty($temp))
            return $temp;
        else
            return -1;

    }

    public function fetchForum($query, $query_html)
    {
        $table = $this->getTable();
	$sql = 'SELECT DISTINCT(idMessage), date_m, m.description, titre, login, m.idSujet FROM message m, sujet s, compte c WHERE c.idCompte=m.idCompte AND s.idSujet=m.idSujet AND ((';
        foreach($query as $q) {
             $sql = $sql."(m.description LIKE '%".$q."%') AND ";
        }

        $sql = substr($sql, 0, strlen($sql)-5);
        $sql.=') OR ( ';

        foreach($query_html as $qh) {
             $sql = $sql."(m.description LIKE '%".$qh."%') AND ";
        }

        $sql = substr($sql, 0, strlen($sql)-5);
        $sql.='))';

	$stmt = $table->getAdapter()->query($sql);

        $temp=$stmt->fetchAll();

        //return $sql;

        if(!empty($temp))
            return $temp;
        else
            return -1;

    }

    public function fetchNewsP($query, $query_html)
    {
        $table = $this->getTable();
	$sql = 'SELECT * FROM news WHERE idPartenaire>0 AND ((';
        foreach($query as $q) {
             $sql = $sql."(description LIKE '%".$q."%' OR titre LIKE '%".utf8_decode($q)."%') AND ";
        }

        $sql = substr($sql, 0, strlen($sql)-5);
        $sql.=') OR ( ';

        foreach($query_html as $qh) {
             $sql = $sql."description LIKE '%".$qh."%' AND ";
        }

        $sql = substr($sql, 0, strlen($sql)-5);
        $sql.='))';

	$stmt = $table->getAdapter()->query($sql);

        $temp= $stmt->fetchAll();

        //return $sql;

        if(!empty($temp))
            return $temp;
        else
            return -1;

    }

}
