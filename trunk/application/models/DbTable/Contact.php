<?php

class Model_DbTable_Contact extends Zend_Db_Table_Abstract
{
    protected $_name    = 'contact';

    public function insert(array $data)
    {
		$data['date'] = date('Y-m-d H:i:s');
		$data['IP'] = $_SERVER["REMOTE_ADDR"];
		$data['script'] = $_SERVER["SCRIPT_NAME"];
		$data['referrer'] = $_SERVER['HTTP_REFERER'];
		$data['remote_host'] = gethostbyaddr($_SERVER['REMOTE_ADDR']);
		$data['os'] = "os non dispo";
		$data['language'] = $_SERVER['HTTP_ACCEPT_LANGUAGE'];
		$data['user_agent'] = $_SERVER['HTTP_USER_AGENT'];
        return parent::insert($data);
    }
}