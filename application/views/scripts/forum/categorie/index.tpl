<div id="content-total">
	<div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Info Forum</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            	<a href="{$base_url}/forum"> Forum </a> > <a href="{$base_url}/categorie?id={$fil_arianne.cat.id}"><strong> {$fil_arianne.cat.nom|utf8_encode}</strong></a> <br/> <br/>
                
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


	<div class="content-total-princ content-separator">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$categorie.titre|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            <br/>
            <table border=1>
            <tr height="35px" bgcolor="#555555">
                    <th width="450px"> Forum </th>
                    <th width="50px"> Sujets </th>
                    <th width="75px"> R&eacute;ponses </th>
                    <th width="240px" > Dernier message </th>
            </tr>
            
            	{foreach from=$sscat item=sc name=sscat}
            		<tr height="40px">
                    	<td><a href="{$url_viewsc}{$sc.idSousCategorie}"><span class="rouge"><strong>{$sc.titre|utf8_encode}</strong></span></a></td>
                        <td align="center">{$nb[$sc.idSousCategorie].nb_sujets}</td>
                        <td align="center">{$nb[$sc.idSousCategorie].nb_reponses}</td>
                        <td>{if $last_messages[$sc.idSousCategorie] == -1} 
                            	Aucun Message 
                            {else}
                                <span class="rouge"><strong><a href="{$base_url}/sujet?id={$last_messages[$sc.idSousCategorie].idSujet}">{$last_messages[$sc.idSousCategorie].titre|utf8_encode}</a></strong></span><br/>
                                par <span class="rouge">{$last_messages[$sc.idSousCategorie].login}</span> | {$last_messages[$sc.idSousCategorie].date_m|date_format:"%d/%m/%Y %H:%M"}
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
                <p> 
                	Nb total d'utilisateurs: <span class="rouge">{$stats.nb}</span>  Dernier inscrit: <span class="rouge"><em>{$stats.last.login}</em></span> <br/>
                	Nb total de messages:{$stats.nb_messages} Nb total de sujets:{$stats.nb_sujets} Nb total de cat&eacute;gories:{$stats.nb_cat} Nb total de sous-cat&eacute;gories:{$stats.nb_sscat}
                
                
                </p>
                	
                
                </div>
            </div>
            <div class="content-total-bottom"></div>
        </div>
    
</div>