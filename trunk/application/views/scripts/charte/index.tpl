<div class="content-princ">
    <div class="content-left-top"></div>
    <div class="content-left-middle">
        <div class="content-title-left"></div>
        <div class="content-title-middle content-title-middle-left"><h3>{$titre}</h3></div>
        <div class="content-title-right"></div>
        <div class="content-left-text">
        	<ul>
            {foreach from=$chartes item=charte name=charte}
                <li><a href="#charte_{$charte.idCharte}" class="deco"><strong>{$charte.nom|capitalize}</strong></a>
                    <ul>
                    {foreach from=$articles[$charte.idCharte] name=article item=article}
                        <li><a href="#article_{$article.idCharteArticle}" class="deco">Article {$smarty.foreach.article.index+1} : {$article.titre}</a></li>
                    {/foreach}
                    </ul>
                </li>
            {/foreach}
        	</ul>
        </div>
    </div>
    <div class="content-left-bottom"></div>
</div>

<br/><br/>

{foreach from=$chartes item=charte name=charte}
<div class="content-princ content-separator" id="charte_{$charte.idCharte}">
    <div class="content-left-top"></div>
    <div class="content-left-middle">
        <div class="content-title-left"></div>
        <div class="content-title-middle content-title-middle-left"><h3>{$charte.nom|capitalize}</h3></div>
        <div class="content-title-right"></div>
        <div class="content-left-text">    
            {foreach from=$articles[$charte.idCharte] name=article item=article}
                <div id="article_{$article.idCharteArticle}"> 
                	<strong>Article {$smarty.foreach.article.index+1} : {$article.titre}</strong><br /><br />
                	{$article.description|nl2br}
                </div>
                <br /><br />
            {/foreach}
        </div>
    </div>
    <div class="content-left-bottom"></div>
</div>
{/foreach}

