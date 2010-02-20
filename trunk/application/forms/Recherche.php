<?php

class Form_Recherche extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
        $this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
	
		
        $this->addElement('text', 'q', array(
                'label'      => 'Votre Recherche : ',
                'class'      => 'input-contact-text',
                'required'   => true,
                'validators' => array(
                     array('validator' => 'StringLength', 'options' => array(3, 60))
                )
        ));


        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
