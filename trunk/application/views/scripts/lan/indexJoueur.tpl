<h2> {$title} </h2>

<br/><br/>

{foreach from=$lans item=lan name=lan}

	<a href="?id={$lan.idLan}">{$lan.nom} </a><br/>
    {$lan.datedeb|date_format:"%d/%m/%Y"} <br/>
    {$lan.datefin|date_format:"%d/%m/%Y"} <br/>

{/foreach}