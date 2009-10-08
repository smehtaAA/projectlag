<h2> {$title} </h2>

<br/><br/>

{$lan.nom}

<br/><br/>
<a href="{$urladdjeu}"> S'inscrire &agrave; un nouveau jeu </a>
<br/><br/>

{foreach from=$jeux item=jeu name=jeu}

	{$jeu.nom} <br/>

{/foreach}