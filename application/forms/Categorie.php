<?php

class Form_Categorie extends Zend_Form
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
		
		$this->addElement('checkbox', 'visible', array(
            'label'      => 'Visible : ',
            'required'   => true
        ));

        $this->addElement('textarea', 'description', array(
            'label'      => 'Description : ',
            'required'   => true
        ));
		
		$this->addElement('hidden', 'ordre', array());

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
