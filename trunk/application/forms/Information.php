<?php

class Form_Information extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$this->addElement('text', 'titre', array(
            'label'      => 'Titre : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(2, 30))
            )
        ));	
		
		$this->addElement('checkbox', 'affiche', array(
            'label'      => 'Visible : ',
            'required'   => true
        ));
		
		$this->addElement('file', 'img', array(
            'label'       => 'Image : ',
			'destination' => './images/info/',
            'required'    => false
        ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
