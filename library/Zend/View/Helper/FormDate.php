<?php

require_once 'Zend/View/Helper/FormElement.php';

class Zend_View_Helper_FormDate extends Zend_View_Helper_FormElement
{

    public function formDate($name, $value = null, $attribs = null,
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

		// month
		
		
		$day = array();
		
		$day[] = $this->_build('', 'Jour');
		for($i = 1; $i<=31; $i++){
			$j = date("d", mktime(0,0,0,0,$i));
			$day[] = $this->_build($j, $j);
		}
		
		$month = array();
		
		$month[] = $this->_build('', 'Mois');
		
		$zend_date = new Zend_Date();
		
		for($i = 1; $i<= 12; $i++){
			$m = $zend_date -> setMonth($i) -> toString('MMM');
			$month[] = $this->_build($m, $m);
		}
		
		$year = array();
		
		$year[] = $this->_build('','Année');
		for($i = (int)date("Y"); $i > 1950; $i--){
			$year[] = $this->_build($i, $i);
		}
		
        // add the options to the xhtml and close the select
        $day = $xhtml.implode("\n    ", $day) . "\n</select> ";
		$month = $xhtml.implode("\n    ", $month) . "\n</select> ";
        $year = $xhtml.implode("\n    ", $year) . "\n</select>";

        return $day.$month.$year;
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