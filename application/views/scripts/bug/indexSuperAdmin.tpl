<h2> {$titre} </h2>

<br/>
{if $mode=='consult'}
<a href="{$urlconsult}"> Consulter les bugs non corrig&eacute;s </a>
{else}
<a href="{$urlconsult}?mode=consult"> Consulter les bugs corrig&eacute;s </a>
{/if}
<br/><br/><br/>

<table align="center">
  <tr height="30">
  	<th></th>
    <th align="left" width="200">Titre</th>
    <th align="left" width="50">Date Bug</th>
    {if $mode=='consult'}
        <th align="left" width="50">Date Debug</th>
    {/if}
    <th align="left" width="100">Priorit&eacute;</th>
    <th align="left" width="100">Navigateur</th>
    <th align="left" width="100">Cat&eacute;gorie</th>
    {if $mode!='consult'}
    <th align="left" width="100">Statut</th>
    {/if}
    <th width="100">  </th>
    {if $mode=='consult'}
    	<th width="70" align="center">Consulter</th>
    {else}
    	<th width="70" align="center">R&eacute;soudre</th>
    {/if}
  </tr>

{foreach from=$datas item=bug name=bug}

  <tr>
  	<td>{$smarty.foreach.bug.index+1} - </td>
    <td>{$bug.titre}</td>
    <td>{$bug.datebug|date_format:'%d/%m/%Y'}</td>
    {if $mode=='consult'}
    	<td>{$bug.datedebug|date_format:'%d/%m/%Y'}</td>
    {/if}
    <td>{$priorite[$bug.priorite]}</td>
    <td>{$bug.navigateur}</td>
    <td>{$bug.categorie}</td>
    {if $mode!='consult'}
    	<td>{$bug.statut}</td>
    {/if}
    <td></td>
    
    <td align="center"><a href="{$urlupd}{$bug.idBug}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>

  </tr>

{/foreach}
</table>