{literal}
<script type="text/javascript">
	function changerordre(obj, changement) {		
		$.ajax({
			type     : "POST",
			url      : "changementordre",
			async    : true,
			data     : "ordre="+obj.name+"&change="+changement,
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
	
	function changerordreSousCat(obj, changement, idCat) {		
		$.ajax({
			type     : "POST",
			url      : "changementordreSousCat",
			async    : true,
			data     : "ordre="+obj.name+"&change="+changement+"&idCat="+idCat,
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

<a href="{$urladd}"><img src="{$base_url}/images/admin/add.png" alt="Ajouter une Categorie" class="textalignm" title="Ajouter" /> Ajouter une Categorie</a>
<br /><br />
<div id="tab_content">
<table align="center" id="tab_record">
  <tr>
  	<th></th>
    <th align="left" width="250">Titre</th>
    <th align="left" width="150">Visible</th>
    <th align="center" width="60" colspan="2">Ordre</th>
    <th width="70"> </th>
    <th width="70" align="center">Sous Categorie</th>
    <th width="70" align="center">Modifier</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=cat name=categorie}
  <tr>
  	<td>{$smarty.foreach.categorie.index+1} - </td>
    <td>{$cat.titre}</td>
    <td>{$cat.visible}</td>
    <td align="center">
    	{if $smarty.foreach.categorie.index+1 != 1}
    		<img src="{$base_url}/images/admin/arrow_green_up.png" alt="Monter la categorie" name="{$cat.ordre}" class="textalignm" style="cursor:pointer;" title="Monter" onclick="javascript:changerordre(this,'up')" />
        {else}
        	<img src="{$base_url}/images/admin/arrow_green_up.png" alt="Monter la categorie" name="{$cat.ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Monter" onclick="javascript:changerordre(this,'up')" />        
    	{/if}
    </td>
    <td align="center">
    	{if $smarty.foreach.categorie.index+1 != $smarty.foreach.categorie.last}
        	<img src="{$base_url}/images/admin/arrow_red_down.png" alt="Descendre la categorie" name="{$cat.ordre}" class="textalignm" style="cursor:pointer;" title="Descendre" onclick="javascript:changerordre(this,'down')" />
        {else}
       		<img src="{$base_url}/images/admin/arrow_red_down.png" alt="Descendre la categorie" name="{$cat.ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Descendre" onclick="javascript:changerordre(this,'down')" />
    	{/if}
    </td>
    <td></td>
    <td align="center"><a href="{$urladdSousCat}{$cat.idCategorie}"><img src="{$base_url}/images/admin/add.png" alt="Ajouter une SousCategorie" class="textalignm" title="Ajouter" /></a></td>
    <td align="center"><a href="{$urlupd}{$cat.idCategorie}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$cat.idCategorie}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.categorie.index+1} ?'));"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
  
  {section name=souscategorie loop=$datasSousCategorie[$cat.idCategorie] step=1}
   <tr>
  	<td>{$smarty.foreach.categorie.index+1}.{$smarty.section.souscategorie.index+1} - </td>
  	<td align="center">{$datasSousCategorie[$cat.idCategorie][souscategorie].titre}</td>
    <td>{$datasSousCategorie[$cat.idCategorie][souscategorie].visible}</td>
    <td align="center">
    	{if $smarty.section.souscategorie.index+1 != 1}
    		<img src="{$base_url}/images/admin/arrow_green_up.png" alt="Monter la categorie" name="{$datasSousCategorie[$cat.idCategorie][souscategorie].ordre}" class="textalignm" style="cursor:pointer;" title="Monter" onclick="javascript:changerordreSousCat(this,'up',{$datasSousCategorie[$cat.idCategorie][souscategorie].idCategorie})" />
        {else}
        	<img src="{$base_url}/images/admin/arrow_green_up.png" alt="Monter la categorie" name="{$datasSousCategorie[$cat.idCategorie][souscategorie].ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Monter" onclick="javascript:changerordreSousCat(this,'up',{$datasSousCategorie[$cat.idCategorie][souscategorie].idCategorie})" />        
    	{/if}
    </td>
    <td align="center">
    	{if $smarty.section.souscategorie.index+1 != $smarty.section.souscategorie.last}
        	<img src="{$base_url}/images/admin/arrow_red_down.png" alt="Descendre la categorie" name="{$datasSousCategorie[$cat.idCategorie][souscategorie].ordre}" class="textalignm" style="cursor:pointer;" title="Descendre" onclick="javascript:changerordreSousCat(this,'down',{$datasSousCategorie[$cat.idCategorie][souscategorie].idCategorie})" />
        {else}
       		<img src="{$base_url}/images/admin/arrow_red_down.png" alt="Descendre la categorie" name="{$datasSousCategorie[$cat.idCategorie][souscategorie].ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Descendre" onclick="javascript:changerordreSousCat(this,'down',{$datasSousCategorie[$cat.idCategorie][souscategorie].idCategorie})" />
    	{/if}
    </td>
    <td></td>
    <td></td>
    <td align="center"><a href="{$urlupdSousCat}{$datasSousCategorie[$cat.idCategorie][souscategorie].idCategorie}&id={$datasSousCategorie[$cat.idCategorie][souscategorie].idSousCategorie}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="urlupdSousCat" /></a></td>
    <td align="center"><a href="{$urldelSousCat}{$datasSousCategorie[$cat.idCategorie][souscategorie].idSousCategorie}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.section.souscategorie.index+1} ?'));"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
  {/section}
  
{/foreach}
</table>
</div>