{literal}
<script type="text/javascript">
	function activationjoueur(obj, changement, idLan, url) {		
		$.ajax({
			type     : "POST",
			url      : url,
			async    : true,
			data     : "idLanJeuxJoueurTeam="+obj.name+"&change="+changement+"&idLan="+idLan,
			dateType : "html",
			error    : function(msg) {
				alert( "Error: " + msg );
			},
			success  : function(msg) {
					$("#tab_record").remove();
					$("#tab_content").html( $(msg).find("#tab_content").html())
					
			}
		});
	}
</script>
{/literal}

<h2>{$title}</h2>
<br/><br/>
A Faire !! : Lien pour lier un compte a une team et un jeux
<br /><br /><br /><br />
<div id="tab_content">
<table align="center" id="tab_record">
  <tr>
  	<th align="right" width="30"></th>
    <th align="left" width="200">Jeux</th>
    <th align="center" width="120">Team</th>
    <th align="center" width="80">Login</th>
    <th align="center" width="80">Prenom</th>
    <th align="center" width="80">Actif</th>
    <th width="30"> </th>
    <th align="center" width="100">Modifier</th>
    <th align="center" width="100">Supprimer</th>
  </tr>
{foreach from=$jeux key=myjeu item=i name=jeux}
  <tr>
  	<td align="right">{$smarty.foreach.jeux.index+1} - </td>
    <td>{$i.nom}</td>
  </tr>
  
  {foreach from=$teams[$i.idJeux] key=myteam item=team name=team}
    <tr>
    	<td></td>
    	<td></td>
    	<td align="center"> {$team.nom} </td> 
	</tr>
    
    {foreach from=$compte[$i.idJeux][$team.idTeam] key=mycompte item=cpt name=compte}
        <tr>
    		<td></td>
    		<td></td>
    		<td></td>
            <td align="center"> {$cpt.login} </td>
            <td align="center"> {$cpt.prenom} </td>
                <td align="center">
                {if $cpt.validation==1}
                    <img src="{$base_url}/images/admin/ball_green.png" name="{$cpt.idLanJeuxJoueurTeam}" alt="Desactiver" class="textalignm" title="Desactiver" onclick="javascript:activationjoueur(this,'d',{$cpt.idLan}, '{$base_url}/lanjeuxjoueurteam/activationjoueurteam')" />
                {else}
                    <img src="{$base_url}/images/admin/ball_red.png" name="{$cpt.idLanJeuxJoueurTeam}" alt="Activer" class="textalignm" title="Activer" onclick="javascript:activationjoueur(this,'a',{$cpt.idLan}, '{$base_url}/lanjeuxjoueurteam/activationjoueurteam')" />
                {/if}
                </td>
		</tr>
    {/foreach}
    
  {/foreach}
  
{/foreach}
</table>
</div>