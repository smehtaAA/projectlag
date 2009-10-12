<h2>{$title|utf8_encode}</h2>

<a href="{$urladd}"><img src="{$baseurl}/images/admin/send.png" alt="Ajouter une newsletter" class="textalignm" /> Envoyer une {$title|strtolower|utf8_encode}</a>
<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="250">Titre</th>
    <th align="center">Image</th>
    <th width="70" align="center">Lire</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.titre|utf8_encode}</td>
    <td align="center"><a href="{$urlphoto}{$i.img}" target="_blank">ici</a></td>
    <td align="center"><a href="{$urlupd}{$i.idNewsletter}"><img src="{$baseurl}/images/admin/read.png" alt="Lire" class="textalignm" title="Lire" /></a></td>
  </tr>
{/foreach}
</table>