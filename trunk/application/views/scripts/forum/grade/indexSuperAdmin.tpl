<h2>{$titre}</h2>

<a href="{$urladd}"><img src="{$base_url}/images/admin/add.png" alt="Ajouter un grade" class="textalignm" title="Ajouter" /> Ajouter un Grade</a>
<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="250">Titre</th>
    <th align="left">Nb Messages</th>
    <th width="70" align="center"></th>
    <th width="70" align="center">Modifier</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.nom}</td>
    <td align="center">{$i.nbmessages}</td>
    <td></td>
    <td align="center"><a href="{$urlupd}{$i.idGrade}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idGrade}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>