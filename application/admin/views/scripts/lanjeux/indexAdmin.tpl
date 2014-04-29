{literal}
<script type="text/javascript">
	function changerordre(obj, changement, idLanJeux, idLan, url) {
		$.ajax({
			type     : "POST",
			url      : url,
			async    : true,
			data     : "idLan="+idLan+"&change="+changement+"&idLanJeux="+idLanJeux,
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

<a href="{$urladd}"><img src="{$base_url}/images/admin/add.png" alt="Ajouter une team" class="textalignm" title="Ajouter" /> Ajouter un Jeux &agrave; cette Lan</a>
<br /><br />
<div id="tab_content">
<table align="center" id="tab_record">
  <tr>
  	<th></th>
    <th align="left" width="200">Nom</th>
    <th align="center" width="80">Nb Team</th>
    <th align="center" width="80">Nb Joueur</th>
    <th align="center" width="80">Joueur/Team</th>
    <th align="center" width="80">Tournoi</th>
    <th align="center" width="60" colspan="2">Ordre</th>
    <th width="70"> </th>
    <th width="70" align="center">Modifier</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.nom|utf8_encode}</td>
    <td align="center">{$i.nbmaxteam}</td>
    <td align="center">{$i.nbmaxjoueur}</td>
    <td align="center">{$i.nbmaxjoueurparteam}</td>
    <td align="center">
    {if $i.tournoi==1}
    	Oui
    {else}
    	Non
    {/if}
    </td>
    
    <!-- Affichage des flches pour la gestion de l'ordre -->
    <td align="center">
    	{if $smarty.foreach.foo.index+1 != 1}
    		<img src="{$base_url}/images/admin/arrow_green_up.png" alt="Monter l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;" title="Monter" onclick="javascript:changerordre(this,'up',{$i.idLanJeux},{$i.idLan},'{$base_url}/lanjeux/changementordre')" />
        {else}
        	<img src="{$base_url}/images/admin/arrow_green_up.png" alt="Monter l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Monter" onclick="javascript:changerordre(this,'up',{$i.idLanJeux},{$i.idLan},'{$base_url}/lanjeux/changementordre')" />
    	{/if}
    </td>
    <td align="center">
    	{if $smarty.foreach.foo.index+1 != $smarty.foreach.foo.last}
        	<img src="{$base_url}/images/admin/arrow_red_down.png" alt="Descendre l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;" title="Descendre" onclick="javascript:changerordre(this,'down',{$i.idLanJeux},{$i.idLan},'{$base_url}/lanjeux/changementordre')" />
        {else}
       		<img src="{$base_url}/images/admin/arrow_red_down.png" alt="Descendre l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Descendre" onclick="javascript:changerordre(this,'down',{$i.idLanJeux},{$i.idLan},'{$base_url}/lanjeux/changementordre')" />
    	{/if}
    </td>
    <td></td>
    <td align="center"><a href="{$urlupd}{$i.idLanJeux}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idLanJeux}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>
</div>