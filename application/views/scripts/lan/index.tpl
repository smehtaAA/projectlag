



<div id="content-total">

	<div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Historiques des Lans</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            	<ul>
				{foreach from=$lans item=la name=lan_ancre}
                	<li><a href="#lan_{$la.idLan}">{$la.nom|utf8_encode}</a></li>
                {/foreach}
                </ul>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>



    {foreach from=$lans item=l name=lan}




        		<div class="content-total-princ content-separator" id="lan_{$l.idLan}">
                    <div class="content-total-top"></div>
                    <div class="content-total-middle">
                        <div class="content-title-left"></div>
                        <div class="content-title-middle content-title-middle-total"><h3>{$l.nom|utf8_encode}</h3></div>
                        <div class="content-title-right"></div>
                        <div class="content-total-text">
                        	<strong><img src="{$base_url}/images/icones/icon-city.png" alt="Lieu" title="Lieu" style="vertical-align:middle" /> &nbsp;Lieux &nbsp;:</strong>&nbsp; {$l.adresse|utf8_encode}<br />
                    		<div style="padding-left:62px;"></strong>&nbsp; {$l.ville|utf8_encode} ({$l.cp})</div>
                            <br /><br />
                            <strong><img src="{$base_url}/images/icones/icon-date.png" alt="Date debut" title="Date debut" style="vertical-align:middle" /> &nbsp;Date de d&eacute;but &nbsp;:</strong>&nbsp; Le {$l.datedeb|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$l.datedeb|date_format:"%H:%M"}<br />
                            <strong><img src="{$base_url}/images/icones/icon-date.png" alt="Date fin" title="Date fin" style="vertical-align:middle" /> &nbsp;Date de fin &nbsp;:</strong>&nbsp; Le {$l.datefin|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$l.datefin|date_format:"%H:%M"}
                            <br /><br />
                            
                            {if $lan_ouverte.idLan == $l.idLan}
                                <strong><img src="{$base_url}/images/icones/icon-user.png" alt="Inscrits" title="Inscrits" style="vertical-align:middle" /> &nbsp;<a href="{$base_url}/lan/viewinscrits?id={$l.idLan}">{$chiffre[$l.idLan].insc}</strong> Inscrits</a><br />
                            {/if}
                            {if $l.datedeb < $smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}
                                <strong><img src="{$base_url}/images/icones/icon-user.png" alt="Presents" title="Presents" style="vertical-align:middle" /> &nbsp;<a href="{$base_url}/lan/viewpresents?id={$l.idLan}">{$chiffre[$l.idLan].present}</strong> Pr&eacute;sents</a><br />
                            {/if}
                        	<br/>
                        
                        
                            {$l.description|nl2br|utf8_encode}
                            <br/><br/>
                
                            <strong><img src="{$base_url}/images/icones/icon-games.png" alt="Jeux" title="Jeux" style="vertical-align:middle" /> &nbsp;Liste des jeux :</strong> 
                            <ul>
                            {foreach from=$jeux[$l.idLan] item=j name=jeu}
                                <li>{$j.nom|utf8_encode}</li>
                            {/foreach}
                            </ul>
                            <br/><br/>
                            {$l.extra|nl2br|utf8_encode}
                        </div>
                    </div>
                    <div class="content-total-bottom"></div>
                </div>


    {/foreach}

</div>
