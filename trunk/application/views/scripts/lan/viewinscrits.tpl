
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
                <table border=1 width="830px">
                	<tr>
                    	<th width="140px">Login</th>
                        <th width="140px">Team</th>
                        <th width="500px">Jeux</th>
                        <th>Actif</th>
                    </tr>
                    
                    {foreach from=$joueurs item=j name=joueur}
                    	<tr>
                        	<td width="100px">{$j.login|capitalize|utf8_encode}</td>
                            <td>{$jeux[$j.idCompte][0].nom_team|utf8_encode}</td>
                            <td><em>
                            	{foreach from=$jeux[$j.idCompte] item=jeu name=jeu}
                            		{$jeu.nom_jeux|utf8_encode}
                                    {if !$smarty.foreach.jeu.last}-{/if}
                            	{/foreach}
                            </em></td>
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
            <div class="content-title-middle content-title-middle-total"><h3>{$title|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
				{$map->printMap()}
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    
</div>
