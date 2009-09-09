<?php

class Form_Fonction extends Zend_Form
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
		
		$this->addElement('hidden', 'ordre', array());	
		$this->addElement('checkbox', 'afficher', array(
			'label'      => 'Afficher : '
		));
		$this->addElement('checkbox', 'sceller', array(
			'label'      => 'Sceller : '
		));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
