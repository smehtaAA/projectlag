<h2> {$title|utf8_encode} </h2>

<br/>
<a href="{$base_url}/contact/indexadmin"> Retour </a>
<br/>

<br/>


{$data.titre|utf8_encode}<br/>
{$data.date|date_format:"%d/%m/%Y"}<br/>
{$data.mail}<br/>

<br/>
{$data.description|nl2br|utf8_encode}