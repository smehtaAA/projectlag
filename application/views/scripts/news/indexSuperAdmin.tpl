<h2>{$title}</h2>

<a href="{$urladd}"><img src="{$baseurl}/images/admin/add.png" alt="Ajouter une news" class="textalignm" title="Ajouter" /> Ajouter une {$title|strtolower}</a>
<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="250">Titre</th>
    <th align="left" width="150">Type</th>
    <th align="center">Image</th>
    <th width="70" align="center">Modifier</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.titre}</td>
    <td>{$i.type_n}</td>
    <td align="center"><a href="{$urlphoto}{$i.img}" target="_blank">ici</a></td>
    <td align="center"><a href="{$urlupd}{$i.idNews}"><img src="{$baseurl}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idNews}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$baseurl}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>