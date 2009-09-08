<?php

class Form_News extends Zend_Form
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
		
		$this->addElement('select', 'type_n', array(
            'label'          => 'Type : ',
            'required'       => false,
			'registerInArrayValidator' => false
        ));
		
		$this->addElement('text', 'creer_type_n', array(
            'label'          => 'Creer Type : ',
            'required'       => false,
			'validators'     => array(
                 array('validator' => 'StringLength', 'options' => array(3, 50))
            )
        ));
		
		$test = $this->getElement('creer_type_n');
		/*$test->setAttrib('style','display:none;');
		$this->addDisplayGroup(array(
        
                    'creer_type_n',
        
        ),'creer_type_n',array('legend' => 'Password'));*/

				
		$this->addElement('file', 'img', array(
            'label'       => 'Image : ',
			'destination' => '.',
            'required'    => false
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
		$type = $this->getElement('type_n');
		$type->addMultiOption("", "-----------");
		
		foreach ($typesDB as $c)
			$type->addMultiOption($c['type_n'], $c['type_n']);
	}
}
