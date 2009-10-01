<h2> {$titre} </h2>

{foreach from=$articles item=art name=art}

	<h3>{$smarty.foreach.art.index+1} - {$art.titre}</h3>
    
    {$art.description|nl2br}
    
    <br/>

{/foreach}


<a href="{$url_valide}"> J'accepte </a> <br/>
<a href="{$url_nonvalide}"> Je refuse </a>