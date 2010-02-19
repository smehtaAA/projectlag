<?php

class Form_Contact extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		
        $this->addElement('text', 'titre', array(
            'label'      => 'Sujet : ',
            'required'   => true,
			'class'      => 'input-contact-text',
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(3, 200))
            )
        ));
		
        $this->addElement('select', 'type', array(
            'label'      => 'Type : ',
            'required'   => true,
			'class'      => 'input-contact-text',
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
			'class'      => 'input-contact-text',
            'filters'    => array('StringTrim'),
            'validators' => array(
                'EmailAddress',
            )
        ));		

        $this->addElement('textarea', 'description', array(
            'label'      => 'Votre message : ',
            'required'   => true,
			'rows' 		 => 15,
			'cols'       => 100,
            'validators' => array(
                array('validator' => 'StringLength', 'options' => array(10, 1000))
                )
        ));


            $this->addElement('Captcha','captcha',array(
                'label' => 'Vérification anti-robot (6 caractères) :',
                'required' => true,
                'captcha' => array(
                'captcha' => 'image',
                'name' => 'foo',
                'wordLen' => 6,
                'font' => 'scripts/arial.ttf',
                'fontSize' => 30,
                'imgDir' => 'images/captcha/',
                'imgUrl' => 'http://www.asso-lag.fr/images/captcha/',
                'timeout' => 300)
            ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
			'class'    => 'button'
        ));
    }
}
?>