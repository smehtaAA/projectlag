{literal}
	<script type="text/javascript">
		function verif_clan()
		{
			if (document.getElementById('team').value == "0") {
				document.getElementById('hide_new_team').style.display = "";
				document.getElementById('hide_new_team').className="";
			}else {
				document.getElementById('hide_new_team').style.display = "none";
				document.getElementById('hide_new_team').className="default_display_none";
			}
		}
	</script>
{/literal}

<h2> Inscription &agrave; la lan {$lan.nom} </h2>

Date : {$lan.datedeb|date_format:"%d %m %Y"} <br/>
Lieu : {$lan.adresse|nl2br} <br/>

<h2> Informations sur {$joueur.login} </h2>

Email : {$joueur.email} <br/>

<h2> Jeux de la Lan </h2>

{foreach from=$jeux name=jeu item=jeu}

	{$jeu.nom} ({$jeu.nbmaxjoueurparteam}vs{$jeu.nbmaxjoueurparteam}) - 
    {if $jeu.tournoi==true}
    	Tournoi
    {else}
    	Jeu Fun
    {/if}
    
    <br/>


{/foreach}



<br/><br/><br/>

{$form}