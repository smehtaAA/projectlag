<?php

class Form_Jeux extends Zend_Form
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
		
		$this->addElement('select', 'type', array(
            'label'          => 'Type : ',
            'required'       => false,
			'registerInArrayValidator' => false
        ));
		
		$this->addElement('text', 'creer_type', array(
            'label'          => 'Creer Type : ',
            'required'       => false,
			'validators'     => array(
                 array('validator' => 'StringLength', 'options' => array(3, 50))
            )
        ));
		
		$this->addElement('text', 'datesortie', array(
            'label'      => 'Date de Sortie : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
		$this->addElement('text', 'lien', array(
            'label'      => 'Lien : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(2, 30))
            )
        ));	

        $this->addElement('textarea', 'description', array(
            'label'      => 'Description : ',
            'required'   => true
        ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
	
	public function RemplirType($typesDB)
	{
		$type = $this->getElement('type');
		$type->addMultiOption("", "-----------");
		
		foreach ($typesDB as $c)
			$type->addMultiOption($c['type'], $c['type']);
	}
}
