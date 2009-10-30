<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Type de partenaire</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <ul>
                    <li><a href="{$base_url}/partenaire/">Tous</a></li>
                    {foreach from=$types item=type name=type}
                    <li><a href="{$base_url}/partenaire/?type={$type.type}">{$type.type|utf8_encode}</a></li>
                    {/foreach}
                </ul>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    
    {if $partenaires != null}
    
        {foreach from=$partenaires item=partenaire name=partenaire}
            <div class="content-total-princ content-separator">
                <div class="content-total-top"></div>
                <div class="content-total-middle">
                    <div class="content-title-left"></div>
                    <div class="content-title-middle content-title-middle-total"><h3>{$partenaire.titre|capitalize|utf8_encode}</h3></div>
                    <div class="content-title-right"></div>
                    <div class="content-total-text">
                        <a href="{$partenaire.lien}"><img src="{$base_url}/images/partenaires/{$partenaire.logo}" align="right" style="float:right;" alt="{$partenaire.titre|capitalize|utf8_encode}" title="{$partenaire.titre|capitalize|utf8_encode}" /></a>
                        {$partenaire.description|nl2br|utf8_encode}<br />
                        <a href="{$partenaire.lien}"><strong>Voir le site</strong></a>
                    </div>
                </div>
                <div class="content-total-bottom"></div>
            </div>
        {/foreach}
    
    {/if}
</div>