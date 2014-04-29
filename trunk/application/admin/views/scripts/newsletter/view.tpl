<h2>{$n.titre|utf8_encode}</h2>
<br/>
<strong> Date : </strong> {$n.date|date_format:"%d / %m / %Y"}
{$n.description|nl2br|utf8_encode}
<img src="{$baseurl}/images/newsletter/{$n.img}">