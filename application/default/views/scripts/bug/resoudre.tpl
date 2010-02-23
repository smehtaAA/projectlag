<h2> {$title|utf8_encode} </h2>

<br/>
Titre : {$data.titre|utf8_encode}
<br/>
Date : {$data.datebug|date_format:'%d/%m/%Y'}
<br/>
Navigateur : {$data.navigateur|utf8_encode}
<br/>
Categorie : {$data.categorie|utf8_encode}
<br/>



Description : {$data.description|nl2br|utf8_encode}

<br/>
<br/>

<br/>


{$form}