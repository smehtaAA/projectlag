<?php

class Form_NewsletterMail extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		
		$this->addElement('text', 'mail', array(
            'label'      => 'E-mail : ',
            'required'   => true,
            'filters'    => array('StringTrim'),
            'validators' => array('EmailAddress')
        ));
		
        $this->addElement('submit', 'submit', array(
            'label'    => 'Ok',
        ));
    }
}
