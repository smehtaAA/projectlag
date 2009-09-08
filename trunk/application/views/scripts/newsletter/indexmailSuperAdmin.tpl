<h2>{$title}</h2>

<a href="{$urladd}"><img src="{$base_url}/images/admin/add.png" alt="Ajouter un mail" class="textalignm" /> Ajouter un mail</a>
<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="250">Mail</th>
    <th align="center"></th>
    <th width="70" align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.mail}</td>
    <td align="center"></td>
    <td align="center"><a href="{$urldel}{$i.idNewsletterMail}"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>