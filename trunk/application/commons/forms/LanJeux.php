<?php

class Form_LanJeux extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$this->addElement('select', 'idJeux', array(
            'label'      => 'Jeu : ',
            'required'   => true,
			'registerInArrayValidator' => false
        ));	
		
		$this->addElement('text', 'nbmaxteam', array(
            'label'      => 'Nombre Max Team : ',
            'required'   => true
        ));	
		
		$this->addElement('text', 'nbmaxjoueur', array(
            'label'          => 'Nombre Max Joueur : ',
            'required'       => false
        ));
		
		$this->addElement('text', 'nbmaxjoueurparteam', array(
            'label'          => 'Nombre Joueur par Team : ',
            'required'       => false
        ));
		
		$this->addElement('checkbox', 'tournoi', array(
            'label'      => 'Tournoi : ',
            'RegisterInArrayValidator' => false,
            'required'   => true
        ));

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
	
	public function RemplirJeux($jeuxDB)
	{
		$jeu = $this->getElement('idJeux');
		$jeu->addMultiOption("", "-----------");
		
		foreach ($jeuxDB as $c)
			$jeu->addMultiOption($c['idJeux'], $c['nom']);
	}
}
