<?php

class Form_NewsletterType extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		
		$this->addElement('text', 'nom', array(
            'label'      => 'Nom : ',
            'required'   => true,
            'filters'    => array('StringTrim')
        ));
		
        $this->addElement('submit', 'submit', array(
            'label'    => 'Ok',
        ));
    }
}
