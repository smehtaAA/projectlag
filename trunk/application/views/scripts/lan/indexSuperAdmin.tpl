<h2>{$title}</h2>

<a href="{$urladd}"><img src="{$baseurl}/images/admin/add.png" alt="Ajouter une lan" class="textalignm" title="Ajouter" /> Ajouter une {$title|strtolower}</a>
<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="250">Nom</th>
    <th align="left" width="150">Date D&eacute;but</th>
    <th align="left" width="150">Date Fin</th>
    <th width="70" align="center">Modifier</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.nom}</td>
    <td>{$i.datedeb|date_format:"%d/%m/%Y"}</td>
    <td>{$i.datefin|date_format:"%d/%m/%Y"}</td>
    <td align="center"><a href="{$urlupd}{$i.idLan}"><img src="{$baseurl}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idLan}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$baseurl}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>