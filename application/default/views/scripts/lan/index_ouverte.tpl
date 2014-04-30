
<div id="content-total">

		<div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Historique</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            	<ul>
            		<li><a href="?m=histo">Voir l'historique des Lans</a></li>
            	</ul>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    


    
        <div class="content-middle-princ content-separator-right content-separator" id="lan_{$lan.idLan}">
            <div class="content-middle-top"></div>
            <div class="content-middle-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-middle"><h3>{$lan.nom|utf8_encode}</h3></div>
                <div class="content-title-right"></div>
                <div class="content-middle-text">
                    <strong><img src="{$base_url}/images/icones/icon-city.png" alt="Lieu" title="Lieu" style="vertical-align:middle" /> &nbsp;Lieux &nbsp;:</strong>&nbsp; {$lan.adresse|utf8_encode}<br />
                    <div style="padding-left:62px;"></strong>&nbsp; {$lan.ville|utf8_encode} ({$lan.cp})</div>
                   <br />
                    	<table>
                    	<tr>
                    		<td><strong><img src="{$base_url}/images/icones/icon-euro.png" alt="Prix" title="Prix" style="vertical-align:middle" /> &nbsp;Prix &nbsp;:</strong>&nbsp;</td><td> {$lan.prix_prepaiement} &euro; par ch&egrave;que &agrave; l'ordre de 
                            
                        {if $lan.telethon == 1}
                        	l'AFM T&eacute;l&eacute;thon
                        {else}
                        	la LAG
                        {/if}
                        </td>
                    	</tr>
                    	<tr><td></td><td> {$lan.prix_prepaiement_paypal} &euro; par PayPal </td></tr>
                    	<tr><td></td><td> {$lan.prix} &euro; sur place</td></tr>
                    </table>
                    
                    <br />
                    <strong><img src="{$base_url}/images/icones/icon-date.png" alt="Date debut" title="Date debut" style="vertical-align:middle" /> &nbsp;Date de d&eacute;but &nbsp;:</strong>&nbsp; Le {$lan.datedeb|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$lan.datedeb|date_format:"%H:%M"}<br />
                    <strong><img src="{$base_url}/images/icones/icon-date.png" alt="Date fin" title="Date fin" style="vertical-align:middle" /> &nbsp;Date de fin &nbsp;:</strong>&nbsp; Le {$lan.datefin|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$lan.datefin|date_format:"%H:%M"}
                    <br /><br />
                    
                    {if $lan_ouverte.idLan == $lan.idLan}
                        <strong><img src="{$base_url}/images/icones/icon-user.png" alt="Inscrits" title="Inscrits" style="vertical-align:middle" /> &nbsp;<a href="{$base_url}/lan/viewinscrits?id={$lan.idLan}">{$chiffre.pre_inscrit}</strong> Pr&eacute;-Inscrits</a><br />
                    {/if}
        
                    {if $lan_ouverte.idLan == $lan.idLan || $lan.datedeb < $smarty.now|date_format:"%Y-%m-%d %H:%M:%S"}
                        <strong><img src="{$base_url}/images/icones/icon-user.png" alt="Inscrits" title="Inscrits" style="vertical-align:middle" /> &nbsp;<a href="{$base_url}/lan/viewinscrits?id={$lan.idLan}">{$chiffre.insc}</strong> Inscrits</a><br />
                    {/if}
                    <br/>
                    <strong><img src="{$base_url}/images/icones/icon-games.png" alt="Jeux" title="Jeux" style="vertical-align:middle" /> &nbsp;Liste des jeux :</strong> 
                    <ul>
                    {foreach from=$jeux[$lan.idLan] item=j name=jeu}
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
        {if $map_google>0}
        <div class="content-middle-princ content-separator">
            <div class="content-middle-top"></div>
            <div class="content-middle-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-middle"><h3>Plan de la lan</h3></div>
                <div class="content-title-right"></div>
                <div class="content-middle-text" style="height:350px;">
                {if $map_google==1}
                    {$map->getGoogleMap()}
                {else}
                    {$map_error}
                {/if}
    
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
                    {$lan.description|nl2br|utf8_encode}
        
                    <br/><br/>
                    {$lan.extra|nl2br|utf8_encode}
                    
                </div>
            </div>
            <div class="content-total-bottom"></div>
    	</div>
       
</div>
