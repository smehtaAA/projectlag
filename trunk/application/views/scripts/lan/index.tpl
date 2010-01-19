{if $map_google==1}
{$map->printHeaderJS()}
{$map->printMapJS()}
{/if}

<div id="content-total">

	<div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Lans</h3></div>
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

    	{if $l.datedeb > $smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}
    
        <div class="content-middle-princ content-separator-right content-separator" id="lan_{$l.idLan}">
            <div class="content-middle-top"></div>
            <div class="content-middle-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-middle"><h3>{$l.nom|utf8_encode}</h3></div>
                <div class="content-title-right"></div>
                <div class="content-middle-text">
                    <strong><img src="{$base_url}/images/icones/icon-city.png" alt="Lieu" title="Lieu" style="vertical-align:middle" /> &nbsp;Lieux &nbsp;:</strong>&nbsp; {$l.adresse|utf8_encode}<br />
                    <div style="padding-left:62px;"></strong>&nbsp; {$l.ville|utf8_encode} ({$l.cp})</div>
                   <br />
                    	<table>
                    	<tr>
                    		<td><strong><img src="{$base_url}/images/icones/icon-euro.png" alt="Prix" title="Prix" style="vertical-align:middle" /> &nbsp;Prix &nbsp;:</strong>&nbsp;</td><td> {$l.prix_prepaiement} &euro; par ch&egrave;que &agrave; l'ordre de l'AFM T&eacute;l&eacute;thon</td>
                    	</tr>
                    	<tr><td></td><td> {$l.prix_prepaiement_paypal} &euro; par PayPal (prise en compte d'une compensation du fee)</td></tr>
                    	<tr><td></td><td> {$l.prix} &euro; sur place</td></tr>
                    </table>
                    
                    <br />
                    <strong><img src="{$base_url}/images/icones/icon-date.png" alt="Date debut" title="Date debut" style="vertical-align:middle" /> &nbsp;Date de d&eacute;but &nbsp;:</strong>&nbsp; Le {$l.datedeb|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$l.datedeb|date_format:"%H:%M"}<br />
                    <strong><img src="{$base_url}/images/icones/icon-date.png" alt="Date fin" title="Date fin" style="vertical-align:middle" /> &nbsp;Date de fin &nbsp;:</strong>&nbsp; Le {$l.datefin|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$l.datefin|date_format:"%H:%M"}
                    <br /><br />
                    
                    {if $lan_ouverte.idLan == $l.idLan}
                        <strong><img src="{$base_url}/images/icones/icon-user.png" alt="Inscrits" title="Inscrits" style="vertical-align:middle" /> &nbsp;<a href="{$base_url}/lan/viewinscrits?id={$l.idLan}">{$chiffre[$l.idLan].pre_inscrit}</strong> Pr&eacute;-Inscrits</a><br />
                    {/if}
                    {if $lan_ouverte.idLan == $l.idLan || $l.datedeb < $smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}
                        <strong><img src="{$base_url}/images/icones/icon-user.png" alt="Inscrits" title="Inscrits" style="vertical-align:middle" /> &nbsp;<a href="{$base_url}/lan/viewinscrits?id={$l.idLan}">{$chiffre[$l.idLan].insc}</strong> Inscrits</a><br />
                    {/if}
                    {if $l.datedeb < $smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}
                        <strong><img src="{$base_url}/images/icones/icon-user.png" alt="Presents" title="Presents" style="vertical-align:middle" /> &nbsp;{$chiffre[$l.idLan].present}</strong> Pr&eacute;sents<br />
                    {/if}
                    <br/>
                    <strong><img src="{$base_url}/images/icones/icon-games.png" alt="Jeux" title="Jeux" style="vertical-align:middle" /> &nbsp;Liste des jeux :</strong> 
                    <ul>
                    {foreach from=$jeux[$l.idLan] item=j name=jeu}
                        <li>{$j.nom|utf8_encode}</li>
                    {/foreach}
					
					<li> et bien d'autres ... </li>
                    </ul>
					<br />
					<strong><img src="{$base_url}/images/icones/icon-network.png" alt="Mat&eacute;riels" title="Mat&eacute;riels" style="vertical-align:middle" /> &nbsp;Mat&eacute;riels &agrave; ramener par le joueur:</strong> 

					<ul>
						<li> Ordinateur (Unit&eacute; centrale, &eacute;cran, clavier ...) </li>
						<li> Casque obligatoire (les enceintes sont interdites) </li>
						<li> C&acirc;ble r&eacute;seaux de 5m minimum </li>
						<li> Multi-prise &eacute;lectrique </li>
						
					
					</ul>
					
                </div>
            </div>
            <div class="content-middle-bottom"></div>
        </div>
        {if $map_google==1}
        <div class="content-middle-princ content-separator">
            <div class="content-middle-top"></div>
            <div class="content-middle-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-middle"><h3>Plan de la lan</h3></div>
                <div class="content-title-right"></div>
                <div class="content-middle-text" style="height:454px;">
                    {$map->printMap()}
    
                </div>
            </div>
            <div class="content-middle-bottom"></div>
        </div>
        {/if}
        
        <div class="content-total-princ content-separator">
            <div class="content-total-top"></div>
            <div class="content-total-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-total"><h3>Description</h3></div>
                <div class="content-title-right"></div>
                <div class="content-total-text">
                    {$l.description|nl2br|utf8_encode}
        
                    <br/><br/>
                    {$l.extra|nl2br|utf8_encode}
                    
                </div>
            </div>
            <div class="content-total-bottom"></div>
    	</div>
        {else}
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
        {/if}

    {/foreach}
</div>
