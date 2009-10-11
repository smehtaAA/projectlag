<?php

class Form_Compte extends My_CreationCompte
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		$modeform = Zend_Registry::get('modeform');
		
		$this->addElement('text', 'login', array(
            'label'      => 'Login : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(2, 30))
            )
        ));	
		
		
		if($modeform=='inscription') {
			
			$this->addElement('password', 'password', array(
				'label'      => 'Mot de passe : ',
				'required'   => true,
				'validators' => array(
					 array('validator' => 'StringLength', 'options' => array(2, 30))
				)
			));	
			
			$this->addElement('password', 'passwordconf', array(
				'label'      => 'Confirmation mot de passe : ',
				'required'   => true,
				'validators' => array(
					 array('validator' => 'StringLength', 'options' => array(2, 30))
				)
			));	
			
			$stringEquals = new Zend_Validate_StringEquals('password', 'passwordconf');
			$this->getElement('passwordconf')->addValidator($stringEquals);
		}
			
		
		$this->addElement('text', 'nom', array(
            'label'      => 'Nom : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(2, 30))
            )
        ));	
		
		$this->addElement('text', 'prenom', array(
            'label'      => 'Prénom : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(2, 60))
            )
        ));
		
		$this->addElement('text', 'email', array(
            'label'      => 'Email : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(2, 60), 'EmailAddress')
            )
        ));	
		
		$this->addElement('text', 'msn', array(
            'label'      => 'MSN : ',
            'required'   => false,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(2, 60), 'EmailAddress')
            )
        ));	
		
		$this->addElement('text', 'phone', array(
            'label'      => 'Telephone : ',
            'required'   => false,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(10,10))
            )
        ));
		
		$this->addElement('text', 'datenaissance', array(
            'label'      => 'Date de naissance : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
		$this->addElement('file', 'img', array(
            'label'       => 'Avatar : ',
			'destination' => './images/comptes/',
            'required'    => false
        ));
		
		$this->addElement('text', 'jeuxprefere', array(
            'label'      => 'Jeux préférés : ',
            'RegisterInArrayValidator' => false,
            'required'   => false
        ));
		
		$this->addElement('text', 'site', array(
            'label'      => 'Site : ',
            'RegisterInArrayValidator' => false,
            'required'   => false
        ));
		
		$this->addElement('text', 'configpc', array(
            'label'      => 'Config PC : ',
            'RegisterInArrayValidator' => false,
            'required'   => false
        ));
		
		$this->addElement('text', 'citationpreferee', array(
            'label'      => 'Citation préférée : ',
            'RegisterInArrayValidator' => false,
            'required'   => false
        ));

        $this->addElement('textarea', 'description', array(
            'label'      => 'Description : ',
			'rows'       => 5,
			'cols'       => 40,
            'required'   => false
        ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
			'class'    => 'button'
        ));
    }
}
