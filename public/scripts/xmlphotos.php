<?php
$xml = '<?xml version="1.0" encoding="UTF-8"?>

		<simpleviewergallery
			
			galleryStyle="MODERN"
			title=""
			textColor="FFFFFF"
			frameColor="CCCCCC"
			frameWidth="10"
			thumbPosition="LEFT"
			thumbColumns="3"
			thumbRows="4"
			showOpenButton="TRUE"
			showFullscreenButton="FALSE"	
			captionPosition="OVERLAY_BOTTOM"
			maxImageWidth="500"
			maxImageHeight="500"
			useFlickr="false"
			flickrUserName=""
			flickrTags=""
			languageCode="AUTO"
			languageList=""		
			imagePath="/images/photos/lagtelethon2009/"
			thumbPath="/images/photos/lagtelethon2009/thumbs/"
			
		>';
		
$dir = opendir("../images/photos/lagtelethon2009/") or die('Erreur');
$list = array();
while($file = @readdir($dir))  {
	if($file != '.' && $file != '..'&& $file != 'thumbs')
		$list[] = $file;
}
closedir($dir);
asort($list);
foreach($list as $file) {
	$xml .= '<image imageURL="/images/photos/lagtelethon2009/'.$file.'" thumbURL="/images/photos/lagtelethon2009/thumbs/'.$file.'" linkURL="" linkTarget="" >
				<caption></caption>	
			</image>';
}
				
$xml .= '</simpleviewergallery>';

echo $xml;
?>