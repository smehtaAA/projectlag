<?php

class Form_Mdp extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		
		$this->addElement('hidden', 'oldpasswordhidden', array(
            'label'      => '',
            'required'   => false,
        ));
		
		$this->addElement('password', 'oldpassword', array(
            'label'      => 'Ancien mot de passe : ',
            'required'   => true,
			'class'      => 'inputlog',
			'filters'     => array(
				array('filter' => 'md5')
			)
        ));
		
		$this->addElement('password', 'newpassword', array(
            'label'      => 'Nouveau mot de passe : ',
            'required'   => true,
			'class'      => 'inputlog',
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(6, 20))
            )
        ));
		
		$this->addElement('password', 'newpasswordconf', array(
            'label'      => 'Confirmation nouveau mot de passe : ',
            'required'   => true,
			'class'      => 'inputlog',
            'validators' => array(
                 array('validator' => 'StringLength', 'options' => array(6, 20))
            )
        ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Modifier',
			'class'      => 'inputbut',
        ));
		
		$stringEquals = new Zend_Validate_StringEquals('newpassword', 'newpasswordconf');
		$stringEquals2 = new Zend_Validate_StringEquals('oldpassword', 'oldpasswordhidden');
		$this->getElement('newpasswordconf')->addValidator($stringEquals);
		$this->getElement('oldpassword')->addValidator($stringEquals);
    }
}
