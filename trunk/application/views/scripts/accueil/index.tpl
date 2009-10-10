{if $lan != -1}
    <div class="content-princ">
    	<div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Info Prochaine Lan</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
                Nom : {$lan.nom}<br />
                Date de d&eacute;but : {$lan.datedeb|date_format:"%d/%m/%Y a %H:%M"}<br />
                Lieux : {$lan.adresse}<br />
                Nb. inscrits : {$nb_inscrits}
                <br /><br />
                <a href="{$base_url}/lan/">Plus d'information...</a>
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
{/if}

{foreach from=$news item=new name=new}
    <div class="content-princ">
    	<div class="content-left-top"></div>
        <div class="content-left-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-left"><h3>{$new.titre}</h3><div class="right italic">{$new.date|date_format:"%A %e %B %Y"|capitalize}</div></div>
            <div class="content-title-right"></div>
            <div class="content-left-text">
                <img src="{$base_url}/images/news/{$new.img}" align="right" alt="{$new.titre}" tittle="{$new.titre}" />
                {$new.description|nl2br}
                <hr />
                <span class="tag">Tag : {$new.type_n}</span>
            </div>
        </div>
        <div class="content-left-bottom"></div>
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