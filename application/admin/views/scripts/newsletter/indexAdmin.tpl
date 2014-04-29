<h2>{$title|utf8_encode}</h2>

<a href="{$urladd}"><img src="{$baseurl}/images/admin/send.png" alt="Ajouter une newsletter" class="textalignm" /> Envoyer une {$title|strtolower|utf8_encode}</a>
<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="600">Titre</th>
    <th align="center">Image</th>
    <th width="70" align="center">Lire</th>
    
    {if $superadmin==1}
        <th width="70" align="center">Renvoyer</th>
        <th align="center"> Supprimer </th>
    {/if}
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.titre|utf8_encode}</td>
    <td align="center"><a href="{$urlphoto}{$i.img}" target="_blank">ici</a></td>
    <td align="center"><a href="{$urlview}{$i.idNewsletter}"><img src="{$baseurl}/images/admin/read.png" alt="Lire" class="textalignm" title="Lire" /></a></td>
    {if $superadmin==1}
        <td align="center"><a href="{$urlsend}{$i.idNewsletter}" onclick="return(confirm('Etes-vous sur de vouloir renvoyer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$baseurl}/images/admin/send.png" alt="Envoyer" class="textalignm" title="Envoyer" /></a></td>

        <td align="center"><a href="{$urldel}{$i.idNewsletter}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$baseurl}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>

    {/if}
  </tr>
{/foreach}
</table>