<h2> {$title|utf8_encode} </h2>


<br/> <br/>

<a href="{$urladd}"><img src="{$base_url}/images/admin/add.png" alt="Rattacher un mail" class="textalignm" /> Rattacher un mail</a>
<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="250">Email</th>
    <!--<th width="70" align="center">Voir</th>
    <th width="70" align="center">Modifier</th>-->
    <th width="70" align="center">Supprimer</th>
  </tr>
{foreach from=$datas key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td>{$i.mail}</td>
   <!-- <td align="center"><a href="{$urlvoir}{$i.idNewsletterMail}"><img src="{$base_url}/images/admin/read.png" alt="Voir" class="textalignm" title="Voir" /></a></td>
    <td align="center"><a href="{$urlupd}{$i.idNewsletterType}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>-->
    <td align="center"><a href="{$urldel}{$i.idNewsletterMailType}&idt={$i.idNewsletterType}"><img src="{$base_url}/images/admin/delete.png" alt="Supprimer" class="textalignm" title="Supprimer" /></a></td>
  </tr>
{/foreach}
</table>