<h2> {$title|utf8_encode} </h2>


<br/> <br/>

<a href="{$urladd}"><img src="{$base_url}/images/admin/add.png" alt="Ajouter un type" class="textalignm" /> Ajouter un type</a>
<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="250">Nom</th>
    <th align="center"> Nombre </th>
    <th width="70" align="center">Voir</th>
    <th width="70" align="center">Modifier</th>
    <th width="70" align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.nom|utf8_encode}</td>
    <td> {$nb[$i.idNewsletterType]}</td>
    <td align="center"><a href="{$urlvoir}{$i.idNewsletterType}"><img src="{$base_url}/images/admin/read.png" alt="Voir" class="textalignm" title="Voir" /></a></td>
    <td align="center"><a href="{$urlupd}{$i.idNewsletterType}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center">
    	{if $i.idNewsletterType>3}
        	<a href="{$urldel}{$i.idNewsletterType}"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a>
        {/if}    
    </td>
  </tr>
{/foreach}
</table>