<h2> Liste des Partenaires </h2>

{foreach from=$types item=type name=type}

	<a href="{$base_url}/partenaire/?type={$type.type}"> {$type.type} </a><br/>

{/foreach}

<br/> <br/>

{if $partenaires != null}


<table>
<tr>
	<th> Logo </th>
    <th> Nom </th>
    <th> Description </th>
    <th> Lien </th>
</tr>
{foreach from=$partenaires item=partenaire name=partenaire}

	<tr>
    <td> <img src="{$base_url}/images/partenaires/{$partenaire.logo}"  /></td>
    <td> {$partenaire.titre|capitalize} </td>
    <td> {$partenaire.description} </td>
    <td> <a href="http://{$partenaire.lien}"> {$partenaire.lien} </a> </td>
    </tr>

{/foreach}
</table>
{/if}