<h2><img src="{$base_url}/images/admin/bug.png" align="absmiddle" alt="Bug" title="Bug" /> {$titre} </h2>

<table align="center">
  <tr height="30">
  	<th></th>
    <th align="left" width="120">Date Bug
    	<a href="{$urltri}table=bug&sort=datebug"><img src="{$base_url}/images/admin/arrow_sort_down.png" alt="Croissant" class="textalignm" title="Croissant" /></a><a href="{$urltri}table=bug&sort=datebug&ordre=DESC"><img src="{$base_url}/images/admin/arrow_sort_up.png" alt="Croissant" class="textalignm" title="Croissant" /></a>
    </th>
    <th align="left" width="120">Priorit&eacute;
    	<a href="{$urltri}table=bug&sort=priorite"><img src="{$base_url}/images/admin/arrow_sort_down.png" alt="Croissant" class="textalignm" title="Croissant" /></a><a href="{$urltri}table=bug&sort=priorite&ordre=DESC"><img src="{$base_url}/images/admin/arrow_sort_up.png" alt="Croissant" class="textalignm" title="Croissant" /></a>
    </th>
    <th align="left" width="220">Titre
    	<a href="{$urltri}table=bug&sort=titre"><img src="{$base_url}/images/admin/arrow_sort_down.png" alt="Croissant" class="textalignm" title="Croissant" /></a><a href="{$urltri}table=bug&sort=titre&ordre=DESC"><img src="{$base_url}/images/admin/arrow_sort_up.png" alt="Croissant" class="textalignm" title="Croissant" /></a>
    </th>
    <th align="left" width="120">Statut
    	<a href="{$urltri}table=bug&sort=statut"><img src="{$base_url}/images/admin/arrow_sort_down.png" alt="Croissant" class="textalignm" title="Croissant" /></a><a href="{$urltri}table=bug&sort=statut&ordre=DESC"><img src="{$base_url}/images/admin/arrow_sort_up.png" alt="Croissant" class="textalignm" title="Croissant" /></a>
    </th>
    <th width="70"></th>
    <th width="70" align="center">Consulter</th>
    <th width="70" align="center">Modifier</th>
  </tr>

{foreach from=$bugs item=bug name=bug}

  <tr>
  	<td>{$smarty.foreach.bug.index+1} - </td>
    <td>{$bug.datebug|date_format:'%d/%m/%Y'}</td>
    <td>{$priorite[$bug.priorite]}</td>
    <td>{$bug.titre}</td>
    <td>{$bug.statut}</td>

    <td></td>
    <td align="center"><a href="{$urlview}{$bug.idBug}"><img src="{$base_url}/images/admin/read.png" alt="Consulter" class="textalignm" title="Consulter" /></a></td>
    <td align="center"><a href="{$urlupd}{$bug.idBug}"><img src="{$base_url}/images/admin/modify.png" alt="Modifier" class="textalignm" title="Modifier" /></a></td>

  </tr>

{/foreach}
</table>

<br/><br/><br/>
<h2><img src="{$base_url}/images/admin/valid.png" align="absmiddle" alt="DeBug" title="DeBug" /> DeBug</h2>


<table align="center">
  <tr height="30">
  	<th></th>
    <th align="left" width="120">Date Bug
    	<a href="{$urltri}table=debug&sort=datebug"><img src="{$base_url}/images/admin/arrow_sort_down.png" alt="Croissant" class="textalignm" title="Croissant" /></a><a href="{$urltri}table=debug&sort=datebug&ordre=DESC"><img src="{$base_url}/images/admin/arrow_sort_up.png" alt="Croissant" class="textalignm" title="Croissant" /></a>
    </th>
    <th align="left" width="120">Date DeBug
    	<a href="{$urltri}table=debug&sort=datedebug"><img src="{$base_url}/images/admin/arrow_sort_down.png" alt="Croissant" class="textalignm" title="Croissant" /></a><a href="{$urltri}table=debug&sort=datedebug&ordre=DESC"><img src="{$base_url}/images/admin/arrow_sort_up.png" alt="Croissant" class="textalignm" title="Croissant" /></a>
    </th>
    <th align="left" width="120">Priorit&eacute;
    	<a href="{$urltri}table=debug&sort=priorite"><img src="{$base_url}/images/admin/arrow_sort_down.png" alt="Croissant" class="textalignm" title="Croissant" /></a><a href="{$urltri}table=debug&sort=priorite&ordre=DESC"><img src="{$base_url}/images/admin/arrow_sort_up.png" alt="Croissant" class="textalignm" title="Croissant" /></a>
    </th>
    <th align="left" width="220">Titre
    	<a href="{$urltri}table=debug&sort=titre"><img src="{$base_url}/images/admin/arrow_sort_down.png" alt="Croissant" class="textalignm" title="Croissant" /></a><a href="{$urltri}table=debug&sort=titre&ordre=DESC"><img src="{$base_url}/images/admin/arrow_sort_up.png" alt="Croissant" class="textalignm" title="Croissant" /></a>
    </th>
    <th align="left" width="120">Statut
    	<a href="{$urltri}table=debug&sort=statut&ordre=DESC"><img src="{$base_url}/images/admin/arrow_sort_down.png" alt="Croissant" class="textalignm" title="Croissant" /></a><a href="{$urltri}table=debug&sort=statut&ordre=DESC"><img src="{$base_url}/images/admin/arrow_sort_up.png" alt="Croissant" class="textalignm" title="Croissant" /></a>
    </th>
    <th width="70"></th>
    <th width="70" align="center">Consulter</th>
  </tr>

{foreach from=$bugs_corrige item=bug_corrige name=bug_corrige}

  <tr>
  	<td>{$smarty.foreach.bug_corrige.index+1} - </td>
    <td>{$bug_corrige.datebug|date_format:'%d/%m/%Y'}</td>
    <td>{$bug_corrige.datedebug|date_format:'%d/%m/%Y'}</td>
    <td>{$priorite[$bug_corrige.priorite]}</td>
    <td>{$bug_corrige.titre}</td>
    <td>{$bug_corrige.statut}</td>

    <td></td>
    <td align="center"><a href="{$urlview}{$bug_corrige.idBug}"><img src="{$base_url}/images/admin/read.png" alt="Consulter" class="textalignm" title="Consulter" /></a></td>

  </tr>

{/foreach}
</table>