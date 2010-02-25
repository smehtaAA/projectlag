<?php

class Form_StaffCompte extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$validator=new Zend_Validate_GreaterThan(0);
		
		$this->addElement('select', 'idCompte', array(
            'label'      => 'Compte : ',
            'required'   => true,
            'validators' => array(
                 array($validator)
            )
        ));	

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
	
	public function RemplirComptes($comptes)
	{
		$s = $this->getElement('idCompte');
		$s->addMultiOption("0", "-----------");
		
		foreach ($comptes as $c)
			$s->addMultiOption($c['idCompte'], $c['nom'].' - '.$c['prenom']);
	}
}
