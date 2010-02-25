<?php

class Form_Config extends Zend_Form
{
    public function init()
    {
		$this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$this->addElement('text', 'valeur', array(
            'label'      => 'Valeur : ',
            'required'   => true
            
        ));
		
		$this->addElement('submit', 'submit', array(
            'label'    => 'Modifier',
        ));
		
		
	}
}
?>