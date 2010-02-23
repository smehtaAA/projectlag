<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$title|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-left-text">
            <ul>
                {foreach from=$lans item=lan name=lan}

	<li><a href="?id={$lan.idLan}"><span class="rouge"><strong>{$lan.nom|utf8_encode}</strong></span> </a><br/>
    <ul>
    D&eacute;but le {$lan.datedeb|date_format:"%d/%m/%Y"} <br/>
    Fin le : {$lan.datefin|date_format:"%d/%m/%Y"} <br/>
</ul></li>

{/foreach}
</ul>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>
