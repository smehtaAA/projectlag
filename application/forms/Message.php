<?php

class Form_Message extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
		$this->setAttrib('enctype', Zend_Form::ENCTYPE_MULTIPART);
		$log = new SessionLAG();
		$modeform = Zend_Registry::get('modeform');
		
		$this->addElement('textarea', 'description', array(
            'label'      => 'Message : ',
            'required'   => true
        ));	
		
		if ($log->_getTypeConnected('superadmin') && $modeform=='modif') {
			$this->addElement('textarea', 'annotation_edition', array(
				'label'      => 'Annotation : '
			));
		}

        $this->addElement('submit', 'submit', array(
            'label'    => 'Envoyer',
        ));
    }
}
