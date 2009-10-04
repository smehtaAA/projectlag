<h2>{$titre}</h2>


{foreach from=$staffs name=staff item=s}

	<img src="{$base_url}/comptes/{$s.img}" align="right"/>

	<h4>{$s.nom}</h4>
    {foreach from=$comptes[$s.idStaff] name=compte item=c}
    <strong>Nom :</strong> {$c.nom} {$c.prenom} <br/>
    <strong>Pseudo :</strong> {$c.login|capitalize} <br/>
    <strong>Age : </strong> {$datedujour-$c.datenaissance}<br/>
    <strong>Mail : </strong> {$c.email} <br/>
    <strong>Msn : </strong> {$c.msn} <br/>
    <strong>Description : </strong> {$c.description} <br/>
    <strong>Site : </strong> {$c.site} <br/>
    
    {/foreach}
  	<br/>
{/foreach}