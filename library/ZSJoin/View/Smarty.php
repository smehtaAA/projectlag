<?php

class ZSJoin_View_Smarty
{
    private $_smarty = false;

    public function __construct($data = '')
    {	
        $this->_smarty = new Smarty();

        $this->_smarty->template_dir = APPLICATION_PATH . $data . '/views/scripts/';
        $this->_smarty->compile_dir = APPLICATION_PATH . '/../smarty/views_c';
        $this->_smarty->cache_dir = APPLICATION_PATH . '/../smarty/cache';
		$this->_smarty->config_dir = APPLICATION_PATH . '/../smarty/configs';
    }

    /**
     * Assigns variables to Smarty
     */
    public function assign($spec, $value = null)
    {
        // which strategy to use?
        if(is_string($spec))
        {
            // assign by name and value
            if ('_' == substr($spec, 0, 1))
            {
                require_once 'Zend/View/Exception.php';
                throw new Zend_View_Exception('Setting private or protected class members is not allowed', $this);
            }
            $this->_smarty->assign($spec, $value);
        }
        elseif(is_array($spec))
        {
            // assign from associative array
            $error = false;
            foreach ($spec as $key => $val)
            {
                if ('_' == substr($key, 0, 1))
                {
                    $error = true;
                    break;
                }
                $this->_smarty->assign($key, $val);
            }
            if($error)
            {
                require_once 'Zend/View/Exception.php';
                throw new Zend_View_Exception('Setting private or protected class members is not allowed', $this);
            }
        }
        else
        {
            require_once 'Zend/View/Exception.php';
            throw new Zend_View_Exception('assign() expects a string or array, received ' . gettype($spec), $this);
        }

        return $this;
    }

    /**
     * Processes a template
     *
     * @param string $name The template to process.
     */
    public function display($name)
    {
        $this->_smarty->display($name);
    }
}
?>