<?php

class Form_Charte extends Zend_Form
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
		
		$this->addElement('select', 'idJeux', array(
            'label'          => 'Jeux : ',
            'required'       => false,
			'registerInArrayValidator' => false
        ));	

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
	
	public function RemplirJeux($jeuxDB)
	{
		$type = $this->getElement('idJeux');
		$type->addMultiOption("", "-----------");
		
		foreach ($jeuxDB as $c)
			$type->addMultiOption($c['idJeux'], $c['nom']);
	}
}
