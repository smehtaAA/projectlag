<h2> {$titre} </h2>

<table align="center">
	<tr>
    	<th align="left" width="300">Nom</th>
        <th align="center">Valeur</th>
        <th align="center" width="80">Modifier</th>
   	</tr>
{foreach from=$datas item=config name=config}
	<tr>
    	<td align="left">{$config.titre|utf8_encode} </td>
        <td align="right">{$config.valeur} </td>
        <td align="center"> <a href="{$base_url}/config/form/?id={$config.idConfig}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a> </td>
   	</tr>
{/foreach}
</table>