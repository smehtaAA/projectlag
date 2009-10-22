<?php

class Form_Newsletter extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$this->addElement('text', 'titre', array(
            'label'      => 'Titre : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(3, 100))
            )
        ));
				
		$this->addElement('file', 'img', array(
            'label'       => 'Image : ',
			'destination' => './images/newsletter/',
            'required'    => false
        ));
		
		$this->addElement('Multicheckbox', 'types', array(
			'label'		  => 'Types : ',
			'required'	  => true
		));

        $this->addElement('textarea', 'description', array(
            'label'      => 'Description : ',
            'required'   => true
        ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
		
		$imgelement = $this->getElement('img');
		$imgelement->addValidator('Count', false, 1);
		$imgelement->addValidator('Size', false, 5000000);
		$imgelement->addValidator('Extension', false, 'jpg,jpeg,png,gif');
    }
	
	public function RemplirType($typesDB)
	{
		$type = $this->getElement('types');
		
		foreach ($typesDB as $c)
			$type->addMultiOption($c['idNewsletterType'], $c['nom']);
	}
}
