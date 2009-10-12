{literal}
<script type="text/javascript">
	function changerordre(obj, changement,url) {		
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

<h2> {$titre|utf8_encode} </h2>

<br />

<a href="{$urladdstaff}"> Ajouter un nouveau staff </a>

<br/>
<br/>
<div id="tab_content">
<table align="center" id="tab_record">
	<th></th>
	<th width="200px"></th>
	<th width="450px" colspan="2"></th>
	<th></th>
	<th></th>
	<th width="30px"></th>
	<th>Modifier</th>
	<th>Supprimer</th>

{foreach from=$staff item=s name=s}

	<tr> 
    	<td>{$smarty.foreach.s.index+1}</td>
    	<td><h3> {$s.nom|utf8_encode} </h3></td>
        <td colspan="2">   
    		{if $nb[$s.idStaff] == 0 || ($nb[$s.idStaff] != 0 && $s.unik!=true)}<a href="{$urllinkcompte}{$s.idStaff}"> Lier un compte </a>{/if}
        </td>
        <td align="center">
            {if $smarty.foreach.s.index+1 != 1}
                <img src="{$base_url}/images/admin/arrow_green_up.png" alt="Monter le staff" name="{$s.ordre}" class="textalignm" style="cursor:pointer;" title="Monter" onclick="javascript:changerordre(this,'up','{$base_url}/staff/changementordre')" />
            {else}
                <img src="{$base_url}/images/admin/arrow_green_up.png" alt="Monter le staff" name="{$s.ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Monter" onclick="javascript:changerordre(this,'up','{$base_url}/staff/changementordre')" />        
            {/if}
        </td>
        <td align="center">
            {if $smarty.foreach.s.index+1 != $smarty.foreach.s.last}
                <img src="{$base_url}/images/admin/arrow_red_down.png" alt="Descendre le staff" name="{$s.ordre}" class="textalignm" style="cursor:pointer;" title="Descendre" onclick="javascript:changerordre(this,'down','{$base_url}/staff/changementordre')" />
            {else}
                <img src="{$base_url}/images/admin/arrow_red_down.png" alt="Descendre le staff" name="{$s.ordre}" class="textalignm" style="cursor:pointer;display:none;" title="Descendre" onclick="javascript:changerordre(this,'down', '{$base_url}/staff/changementordre')" />
            {/if}
        </td>
        <td></td>
        <td align="center"><a href="{$urlupdstaff}{$s.idStaff}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
        <td align="center"><a href="{$urldelstaff}{$s.idStaff}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.s.index+1} ?'));"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
    
    </tr>
            
    
    {foreach from=$comptes[$s.idStaff] item=c name=compte}
    	<tr>
        	<td>{$smarty.foreach.s.index+1}.{$smarty.foreach.compte.index+1}</td>
        	<td colspan="2" align="center">{$c.nom} - {$c.prenom}</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td align="center"><a href="{$urldelstaffcompte}{$c.idStaffCompte}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.s.index+1}.{$smarty.foreach.compte.index+1} ?'));"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
        </tr>
    {/foreach}


{/foreach}
</table>
</div>