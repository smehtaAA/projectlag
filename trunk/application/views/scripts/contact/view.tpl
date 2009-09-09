<h2> {$title} </h2>

<br/>
<a href="{$base_url}/contact/indexadmin"> Retour </a>
<br/>

<br/>


{$data.titre}<br/>
{$data.date|date_format:"%d/%m/%Y"}<br/>
{$data.mail}<br/>

<br/>
{$data.description|nl2br}