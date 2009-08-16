<?php
require_once 'Zend/Form/Element/Multi.php';

class Zend_Form_Element_Date extends Zend_Form_Element_Multi
{
    public $helper = 'formDate';
}