<h2> {$title} </h2>

<br/><br/>

{$lan.nom}

<br/><br/>
<a href="{$urladdjeu}"> S'inscrire &agrave; un nouveau jeu </a>
<br/><br/>

{if $jeux_libres != 0}
	Jeux libres <br/>
{/if}

{foreach from=$jeux item=jeu name=jeu}

	{$jeu.nom} <br/>

{/foreach}