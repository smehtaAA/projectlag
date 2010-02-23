<h2>{$titre|utf8_encode}</h2>

<a href="{$urladd}"><img src="{$base_url}/images/admin/add.png" alt="Ajouter un album photos" class="textalignm" title="Ajouter" /> Ajouter un album photos</a>
<br /><br />
<div id="tab_content">
<table align="center" id="tab_record">
  <tr height="30">
    <th align="center" width="100" colspan="2">Date</th>
    <th align="left" width="350">Titre</th>
    <th align="center" width="200" colspan="2">Dossier</th>
    <th width="70" align="center">Modifier</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr id="ligne_{$i.ordre}">
    <td>{$i.date}</td>
    <td>{$i.titre|utf8_encode}</td>
    <td>{$i.dossier}</td>
    <td align="center"><a href="{$urlupd}{$i.idMultimedia}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idMultimedia}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>
</div>