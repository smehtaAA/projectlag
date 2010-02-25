<?php

class Form_Photos extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');

		$this->addElement('file', 'img', array(
            'label'      => '',
            'required'   => false,
        ));
    }
}
