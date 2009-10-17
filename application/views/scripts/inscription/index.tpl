<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$titre}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                {if $ouverte==true}
                    <div id="inscription-charte">
                        {foreach from=$articles item=art name=art}   
                            <h3>{$smarty.foreach.art.index+1} - {$art.titre|utf8_encode}</h3>   
                            <br/><br/>    
                            {$art.description|nl2br|utf8_encode}      
                            <br/>  
                        {/foreach}
                     </div>
                    <center>
                    	<br />
                        <input name="action" value="Je refuse" onClick="location='{$url_nonvalide}'" type="submit" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    	<input name="action" value="J'accepte" onClick="location='{$url_valide}'" type="submit" />
                    </center>
                {/if}     
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>