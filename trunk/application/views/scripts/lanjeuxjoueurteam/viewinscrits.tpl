{literal}
<script type="text/javascript">
	function activationjoueur(obj, changement, idLan, url) {		
		$.ajax({
			type     : "POST",
			url      : url,
			async    : true,
			data     : "idLanJoueur="+obj.name+"&change="+changement+"&idLan="+idLan,
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

<h2>{$title|utf8_encode}</h2>

<br /><br />
<div id="tab_content">
<table align="center" id="tab_record" width="950">
  <tr>
  	<th></th>
    <th align="left" width="100">Login</th>
    <th align="center" width="80">Nom</th>
    <th align="center" width="80">Pr&eacute;nom</th>
    <th align="center" width="150">Team</th>
    <th align="center" width="100">Date Ins</th>
    <th align="center" width="80">Actif</th>
    <th width="70"> </th>
    <th align="center">Modifier</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.login|utf8_encode}</td>
    <td align="center">{$i.nom|utf8_encode}</td>
    <td align="center">{$i.prenom|utf8_encode}</td>
    <td align="center">{$i.nom_t|utf8_encode}</td>
    <td align="center">{$i.dateins|date_format:"%d/%m/%Y"}</td>
    <td align="center">
    {if $i.validation==1}
    	<img src="{$base_url}/images/admin/ball_green.png" name="{$i.idLanJoueur}" alt="Desactiver" class="textalignm" title="Desactiver" onclick="javascript:activationjoueur(this,'d',{$i.idLan}, '{$base_url}/lanjeuxjoueurteam/activationjoueur')" />
    {else}
    	<img src="{$base_url}/images/admin/ball_red.png" name="{$i.idLanJoueur}" alt="Activer" class="textalignm" title="Activer" onclick="javascript:activationjoueur(this,'a',{$i.idLan}, '{$base_url}/lanjeuxjoueurteam/activationjoueur')" />
    {/if}
    </td>
    
    
    <td></td>
    <td align="center"><a href="{$urlupd}{$i.idLanJoueur}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idLanJoueur}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>
</div>