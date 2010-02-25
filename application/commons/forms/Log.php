<?php

class Form_Log extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		
		$this->addElement('text', 'login', array(
            'label'      => 'Login : ',
			'class'    => 'log',
            'required'   => true
        ));
		
		$this->addElement('password', 'password', array(
            'label'      => 'Mot de passe : ',
			'class'    => 'log',
            'required'   => true
        ));
		
		$this->addElement('submit', 'submit', array(
			'class'    => 'button',
            'label'    => 'Connexion',
        ));
    }
}
