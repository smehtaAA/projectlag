<div class="content-princ">
    <div class="content-left-top"></div>
    <div class="content-left-middle">
        <div class="content-title-left"></div>
        <div class="content-title-middle content-title-middle-left"><h3>{$titre}</h3></div>
        <div class="content-title-right"></div>
        <div class="content-left-text">
        	{if $ouverte==true}
                <div id="inscription-charte">
                    {foreach from=$articles item=art name=art}   
                        <h3>{$smarty.foreach.art.index+1} - {$art.titre}</h3>       
                        {$art.description|nl2br}      
                        <br/>  
                    {/foreach}
                    </div>
                        
                    <input name="action" value="J'accepte" onClick="location='{$url_valide}'" type="submit" /> - 
                    <input name="action" value="Je refuse" onClick="location='{$url_nonvalide}'" type="submit" />
                </div>
            {/if}     
        </div>
    </div>
    <div class="content-left-bottom"></div>
</div>
