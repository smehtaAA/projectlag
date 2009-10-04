<?php

class Form_InscriptionLan extends My_InscriptionLan
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$validator=new Zend_Validate_GreaterThan(-1);
		
		$this->addElement('select', 'team', array(
            'label'      => 'Team : ',
            'required'       => false,
			'onchange' => 'javascript:verif_clan();',
			'registerInArrayValidator' => false,
            'validators' => array(
                 array($validator)
            )
        ));	
		
		$this->addElement('text', 'newteam', array(
            'label'      => 'Nouvelle Team : ',
            'required'       => false,
			'registerInArrayValidator' => false
        ));	
		
		$element = $this->getElement('newteam');
		$element->setDecorators(array(
					array('ViewHelper'),
		            array('Label'),
		            array('HtmlTag', array('tag' => 'div', 'id'=>'hide_new_team', 'class'=>'default_display_none'))
		));
		
		$this->addElement('multicheckbox', 'jeux', array(
            'label'      => 'Jeux : ',
            'required'   => true
        ));	

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
	
	public function RemplirJeux($jeux)
	{
		$je = $this->getElement('jeux');
		$je->addMultiOption("0", "Jeux Libres");
		
		foreach ($jeux as $j)
			$je->addMultiOption($j['idJeux'], $j['nom']);
	}
	
	public function RemplirTeam($teams)
	{
		$tea = $this->getElement('team');
		$tea->addMultiOption("-2", "------------");
		$tea->addMultiOption("0", "Pas dans la liste");
		$tea->addMultiOption("1", "Sans Team");
		$tea->addMultiOption("-1", "------------");
		
		foreach ($teams as $c)
			$tea->addMultiOption($c['idTeam'], $c['nom']);
	}
}
