<?php

class Form_Bug extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
	
		
		if(Zend_Registry::get('modeform') == 'modif') {
			
			$this->addElement('select', 'statut', array(
				'label'       => 'Statut : ',
				'required'    => true,
				'multiOptions' => array(
					 'Non lu'   => 'Non lu',
					 'Pris en compte' => 'Pris en compte',
					 'En cours' => 'En cours',
					 'Corrige' => 'Corrige'
				)
			));
			
			$this->addElement('select', 'priorite', array(
				'label'       => 'Priorite : ',
				'required'    => true,
				'multiOptions' => array(
					 1   => 'Urgent',
					 2 => 'Haute',
					 3 => 'Normal',
					 4 => 'Faible',
					 5 => 'Aucune'
				)
			));
			
			$this->addElement('textarea', 'noteDebugger', array(
				'label'      => 'Note : '
			));
			
			$this->addElement('hidden', 'datebug');
						
			$this->addElement('hidden', 'datedebug');
		} else {
			
				
		$this->addElement('text', 'titre', array(
            'label'      => 'Titre : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(3, 50))
            )
        ));
		
		$this->addElement('select', 'categorie', array(
            'label'       => 'Categorie : ',
            'required'    => true,
            'RegisterInArrayValidator' => false,
            'multiOptions' => array(
				 'Faute d\'orthographe'   => 'Faute d\'orthographe',
				 'Erreur' => 'Erreur'
			)
        ));
		
		$this->addElement('select', 'navigateur', array(
            'label'       => 'Navigateur : ',
            'required'    => true,
            'RegisterInArrayValidator' => false,
            'multiOptions' => array(
				 'Internet Explorer'   => 'Internet Explorer',
				 'Mozilla Firefox' => 'Mozilla Firefox',
				 'Opera'   => 'Opera',
				 'Safari'   => 'Safari',
				 'Chrome'   => 'Chrome'
			)
        ));

        $this->addElement('textarea', 'description', array(
            'label'      => 'Description : ',
            'required'   => true
        ));
		
		
		$this->addElement('captcha', 'captcha', array(
					'label'      => 'Veuillez entrer les 5 caractères écrits ci-dessus :',
					'required'   => true,
					'captcha'    => array('captcha' => 'Figlet', 'wordLen' => 5, 'timeout' => 300)
		));
		

		}

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
