<?php

class Form_LanJeuxJoueurTeam extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$this->addElement('hidden', 'idJeux', array());	
		
		$this->addElement('hidden', 'idLan', array());	
		
		$this->addElement('hidden', 'idCompte', array());
		
		$this->addElement('hidden', 'idTeam', array());
		
		$this->addElement('text', 'paiement', array(
            'label'      => 'Montant : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));
		
		$this->addElement('checkbox', 'validation', array(
            'label'      => 'Validation : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
