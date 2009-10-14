<?php

class Form_Grade extends Zend_Form
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
		
		$this->addElement('text', 'nbmessages_mini', array(
            'label'          => 'Nombre de Messages minimum : ',
            'required'       => false
        ));	
		
		$this->addElement('text', 'nbmessages_maxi', array(
            'label'          => 'Nombre de Messages maximum : ',
            'required'       => false
        ));	

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }

}
