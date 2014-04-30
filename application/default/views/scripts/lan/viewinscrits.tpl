          
<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$title|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            	<br/>
                <table width="825px">
                	<tr height="30" class="table-th">
                    	<th width="40"></th>
                    	<th width="100">Login</th>
                    	<th width="100">Pr&eacute;nom</th>
                    	<th width="70">Age</th>
                        <th width="300">Localit&eacute;</th>
                        <th width="130">Team</th>
                        <th>Actif</th>
                    </tr>
                    
                    {foreach from=$joueurs item=j name=joueur}
                    	{if $smarty.foreach.joueur.index%2}
                        <tr height="40" class="td-paire">
                        {else}
                        <tr height="40" class="td-impaire">
                        {/if}
                        	<td align="center"><img src="{$base_url}/images/comptes/thumb/{$j.img}" name="{$j.login|capitalize|utf8_encode}" alt="{$j.login|capitalize|utf8_encode}" class="textalignm" title="{$j.login|capitalize|utf8_encode}" /></td>
                        	<td width="100px">{$j.login|capitalize|utf8_encode}</td>
                            <td> {$j.prenom|lower|capitalize|utf8_encode} </td>
                            <td> {$datedujour-$j.datenaissance} </td>
                            <td>{$j.ville|utf8_encode|lower|capitalize} ({$j.cp})</td>
                            <td>
                                {if $j.nom_t=="Sans Team"}
                                    <span class="italic">{$j.nom_t|utf8_encode}</span>
                                {else}
                                    {$j.nom_t|utf8_encode}
                                {/if}
                            </td>
                            <td align="center">
                            	{if $j.validation==1}
                            		<img src="{$base_url}/images/admin/ball_green.png" name="Actif" alt="Actif" class="textalignm" title="Actif" />
                            	{else}
                                	<img src="{$base_url}/images/admin/ball_red.png" name="Desactif" alt="Desactif" class="textalignm" title="Desactif" />
                                {/if}
                            </td>
                    	</tr>
                    
                    {/foreach}
                    
                </table>

            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
		<div class="content-total-princ content-separator">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Emplacement des {$title|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                
                {$map->getGoogleMap()}
                
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    
</div>
