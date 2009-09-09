<?php

class Form_Lien extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		
		$this->addElement('text', 'titre', array(
            'label'      => 'Titre : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(3, 100))
            )
        ));
		
		$this->addElement('text', 'lien', array(
            'label'      => 'Lien : ',
            'required'   => true,
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(6, 255))
            )
        ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
