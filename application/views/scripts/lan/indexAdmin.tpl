<h2>{$title}</h2>

<a href="{$urladd}"><img src="{$baseurl}/images/admin/add.png" alt="Ajouter une lan" class="textalignm" title="Ajouter" /> Ajouter une {$title|strtolower}</a>
<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="250">Nom</th>
    <th align="left" width="150">Date D&eacute;but</th>
    <th width="70" align="center"> Inscription </th>
    <th width="30"></th>
    <th width="70" align="center"> Inscrits </th>
    <th width="70" align="center">Teams </th>
    <th width="70" align="center">Jeux </th>
    <th width="70" align="center">Modifier</th>
    <th align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.nom}</td>
    <td>{$i.datedeb|date_format:"%d/%m/%Y"}</td>
    {if $i.inscription == true}
    <td align="center">Oui</td>
    {else}
    <td align="center">Non</td>
    {/if}
    <td></td>
    <td align="center"><a href="{$urlinscrits}{$i.idLan}">{$chiffre[$i.idLan][0].insc}</a></td>
    <td align="center"><a href="{$urlteams}{$i.idLan}">{$chiffre[$i.idLan][0].teams}</a></td>
    <td align="center"><a href="{$urljeux}{$i.idLan}">{$chiffre[$i.idLan][0].jeux}</a></td>
    <td align="center"><a href="{$urlupd}{$i.idLan}"><img src="{$baseurl}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>
    <td align="center"><a href="{$urldel}{$i.idLan}" onclick="return(confirm('Etes-vous sur de vouloir supprimer la ligne {$smarty.foreach.foo.index+1} ?'));"><img src="{$baseurl}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>