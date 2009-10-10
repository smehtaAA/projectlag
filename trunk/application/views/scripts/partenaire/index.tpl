
<div class="content-princ">
    <div class="content-left-top"></div>
    <div class="content-left-middle">
        <div class="content-title-left"></div>
        <div class="content-title-middle content-title-middle-left"><h3>Type de partenaire</h3></div>
        <div class="content-title-right"></div>
        <div class="content-left-text">
       		<ul>
            	<li><a href="{$base_url}/partenaire/">Tous</a></li>
            	{foreach from=$types item=type name=type}
            	<li><a href="{$base_url}/partenaire/?type={$type.type}">{$type.type}</a></li>
            	{/foreach}
            </ul>
        </div>
    </div>
    <div class="content-left-bottom"></div>
</div>

{if $partenaires != null}

    {foreach from=$partenaires item=partenaire name=partenaire}
        <div class="content-princ content-separator">
            <div class="content-left-top"></div>
            <div class="content-left-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-left"><h3>{$partenaire.titre|capitalize}</h3></div>
                <div class="content-title-right"></div>
                <div class="content-left-text">
                    <img src="{$base_url}/images/partenaires/{$partenaire.logo}" align="right" alt="{$partenaire.titre|capitalize}" title="{$partenaire.titre|capitalize}" />
                    {$partenaire.description|nl2br}<br />
                    <a href="http://{$partenaire.lien}"><strong>Voir le site</strong></a>
                </div>
            </div>
            <div class="content-left-bottom"></div>
        </div>
    {/foreach}

{/if}