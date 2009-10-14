<div id="content-total">

	<div class="content-total-princ">
            <div class="content-total-top"></div>
            <div class="content-total-middle">
                <div class="content-title-left"></div>
                <div class="content-title-middle content-title-middle-total"><h3>Info Forum</h3></div>
                <div class="content-title-right"></div>
                <div class="content-total-text">
                <a href="{$base_url}/forum"> Forum </a> > <a href="{$base_url}/categorie?id={$fil_arianne.idCategorie}"> {$fil_arianne.titre_cat|utf8_encode}</a> > <a href="{$base_url}/souscategorie?id={$fil_arianne.idSousCategorie}"> {$fil_arianne.titre_sscat|utf8_encode}</a> > <a href="{$base_url}/sujet?id={$fil_arianne.idSujet}"> <strong>{$fil_arianne.titre_s|utf8_encode}</strong></a>  <br/><br/>
                
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
            <div class="content-title-middle content-title-middle-total"><h3>{$sujet.titre|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            <br/><br/>
            	<a href="{$url_reponse}"> R&eacute;pondre </a>
            <br/><br/>
            
          <table border="1">
          	<tr>
            	<th></th>
                <th></th>
            </tr>
          {foreach from=$messages item=m name=message}
          	<tr>
            	<td width="200px" align="center">
                	<img src="{$base_url}/images/comptes/{$comptes[$m.idCompte].img}"  /><br/>
                    <span class="rouge"><strong>{$comptes[$m.idCompte].login}</strong></span><br/>
                    {if $comptes[$m.idCompte].nom_f == 'joueur'}
                    	{$comptes[$m.idCompte].nom_g}
                    {else}
                    	Administrateur
                    {/if}
                    <br/>
                    Messages : {$comptes[$m.idCompte].nb_messages}<br/>
                
                </td>
                <td width="620px">
                	<span style="font-size:16px"><strong>{$sujet.titre|utf8_encode}</strong></span> >
                    <em>
                	{if ($datedujour-$m.date_m)==0}
                    	Aujourd'hui
                    {elseif ($datedujour-$m.date_m)==1}
                    	Hier
                    {else}
                    	{$datedujour-$m.date_m+1} 
                    {/if}
                    </em>
                    {if $login.nom_f == 'admin' || $login.nom_f == 'superadmin'}
                     	! A deplacer a droite ! <a href="{$url_del_message}{$m.idMessage}"> Supprimer </a>
                    {/if}
                    <br/>
                    <hr />
            		{$m.description|nl2br} <br/> <br/>
                    <hr />
                    {$comptes[$m.idCompte].citationpreferee}
                    <br/><br/>
                </td>
            </tr>
            
          {/foreach}
          </table>
                      <br/><br/>
            	<a href="{$url_reponse}"> R&eacute;pondre </a>
            <br/><br/>
          
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>

