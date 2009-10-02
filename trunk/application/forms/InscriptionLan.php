<?php

class Form_InscriptionLan extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$this->addElement('select', 'team', array(
            'label'      => 'Team : ',
            'required'       => false,
			'onchange' => 'javascript:verif_clan();',
			'registerInArrayValidator' => false
        ));	
		
		$this->addElement('text', 'newteam', array(
            'label'      => 'Nouvelle Team : ',
            'required'       => false,
			'registerInArrayValidator' => false
        ));	
		
		$this->addElement('multicheckbox', 'jeux', array(
            'label'      => 'Jeux : ',
            'required'   => false
        ));	

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
	
	public function RemplirJeux($jeux)
	{
		$je = $this->getElement('jeux');
		
		foreach ($jeux as $j)
			$je->addMultiOption($j['idJeux'], $j['nom']);
	}
	
	public function RemplirTeam($teams)
	{
		$tea = $this->getElement('team');
		$tea->addMultiOption("new", "Pas dans la liste");
		
		foreach ($teams as $c)
			$tea->addMultiOption($c['idTeam'], $c['nom']);
	}
}
