<div id="content-total">
	<div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Info Forum</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                {if $login.login!=''}
                    Bienvenue, <span class="rouge"><em>{$login.login|utf8_encode}</em></span>
                {else}
                    Bienvenue, <span class="rouge"><em>Invit&eacute;</em></span> <br/>
                    Merci de vous identifier ou de vous <a href="{$base_url}/inscription/inscriptionmembre">inscrire</a>.
                {/if}
            
            	<ul>
            		<li><a href="{$base_url}/forum"> Forum </a> > <a href="{$base_url}/categorie?id={$fil_arianne.cat.id}"><strong> {$fil_arianne.cat.nom|utf8_encode}</strong></a></li>
                </ul>
                
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>


	<div class="content-total-princ content-separator">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$categorie.titre|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            <table border=1>
                <tr height="30" class="table-th">
                    <th width="40"></th>
                    <th width="450"> Forum </th>
                    <th width="65"> Sujets </th>
                    <th width="65"> R&eacute;ponses </th>
                    <th width="200" > Dernier message </th>
                </tr>
            
            	{foreach from=$sscat item=sc name=sscat}
                    {if $smarty.foreach.sscat.index%2}
                    <tr height="40" class="td-paire">
                    {else}
                    <tr height="40" class="td-impaire">
                    {/if}
                        <td style="vertical-align:bottom;"><img src="images/icones/icon-forum.png" /></td>
                    	<td>
                        	<a href="{$url_viewsc}{$sc.idSousCategorie}"><span class="rouge"><strong>{$sc.titre|utf8_encode}</strong></span></a><br />
                            <span class="font-min">{$sc.description|utf8_encode}</span>
                        </td>
                        <td align="center">{$nb[$sc.idSousCategorie].nb_sujets}</td>
                        <td align="center">{$nb[$sc.idSousCategorie].nb_reponses}</td>
                        <td>{if $last_messages[$sc.idSousCategorie] == -1} 
                            	<em>Aucun Message</em>
                            {else}
                                <span class="rouge"><strong><a href="{$base_url}/sujet?id={$last_messages[$sc.idSousCategorie].idSujet}">{$last_messages[$sc.idSousCategorie].titre|utf8_encode}</a></strong></span><br/>
                                <span class="font-min">par <span class="rouge">{$last_messages[$sc.idSousCategorie].login}</span> | {$last_messages[$sc.idSousCategorie].date_m|date_format:"%d/%m/%Y %H:%M"}</span>
                            {/if}
                        </td>
                    </tr>
            	{/foreach}
            </table>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    
            <!-- Affichage des Statistiques -->
        
        <div class="content-total-princ content-separator">
            <div class="content-total-top"></div>
            <div class="content-total-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-total"><h3>Forum Stats</h3></div>
                <div class="content-title-right"></div>
                <div class="content-total-text">
                	<ul>
                		<li>Nb total d'utilisateurs: <span class="rouge">{$stats.nb}</span></li>
                    	<li>Dernier inscrit: <span class="rouge italic">{$stats.last.login}</span></li>
                		<li>Nb total de messages: <strong>{$stats.nb_messages}</strong> &nbsp;&nbsp;&nbsp;&nbsp;Nb total de sujets: <strong>{$stats.nb_sujets}</strong> &nbsp;&nbsp;&nbsp;&nbsp;Nb total de cat&eacute;gories: <strong>{$stats.nb_cat}</strong> &nbsp;&nbsp;&nbsp;&nbsp;Nb total de sous-cat&eacute;gories: <strong>{$stats.nb_sscat}</strong></li>
                	</ul>
                </div>
            </div>
            <div class="content-total-bottom"></div>
        </div>
    
</div>