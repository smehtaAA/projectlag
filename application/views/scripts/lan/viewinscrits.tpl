{$map->printHeaderJS()}
{$map->printMapJS()}

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
                	<tr>
                    	<th width="40px"></th>
                    	<th width="100px" align="left">Login</th>
                    	<th width="100px" align="left">Pr&eacute;nom</th>
                    	<th width="70px" align="left">Age</th>
                        <th width="300px" align="left">Localit&eacute;</th>
                        <th width="130px" align="left">Team</th>
                        <th>Pay&eacute;</th>
                    </tr>
                    
                    {foreach from=$joueurs item=j name=joueur}
                    	<tr>
                        	<td align="center"><img src="{$base_url}/images/comptes/thumb/{$j.img}" name="{$j.login|capitalize|utf8_encode}" alt="{$j.login|capitalize|utf8_encode}" class="textalignm" title="{$j.login|capitalize|utf8_encode}" /></td>
                        	<td width="100px">{$j.login|capitalize|utf8_encode}</td>
                            <td> {$j.prenom|lower|capitalize|utf8_encode} </td>
                            <td> {$datedujour-$j.datenaissance} </td>
                            <td>{$j.ville|utf8_encode|lower|capitalize} ({$j.cp})</td>
                            <td>{$j.nom_t|utf8_encode}</td>
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
				{$map->printMap()}
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    
</div>
