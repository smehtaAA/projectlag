<?php

class Admin_UploadController extends Zend_Controller_Action
{
	public function indexAction()
	{
		if (!empty($_FILES)) {
			$tempFile = $_FILES['Filedata']['tmp_name'];
			$targetPath = $_SERVER['DOCUMENT_ROOT'] . $_REQUEST['folder'] . '/';
			$targetFile =  str_replace('//','/',$targetPath) . $_FILES['Filedata']['name'];
			
			$fileTypes  = str_replace('*.','',$_REQUEST['fileext']);
			$fileTypes  = str_replace(';','|',$fileTypes);
			$typesArray = split('\|',$fileTypes);
			$fileParts  = pathinfo($_FILES['Filedata']['name']);
			
			if (in_array(strtolower($fileParts['extension']),$typesArray))			
				move_uploaded_file($tempFile,$targetFile);
		}		
	}
}