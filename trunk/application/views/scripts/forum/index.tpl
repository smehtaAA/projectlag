<div id="content-total">
	{if $forum_ouvert.valeur==1}
    
         <div class="content-total-princ">
            <div class="content-total-top"></div>
            <div class="content-total-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-total"><h3>Info Forum</h3></div>
                <div class="content-title-right"></div>
                <div class="content-total-text">
                <a href="{$base_url}/forum"> Forum </a>
                <br/><br/>
                
                {if $login.login!=''}
            		Bienvenue, <span class="rouge"><em>{$login.login|utf8_encode}</em></span> <br/><br/>
            	{else}
            		Bienvenue, <span class="rouge"><em>Invit&eacute;</em></span> <br/>
					Merci de vous identifier ou de vous inscrire. <br/><br/>
            	{/if}
                	
                
                </div>
            </div>
            <div class="content-total-bottom"></div>
        </div>
    
    
        {foreach from=$categories item=cat name=cat}
    	
        	<div class="content-total-princ content-separator">
            <div class="content-total-top"></div>
            <div class="content-total-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-total"><a href="{$url_cat}{$cat.idCategorie}"><h3>{$cat.titre|utf8_encode}</h3></a></div>
                <div class="content-title-right"></div>
                <div class="content-total-text">
                
                <table border=1>
                <tr height="35px" bgcolor="#555555">
                    <th width="450px"> Forum </th>
                    <th width="50px"> Sujets </th>
                    <th width="75px"> R&eacute;ponses </th>
                    <th width="240px" > Dernier message </th>
                </tr>
                
                    {foreach from=$sscat[$cat.idCategorie] item=sc name=sc}
                        <tr height="40px">
                            <td><a href="{$url_sscat}{$sc.idSousCategorie}"><span class="rouge"><strong>{$sc.titre|utf8_encode}</strong></span></a> <br/> {$sc.description|utf8_encode}</td>
                            <td align="center">{$nb[$sc.idSousCategorie].nb_sujets}</td>
                            <td align="center">{$nb[$sc.idSousCategorie].nb_reponses}</td>
                            <td>{if $last_messages[$sc.idSousCategorie] == -1} 
                                    Aucun Message 
                                {else}
                                    <span class="rouge"><strong>{$last_messages[$sc.idSousCategorie].titre}</strong></span><br/>
                                    par <span class="rouge">{$last_messages[$sc.idSousCategorie].login}</span> | {$last_messages[$sc.idSousCategorie].date_m|date_format:"%d/%m/%Y %H:%M"}
                                {/if}</td>
                        </tr>
                    {/foreach}
                </table>
                
                </div>
            </div>
            <div class="content-total-bottom"></div>
        </div>
        {/foreach}
        
        <!-- Affichage des Statistiques -->
        
        <div class="content-total-princ content-separator">
            <div class="content-total-top"></div>
            <div class="content-total-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-total"><h3>Forum Stats</h3></div>
                <div class="content-title-right"></div>
                <div class="content-total-text">
                <p> 
                	Nb total d'utilisateurs: <span class="rouge">{$stats.nb}</span>  Dernier inscrit: <span class="rouge"><em>{$stats.last.login}</em></span> <br/>
                	Nb total de messages:{$stats.nb_messages} Nb total de sujets:{$stats.nb_sujets} Nb total de cat&eacute;gories:{$stats.nb_cat} Nb total de sous-cat&eacute;gories:{$stats.nb_sscat}
                
                
                </p>
                	
                
                </div>
            </div>
            <div class="content-total-bottom"></div>
        </div>
        
        
        
        
        
        
    {else}
    	<div class="content-total-princ">
            <div class="content-total-top"></div>
            <div class="content-total-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-total"><h3>Maintenance</h3></div>
                <div class="content-title-right"></div>
                <div class="content-total-text">
                <p> Le forum est actuellement en maintenance, veuillez revenir ult&eacute;rieurement ! </p>
                	
                
                </div>
            </div>
            <div class="content-total-bottom"></div>
        </div>
       	
    {/if}

</div>