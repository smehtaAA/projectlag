<h2>{$titre}</h2>
<br/>

{$lan.datedeb|date_format:"%d/%m/%Y"} - {$lan.datefin|date_format:"%d/%m/%Y"}

<br/>

{$lan.adresse}

<br/>

Nombre Max de personnes : {$lan.nbmaxpers}
<br/>
Prix : {$lan.prix}
<br/>
{if $lan.inscription==1} Date de l'ouverture : {$lan.date_inscription|date_format:"%d/%m/%Y"} {/if}
<br/>
Lan T&eacute;l&eacute;thon : {if $lan.telethon==1} Oui {else} Non {/if}
<br/>
Activation Pre paiement: {if $lan.prepaiement==1} Oui <br/> Prix : {$lan.prix_prepaiement}{else} Non {/if}

{$lan.description|nl2br}

<br/>

Joueurs Inscrits : {$chiffre.insc}
<br/>
Joueurs Présents : {$chiffre.present}
<br/>

Jeux joués :
<ul>
	{foreach from=$jeux item=j name=jeu}
    	<li>{$j.nom}</li>
    {/foreach}
</ul>