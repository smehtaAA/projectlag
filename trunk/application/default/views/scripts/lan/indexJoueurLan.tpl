
<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$title|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            <br/>
               <span class="rouge"><strong>{$lan.nom|utf8_encode}</strong></span>

                
                {if $lan.datedeb > $smarty.now}
                <br/><br/>
                <a href="{$urladdjeu}"> S'inscrire &agrave; un nouveau jeu </a>
                {/if}
                <br/><br/>
                
                {if $jeux_libres != 0}
                    Vous avez choisi de jouer en <strong>Jeux libres</strong>. <br/>
                {/if}
                <br/>
                Voici la liste des jeux o&ugrave; vous vous &ecirc;tes inscrits :
                <ul>
                {foreach from=$jeux item=jeu name=jeu}
                
                    <li>{$jeu.nom|utf8_encode}</li>
                
				{/foreach}   
                </ul>
                <br/> <br/>
                <!--Venir &agrave; la lan-->
                <br/><br/>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    
    <div class="content-total-princ content-separator">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Itin&eacute;raire</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <div>
                {$map->getGoogleMap()}
               
                <div id="route" style="width:830px;"></div>
                </div>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>



