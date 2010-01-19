<?php

class Form_ModificationInscriptionLan extends My_InscriptionLan
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		
		$this->addElement('multiCheckbox', 'jeux', array(
            'label'      => 'Jeux : ',
            'required'   => true
        ));	

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
	
	public function RemplirJeux($jeux, $jeux_libres)
	{
		$je = $this->getElement('jeux');
		if (!$jeux_libres)
			$je->addMultiOption("0", "Jeux Libres");
		
		foreach ($jeux as $j)
			$je->addMultiOption($j['idJeux'], $j['nom']);
	}

}
