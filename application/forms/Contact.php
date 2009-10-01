<?php

class Form_Contact extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		
		$this->addElement('text', 'titre', array(
            'label'      => 'Sujet : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(3, 200))
            )
        ));
		
		$this->addElement('select', 'type', array(
            'label'      => 'Type : ',
            'required'   => true,
			'multiOptions' => array(
				'Demande d\'affiliation' => 'Demande d\'affiliation',
				'Demande de partenariat' => 'Demande de partenariat',
				'Suggestion' => 'Suggestion',
				'Problème site' => 'Problème site',
				'Autre...' => 'Autre...',
			)
        ));

        $this->addElement('text', 'mail', array(
            'label'      => 'Votre adresse mail : ',
            'required'   => true,
            'filters'    => array('StringTrim'),
            'validators' => array(
                'EmailAddress',
            )
        ));		

        $this->addElement('textarea', 'description', array(
            'label'      => 'Votre message : ',
            'required'   => true,
            'validators' => array(
                array('validator' => 'StringLength', 'options' => array(10, 1000))
                )
        ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
?>