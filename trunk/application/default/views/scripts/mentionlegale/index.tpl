<div id="content-total">
    
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$titre|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <br />
                <ul>
                {foreach from=$datas key=myId item=i name=foo}
                    <li> 
                        <h4>{$smarty.foreach.foo.index+1} - {$i.titre}</h4>
                        <br />
                        {$i.description|utf8_decode}
                        <br /><br />
                    </li>
                {/foreach}
				</ul>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    
</div>


