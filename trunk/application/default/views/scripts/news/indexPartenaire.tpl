<div id="content-total">
{foreach from=$datas item=new name=new}
    <div class="content-princ content-separator">
    	<div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$new.titre}</h3><div class="right italic">{$new.date|date_format:"%A %e %B %Y"|capitalize}</div></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            	{if $new.img}
                	<img src="{$base_url}/images/news/{$new.img}" align="right" class="img-right-separator" style="float:right;" alt="{$new.titre|utf8_encode}" tittle="{$new.titre|utf8_encode}" width="20%" />
                {/if}
                {$new.description|nl2br|truncate:400:'..'} <br/>
                <br/><br/>
                <a href="{$base_url}/news/index?id={$new.idNews}">Lire la suite ...</a>
                <hr />
                <span class="tag">Tag : {$new.type_n|utf8_encode}</span>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
{/foreach}

<div class="content-princ content-separator">
	<center>
        Pages - 
        {foreach from=$pages item=page name=paget}
           [<a href='{$url}{$page}'>{$page}</a>] 
        {/foreach}
    </center>
</div>

</div>