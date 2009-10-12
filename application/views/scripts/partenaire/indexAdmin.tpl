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
</script>
{/literal}

<h2>{$title|utf8_encode}</h2>

<a href="{$urladd}"><img src="{$baseurl}/images/admin/add.png" alt="Ajouter une news" class="textalignm" title="Ajouter" /> Ajouter {$title|utf8_encode}</a>
<br /><br />
<div id="tab_content">
<table align="center" id="tab_record">
  <tr>
  	<th></th>
    <th align="left" width="250">Titre</th>
    <th width="120" align="left">Type</th>
    <th align="left">Lien</th>
    <th width="70" align="center">Image</th>
    <th align="center" width="60" colspan="2">Ordre</th>
    <th width="70" align="center">Modifier</th>
    <th align="center">Supprimer</th>
    <th></th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.titre|utf8_encode}</td>
    <td>{$i.type|utf8_encode}</td>
    <td><a href="http://{$i.lien}" target="_blank">{$i.lien}</a></td>
    <td align="center"><a href="{$urlphoto}{$i.img}" target="_blank">ici</a></td>
        <td align="center">
    	{if $smarty.foreach.foo.index+1 != 1}
    		<img src="{$baseurl}/images/admin/arrow_green_up.png" alt="Monter l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;" title="Monter" onclick="javascript:changerordre(this,'up')" />
        {else}
        	<img src="{$baseurl}/images/admin/arrow_green_up.png" alt="Monter l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Monter" onclick="javascript:changerordre(this,'up')" />        
    	{/if}
    </td>
    <td align="center">
    	{if $smarty.foreach.foo.index+1 != $smarty.foreach.foo.last}
        	<img src="{$baseurl}/images/admin/arrow_red_down.png" alt="Descendre l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;" title="Descendre" onclick="javascript:changerordre(this,'down')" />
        {else}
       		<img src="{$baseurl}/images/admin/arrow_red_down.png" alt="Descendre l'article" name="{$i.ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Descendre" onclick="javascript:changerordre(this,'down')" />
    	{/if}
    </td>
    <td align="center"><a href="{$urlupd}{$i.idPartenaire}"><img src="{$baseurl}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idPartenaire}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$baseurl}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>
</div>