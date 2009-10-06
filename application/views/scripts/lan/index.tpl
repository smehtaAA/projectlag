<h2>{$titre}</h2>

<br/> <br/>

{foreach from=$lans item=l name=lan}
	<strong>{$l.nom}</strong> - {$l.datedeb|date_format:"%d/%m/%Y a %H:%M"} jusqu'au {$l.datefin|date_format:"%d/%m/%Y a %H:%M"} - - - {$chiffre[$l.idLan].present}/{$chiffre[$l.idLan].insc}
    
    <br/><br/>
    <ul>
    {foreach from=$jeux[$l.idLan] item=j name=jeu}
    	<li>{$j.nom}</li>
    {/foreach}
    </ul>
    <br/>
    {$l.description|nl2br}

{/foreach}