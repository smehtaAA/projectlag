<?php

class Form_Lan extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$this->addElement('text', 'nom', array(
            'label'      => 'Nom : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(2, 30))
            )
        ));	
		
		$this->addElement('text', 'adresse', array(
            'label'      => 'Adresse : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(3, 60))
            )
        ));	
		
		$this->addElement('text', 'cp', array(
            'label'      => 'CP : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(5, 5))
            )
        ));	
		
		$this->addElement('text', 'ville', array(
            'label'      => 'Ville : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(3, 60))
            )
        ));	
		
		$this->addElement('text', 'datedeb', array(
            'label'      => 'Date de début : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
		$this->addElement('text', 'heuredeb', array(
            'label'      => 'Heure de début : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
		$this->addElement('text', 'minutedeb', array(
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
		$this->addElement('text', 'datefin', array(
            'label'      => 'Date de fin : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
		$this->addElement('text', 'heurefin', array(
            'label'      => 'Heure de fin : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
		$this->addElement('text', 'minutefin', array(
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
		$this->addElement('checkbox', 'inscription', array(
            'label'      => 'Ouverture des Inscriptions : ',
            'RegisterInArrayValidator' => false
        ));
		
		$this->addElement('checkbox', 'telethon', array(
            'label'      => 'Lan Telethon : ',
            'RegisterInArrayValidator' => false
        ));
		
		$this->addElement('checkbox', 'prepaiement', array(
            'label'      => 'Activer le prepaiement : ',
            'RegisterInArrayValidator' => false
        ));
		
		$this->addElement('text', 'prix_prepaiement', array(
            'label'      => 'Montant du prepaiement : ',
            'RegisterInArrayValidator' => false
        ));
		
		$this->addElement('text', 'prix_prepaiement_paypal', array(
            'label'      => 'Montant du prepaiement PayPal: ',
            'RegisterInArrayValidator' => false
        ));
		
		$this->addElement('text', 'nbmaxpers', array(
            'label'      => 'Nombre de Personnes Max : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
		$this->addElement('text', 'prix', array(
            'label'      => 'Entrée : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
        $this->addElement('textarea', 'extra', array(
            'label'      => 'Extra : ',
            'required'   => false
        ));

        $this->addElement('textarea', 'description', array(
            'label'      => 'Description : ',
            'required'   => true
        ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
