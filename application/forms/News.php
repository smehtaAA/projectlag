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
		
		$this->addElement('select', 'idPartenaire', array(
            'label'          => 'Partenaire : ',
            'required'       => false,
			'registerInArrayValidator' => false
        ));
		
		$this->addElement('text', 'lien', array(
            'label'          => 'Source de la News : ',
            'required'       => false,
			'registerInArrayValidator' => false
        ));
		
		//$test = $this->getElement('creer_type_n');
		/*$test->setAttrib('style','display:none;');
		$this->addDisplayGroup(array(
        
                    'creer_type_n',
        
        ),'creer_type_n',array('legend' => 'Password'));*/

				
		$this->addElement('file', 'img', array(
            'label'       => 'Image : ',
			'destination' => './images/news/',
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
	
	public function RemplirPartenaire($partenairesDB)
	{
		$part = $this->getElement('idPartenaire');
		$part->addMultiOption("", "-----------");
		
		foreach ($partenairesDB as $c)
			$part->addMultiOption($c['idPartenaire'], $c['titre']);
	}
}
