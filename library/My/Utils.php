<?php

function valideChaine($chaineNonValide)
{
	 $accents = array('À','Á','Â','Ã','Ä','Å','Ç','È','É','Ê','Ë','Ì','Í','Î','Ï','Ò','Ó','Ô','Õ','Ö','Ù','Ú','Û','Ü','Ý','à','á','â','ã','ä','å','ç','è','é','ê','ë','ì','í','î','ï','ð','ò','ó','ô','õ','ö','ù','ú','û','ü','ý','ÿ');
	$sans = array('A','A','A','A','A','A','C','E','E','E','E','I','I','I','I','O','O','O','O','O','U','U','U','U','Y','a','a','a','a','a','a','c','e','e','e','e','i','i','i','i','o','o','o','o','o','o','u','u','u','u','y','y');
	$chaineValide=str_replace($accents, $sans, $chaineNonValide);
	
  $chaineValide = preg_replace('`\s+`', '_', trim($chaineValide));
  $chaineValide = str_replace("'", "_", $chaineValide);
  $chaineValide = str_replace("^", "_", $chaineValide);
  $chaineValide = preg_replace('`_+`', '_', trim($chaineValide));

  return ($chaineValide);
}

?>