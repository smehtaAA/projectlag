<h2> {$title|utf8_encode} </h2>

<br/>
<a href="{$base_url}/contact/indexadmin"> Retour </a>
<br/>

<br/>

<table width="900">
    <tr><td width="100"><b>Titre</b></td><td> : </td><td>{$data.titre|utf8_encode}</td></tr>
    <tr><td><b>Type demande</b></td><td> : </td><td>{$data.type|utf8_encode}</td></tr>
    <tr><td><b>Date</b></td><td> : </td><td>{$data.date|date_format:"%d/%m/%Y"}</td></tr>
    <tr><td><b>Email</b></td><td> : </td><td>{$data.mail}</td></tr>
    <tr><td colspan="2" height="20"></td></tr>
    <tr><td><b>IP</b></td><td> : </td><td>{$data.IP}</td></tr>
    <tr><td><b>Remote Host</b></td><td> : </td><td>{$data.remote_host}</td></tr>
    <tr><td><b>Referrer</b></td><td> : </td><td>{$data.referrer}</td></tr>
    <tr><td><b>User Agent</b></td><td> : </td><td>{$data.user_agent}</td></tr>
    <tr><td><b>OS</b></td><td> : </td><td>{$data.os}</td></tr>
    <tr><td colspan="3" height="20"></td></tr>
    <tr><td colspan="3">{$data.description|nl2br|utf8_encode}</td></tr>
</table>