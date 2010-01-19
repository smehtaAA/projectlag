<?php
$xml = '<?xml version="1.0" encoding="UTF-8"?>

			
		<simpleviewergallery thumbFrameWidth="1"
			galleryStyle="MODERN"
			thumbHoverFrameWidth="4"
			buttonBarPosition="OVERLAY"
			captionPadding="20"
			captionBackOpacity="0.5"
			captionPosition="OVERLAY_BOTTOM"
			titlePosition="NONE"
			stageBorder="10"
			stageVPadding="10"
			stageHPadding="20"
			thumbPosition="LEFT"
			thumbVAlign="TOP"
			imageVAlign="TOP"
			thumbColumns="3"
			thumbRows="5"
			embedColor="009ADF"
			showFullscreenButton="FALSE"	
			imageNavColor="FFFFFF"
			frameColor="2E220F"
			frameWidth="1"
			maxImageWidth="800"
			maxImageHeight="600"
			imageFrameStyle="SQUARE"
			imageDropShadow="true"
			imageTransitionType="FADE"
			thumbFrameColor="EEE1CA"
			thumbFrameHoverColor="EEE1CA"
			thumbNavBackColor="2E220F"
			thumbNavColor="EEE1CA"
			thumbNavHoverColor="EEE1CA"
			thumbNavStyle="NUMERIC"
			thumbNavPosition="CENTER"
			
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