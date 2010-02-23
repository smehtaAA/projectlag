<h2><img src="{$base_url}/images/admin/bug.png" align="absmiddle" alt="Bug" title="Bug" /> {$titre} </h2>
<br />
<a href="{$base_url}/bug/indexadmin/">Retour &agrave; la liste des bugs</a>
<br /><br />
<table border="0" width="900px">
	<tr>
    	<td width="150px"><b>Date du Bug</b></td>
        <td> : </td>
        <td>{$bug.datebug|date_format:'%d/%m/%Y'}</td>
    </tr>
    <tr>
    	<td width="150px"><b>Priorit&eacute;</b></td>
        <td> : </td>
        <td>{$priorite[$bug.priorite]}</td>
    </tr>
    <tr>
    	<td width="150px"><b>Titre</b></td>
        <td> : </td>
        <td>{$bug.titre}</td>
    </tr>
    <tr>
    	<td width="150px"><b>Statut</b></td>
        <td> : </td>
        <td>{$bug.statut}</td>
    </tr>
    <tr>
    	<td colspan="3" height="20"></td>
    </tr>
    <tr>
    	<td width="150px"><b>Cat&eacute;gorie</b></td>
        <td> : </td>
        <td>{$bug.categorie}</td>
    </tr>
    <tr>
    	<td width="150px"><b>Navigateur</b></td>
        <td> : </td>
        <td>{$bug.navigateur}</td>
    </tr>
    <tr>
    	<td colspan="3" height="20"></td>
    </tr>
    <tr>
    	<td width="150px"><b>Description</b></td>
        <td> : </td>
        <td>{$bug.description}</td>
    </tr>
</table>
<br/><br/>

{if $corrige==true}

<h2><img src="{$base_url}/images/admin/valid.png" align="absmiddle" alt="Debug" title="Debug" /> Debug </h2><br/>
<table border="0">
	<tr>
    	<td width="150px"><b>Date du Debug</b></td>
        <td width="20px"> : </td>
        <td width="50px">{$bug.datedebug|date_format:'%d/%m/%Y'}</td>
    </tr>
    <tr>
    	<td width="150px"><b>Note du Debugger</b></td>
        <td width="20px"> : </td>
        <td width="70px">{$bug.noteDebugger}</td>
    </tr>
</table>


{/if}