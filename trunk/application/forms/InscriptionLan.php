<?php

class Form_InscriptionLan extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
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
		$je->addMultiOption("", "-----------");
		
		foreach ($jeux as $j)
			$je->addMultiOption($j['idJeux'], $j['nom']);
	}
}
