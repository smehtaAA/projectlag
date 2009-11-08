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
                'class'      => 'input-contact-text',
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
                'class'      => 'input-contact-text',
				'multiOptions' => array(
					 1   => 'Urgent',
					 2 => 'Haute',
					 3 => 'Normal',
					 4 => 'Faible',
					 5 => 'Aucune'
				)
			));
			
			$this->addElement('textarea', 'noteDebugger', array(
				'label'      => 'Note : ',
                'rows' 		 => 15,
                'cols'       => 100,
			));
			
			$this->addElement('hidden', 'datebug');
						
			$this->addElement('hidden', 'datedebug');
		} else {
			

            $this->addElement('text', 'titre', array(
                'label'      => 'Titre : ',
                'class'      => 'input-contact-text',
                'required'   => true,
                'validators' => array(
                     array('validator' => 'StringLength', 'options' => array(3, 60))
                )
            ));

            $this->addElement('select', 'categorie', array(
                'label'       => 'Catégorie : ',
                'class'      => 'input-contact-text',
                'required'    => true,
                'RegisterInArrayValidator' => false,
                'multiOptions' => array(
                     'Erreur' => 'Erreur',
                     'Faute d\'orthographe'   => 'Faute d\'orthographe',
                     'Autre'   => 'Autre',
                )
            ));

            $this->addElement('select', 'navigateur', array(
                'label'       => 'Navigateur : ',
                'class'      => 'input-contact-text',
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
                'rows' 		 => 15,
                'cols'       => 100,
                'required'   => true
            ));

		}

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
