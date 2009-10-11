<div id="content-total">
	<div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$news.titre}</h3><div class="right italic">{$news.date|date_format:"%A %e %B %Y"|capitalize}</div></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                {if $news.img}
                	<img src="{$base_url}/images/news/{$news.img}" align="right" alt="{$news.titre}" tittle="{$news.titre}" />
                {/if}
                {$news.description|nl2br} <br/>
                
                <a href="{$news.lien}">Voir la source</a>
                <hr />
                <span class="tag">Tag : {$news.type_n}</span>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>



