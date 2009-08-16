<?php

require_once 'Zend/View/Helper/FormElement.php';

class Zend_View_Helper_FormHeure extends Zend_View_Helper_FormElement
{

    public function formHeure($name, $value = null, $attribs = null,
        $options = null, $listsep = "<br />\n")
    {
        $info = $this->_getInfo($name, $value, $attribs, $options, $listsep);
        extract($info); // name, id, value, attribs, options, listsep, disable

        // force $value to array so we can compare multiple values
        // to multiple options.
        $value = (array) $value;

        // check if element may have multiple values
        $multiple = '';

        if (substr($name, -2) == '[]') {
            // multiple implied by the name
            $multiple = ' multiple="multiple"';
        }

        if (isset($attribs['multiple'])) {
            // Attribute set
            if ($attribs['multiple']) {
                // True attribute; set multiple attribute
                $multiple = ' multiple="multiple"';

                // Make sure name indicates multiple values are allowed
                if (!empty($multiple) && (substr($name, -2) != '[]')) {
                    $name .= '[]';
                }
            } else {
                // False attribute; ensure attribute not set
                $multiple = '';
            }
            unset($attribs['multiple']);
        } 

        // now start building the XHTML.
        $disabled = '';
        if (true === $disable) {
            $disabled = ' disabled="disabled"';
        }

        // Build the surrounding select element first.
        $xhtml = '<select'
                . ' name="' . $this->view->escape($name) . '[]"'
                . ' id="' . $this->view->escape($id) . '"'
                . $multiple
                . $disabled
                . $this->_htmlAttribs($attribs)
                . ">\n    ";

        // build the list of options

		// hour
		
		$zend_date = new Zend_Date();
		
		$hour = array();
		
		$hour[] = $this->_build('', 'Heure');
		for($i = 0; $i<=23; $i++){
			$h = $zend_date -> setHour($i) -> toString('HH');
			$hour[] = $this->_build($h, $h);
		}
		
		// minute
		
		$minute = array();
		
		$minute[] = $this->_build('', 'Minute');
		
		for($i = 1; $i<= 12; $i++){
			$m = $zend_date -> setMinute($i) -> toString('mm');
			$minute[] = $this->_build($m, $m);
		}
		
		
        // add the options to the xhtml and close the select
        $hour = $xhtml.implode("\n    ", $hour) . "\n</select> ";
		$minute = $xhtml.implode("\n    ", $minute) . "\n</select> ";

        return $minute.$hour;
    }

    protected function _build($value, $label)
    {

        $opt = '<option'
             . ' value="' . $this->view->escape($value) . '"'
             . ' label="' . $this->view->escape($label) . '"';

        $opt .= '>' . $this->view->escape($label) . "</option>";

        return $opt;
    }

}