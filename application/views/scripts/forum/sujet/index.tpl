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
                	<li><a href="{$base_url}/forum"> Forum </a> > <a href="{$base_url}/categorie?id={$fil_arianne.idCategorie}"> {$fil_arianne.titre_cat|utf8_encode}{if $fil_arianne.admin_cat==1} [Admin] {/if}</a> > <a href="{$base_url}/souscategorie?id={$fil_arianne.idSousCategorie}"> {$fil_arianne.titre_sscat|utf8_encode}{if $fil_arianne.admin_sscat==1} [Admin] {/if}</a> > <a href="{$base_url}/sujet?id={$fil_arianne.idSujet}"> <strong>{$fil_arianne.titre_s|utf8_encode}</strong></a></li>
                </ul>     	
                </div>
            </div>
            <div class="content-total-bottom"></div>
       </div>

	<div class="content-total-princ content-separator">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$sujet.titre|utf8_encode}</h3>
            
            {if $login.nom_f == 'admin' || $login.nom_f == 'superadmin'}
                	 <div style="float:right"><a href="{$url_del_sujet}{$sujet.idSujet}" onclick="return(confirm('Etes-vous sur de vouloir supprimer ce sujet ?'));"> Supprimer le sujet</a></div>
                {/if}
            </div>
            <div class="content-title-right">
            </div>
            <div class="content-total-text">
            <br/>
                 <a href="{$url_reponse}" class="bouton-forum"><span class="rouge bold"> R&eacute;pondre </span></a>
            <br/><br/><br/>
            
          <table border="1">
          {foreach from=$messages item=m name=message}
          	<tr>
            	<td width="170" align="center" style="padding-top:10px;padding-bottom:10px;padding-top:10px;" class="td-paire">
                	{if $comptes[$m.idCompte].img != ""}
                        <img src="{$base_url}/images/comptes/{$comptes[$m.idCompte].img}" />
                    {else}
                        <img src="{$base_url}/images/comptes/no_logo.png" />
                    {/if}
                    <br/>
                    <span class="rouge"><strong>{$comptes[$m.idCompte].login|utf8_encode}</strong></span><br/>
                    {if $comptes[$m.idCompte].nom_f == 'joueur'}
                    	{$comptes[$m.idCompte].nom_g|utf8_encode}
                    {else}
                    	Administrateur
                    {/if}
                    <br/>
                    <span class="italic">Messages : {$comptes[$m.idCompte].nb_messages}</span><br/>
                
                </td>
                <td width="643" valign="top" style="padding-top:10px;padding-bottom:10px;padding-top:10px;" class="td-impaire">
                	<span style="font-size:14px" class="bold rouge">{$sujet.titre|utf8_encode}</span> >
                    <span class="italic font-min">Post&eacute; le {$m.date_m|date_format:"%d/%m/%Y"} &agrave; {$m.date_m|date_format:"%H:%M:%S"}</span>
                    {if $login.nom_f == 'admin' || $login.nom_f == 'superadmin'}
                     	<div style="float:right;">
                        <a href="{$url_upd_message}{$m.idMessage}"> Editer </a>
                        <a href="{$url_del_message}{$m.idMessage}" onclick="return(confirm('Etes-vous sur de vouloir supprimer cette reponse ?'));"> Supprimer </a></div>
                    {/if}
                    <br/>
                    <hr />
            		{$m.description|nl2br|utf8_encode} <br /> <br />
                    <hr />
                    <div class="italic font-min" style="float:right">{$comptes[$m.idCompte].citationpreferee|utf8_encode}</div>
                </td>
            </tr>
            
          {/foreach}
          </table>
              <br/><br/>
                  <a href="{$url_reponse}" class="bouton-forum"><span class="rouge bold"> R&eacute;pondre </span></a>
            <br/><br/>
          
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>

