<h2> {$titre} </h2>


{foreach from=$chartes item=charte name=charte}
	<a href="{$ancrage}charte_{$charte.idCharte}" class="deco"><div class="titre"><div class="titre2"><img src="{$base_url}/images/logo_horde.png" class="flecheh" alt="fleche" align="absmiddle" />{$charte.nom|capitalize}</div></div></a>
    
    <div class="description2">
    	{foreach from=$articles[$charte.idCharte] name=article item=article}
   			<div style="margin-left:50px;"><a href="{$ancrage}article_{$article.idCharteArticle}" class="deco">Article {$smarty.foreach.article.index+1} : {$article.titre}</a></div>
    	{/foreach}
    </div>
{/foreach}

<br/><br/>

{foreach from=$chartes item=charte name=charte}
	<div id="charte_{$charte.idCharte}"><img src="img/fleche.gif" class="flecheh" alt="fleche" />{$charte.nom|capitalize}</div>
    
    <div class="description2">
    	{foreach from=$articles[$charte.idCharte] name=article item=article}
   			<div id="article_{$article.idCharteArticle}"> <strong>Article {$smarty.foreach.article.index+1} : {$article.titre}</strong> <br/>
            {$article.description|nl2br}</div>
    	{/foreach}
    </div>
    
    <br/><br/>
{/foreach}

