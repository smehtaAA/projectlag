<?php

class Form_Log extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		
		$this->addElement('text', 'login', array(
            'label'      => 'Login : ',
            'required'   => true
        ));
		
		$this->addElement('password', 'password', array(
            'label'      => 'Mot de passe : ',
            'required'   => true,
			'filters'    => array(
				array('filter' => 'Md5')
			)
        ));
		
		$this->addElement('submit', 'submit', array(
            'label'    => 'Connexion',
        ));
    }
}
