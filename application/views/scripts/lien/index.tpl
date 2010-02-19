<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Liens</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <ul>
                     {foreach from=$datas item=lien name=lien}
                         <li><strong>{$smarty.foreach.lien.index+1} - {$lien.titre}</strong> <br/>
                                <a href="http://{$lien.lien}">{$lien.lien}</a>
                         </li>
                     {/foreach}
                </ul>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>