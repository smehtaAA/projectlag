<h2>{$title}</h2>

<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="100">Date</th>
    <th align="left" width="200">Type</th>
    <th align="left" width="250">Sujet</th>
    <th align="left">Email</th>
    <th width="70" align="center">Lire</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.date|date_format:"%d-%m-%Y"}</td>
    <td>{$i.type}</td>
    <td>{$i.titre|utf8_encode}</td>
    <td>{$i.mail}</td>
    <td align="center"><a href="{$urlview}{$i.idContact}"><img src="{$baseurl}/images/admin/read.png" alt="Lire" class="textalignm" title="Lire" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idContact}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$baseurl}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>