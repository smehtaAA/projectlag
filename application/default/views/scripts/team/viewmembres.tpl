<h2>{$title|utf8_encode}</h2>

<br /><br />
<table align="center">
  <tr>
  	<th></th>
    <th align="left" width="250">Nom</th>
  </tr>
{foreach from=$membres key=myId item=i name=foo}
  <tr>
  	<td>{$smarty.foreach.foo.index+1} - </td>
    <td><a href="{$urlfiche}{$i.idCompte}">{$i.login}</a></td>
  </tr>
{/foreach}
</table>