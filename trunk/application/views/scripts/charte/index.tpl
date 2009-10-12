<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$titre|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-left-text">
                <ul>
                {foreach from=$chartes item=charte name=charte}
                    <li><a href="#charte_{$charte.idCharte}" class="deco"><strong>{$charte.nom|capitalize|utf8_encode}</strong></a>
                        <ul>
                        {foreach from=$articles[$charte.idCharte] name=article item=article}
                            <li><a href="#article_{$article.idCharteArticle}" class="deco">Article {$smarty.foreach.article.index+1} : {$article.titre|utf8_encode}</a></li>
                        {/foreach}
                        </ul>
                    </li>
                {/foreach}
                </ul>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    
    {foreach from=$chartes item=charte name=charte}
    <div class="content-total-princ content-separator" id="charte_{$charte.idCharte}">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$charte.nom|capitalize|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">    
                {foreach from=$articles[$charte.idCharte] name=article item=article}
                    <div id="article_{$article.idCharteArticle}"> 
                        <strong>Article {$smarty.foreach.article.index+1} : {$article.titre|utf8_encode}</strong><br /><br />
                        {$article.description|nl2br|utf8_encode}
                    </div>
                    <br /><br />
                {/foreach}
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    {/foreach}
</div>