{literal}
<script type="text/javascript">
	function changerordre(obj, changement, url) {		
		$.ajax({
			type     : "POST",
			url      : url,
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
</script>
{/literal}

<h2>{$titre}</h2>

<a href="{$urladd}"><img src="{$base_url}/images/admin/add.png" alt="Ajouter un Article" class="textalignm" title="Ajouter" /> Ajouter un Article</a>
<br /><br />
<div id="tab_content">
<table align="center" id="tab_record">
  <tr height="30">
    <th align="left" width="350">Titre</th>
    <th align="center" width="60" colspan="2">Ordre</th>
    <th width="70"> </th>
    <th width="70" align="center">Modifier</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr id="ligne_{$i.ordre}">
    <td>{$i.titre}</td>
    <td align="center">
    	{if $smarty.foreach.foo.index+1 != 1}
    		<img src="{$base_url}/images/admin/arrow_green_up.png" alt="Monter l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;" title="Monter" onclick="javascript:changerordre(this,'up','{$base_url}/chartearticle/changementordre')" />
        {else}
        	<img src="{$base_url}/images/admin/arrow_green_up.png" alt="Monter l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Monter" onclick="javascript:changerordre(this,'up','{$base_url}/chartearticle/changementordre')" />        
    	{/if}
    </td>
    <td align="center">
    	{if $smarty.foreach.foo.index+1 != $smarty.foreach.foo.last}
        	<img src="{$base_url}/images/admin/arrow_red_down.png" alt="Descendre l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;" title="Descendre" onclick="javascript:changerordre(this,'down','{$base_url}/chartearticle/changementordre')" />
        {else}
       		<img src="{$base_url}/images/admin/arrow_red_down.png" alt="Descendre l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Descendre" onclick="javascript:changerordre(this,'down', '{$base_url}/chartearticle/changementordre')" />
    	{/if}
    </td>
    <td></td>
    <td align="center"><a href="{$urlupd}{$i.idCharteArticle}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idCharteArticle}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>
</div>