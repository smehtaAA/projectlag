<h2>{$title}</h2>

<a href="{$urladd}"><img src="{$baseurl}/images/admin/add.png" alt="Ajouter une lan" class="textalignm" title="Ajouter" /> Ajouter une {$title|strtolower}</a>
<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="150">Nom</th>
    <th align="left" width="150">Pr&eacute;nom</th>
    <th align="left" width="150">Mail</th>
    <th align="left" width="100">Date d'inscription</th>
    <th width="100"></th>
    <th width="70" align="center">Modifier</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.nom}</td>
    <td>{$i.prenom}</td>
    <td>{$i.email}</td>
    <td>{$i.dateins|date_format:"%d/%m/%Y"}</td>
    <td></td>
    <td align="center"><a href="{$urlupd}{$i.idLan}"><img src="{$baseurl}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idLan}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$baseurl}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>