<?php

class Form_Sujet extends Zend_Form
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
		
		$this->addElement('textarea', 'description', array(
            'label'      => 'Message : ',
            'required'   => true
        ));	

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
