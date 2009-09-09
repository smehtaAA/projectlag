<?php

class Form_Partenaire extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$this->addElement('text', 'titre', array(
            'label'      => 'Titre : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(3, 50))
            )
        ));
		
		$this->addElement('text', 'lien', array(
            'label'      => 'Lien : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(6, 255))
            )
        ));
		
		$this->addElement('select', 'type', array(
            'label'        => 'Type : ',
			'registerInArrayValidator' => false,
            'required'     => false
        ));
		
		$this->addElement('text', 'creer_type', array(
            'label'          => 'Creer Type : ',
            'required'       => false,
			'validators'     => array(
                 array('validator' => 'StringLength', 'options' => array(3, 50))
            )
        ));
				
		$this->addElement('file', 'img', array(
            'label'       => 'Image : ',
			'destination' => '.',
            'required'    => false
        ));
		
		$this->addElement('hidden', 'ordre', array());
		
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