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
                <li><a href="{$base_url}/forum">Forum</a> > <a href="{$base_url}/categorie?id={$fil_arianne.idCategorie}">{$fil_arianne.titre_cat|utf8_encode}{if $fil_arianne.admin_cat==1} [Admin]{/if}</a> > <a href="{$base_url}/souscategorie?id={$fil_arianne.idSousCategorie}">{$fil_arianne.titre_sscat|utf8_encode}{if $fil_arianne.admin_sscat==1} [Admin]{/if}</a> > <a href="{$base_url}/sujet?id={$fil_arianne.idSujet}"><strong>{$fil_arianne.titre_s|utf8_encode}</strong></a></li>
            </ul>
            </div>
        </div>
        <div class="content-total-bottom"></div>
   </div>

	<div class="content-total-princ content-separator">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total">
                <h3>{$sujet.titre|utf8_encode}</h3>
            	<div style="float:right">
                     {if $login.nom_f == 'superadmin'}
                     	<a href="{$url_del_sujet}{$sujet.idSujet}" onclick="return(confirm('Etes-vous sur de vouloir supprimer ce sujet ?'));"> Supprimer le sujet</a>
                     {/if}
            	</div>               
            </div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <div style="float:left;width:827px;height:50px;">
                    {if $sujet.bloque==0}
                        <div style="float:left;margin-top:10px;">
                            <a href="{$url_reponse}" class="bouton-forum"><span class="rouge bold">R&eacute;pondre</span></a>
                        </div>
                    {/if}

                    {if ($login.nom_f == 'superadmin' || ($login.nom_f == 'admin' && ($sujet.nom=='joueur' || $sujet.nom=='admin')) || ($login.idCompte == $sujet.idCompte)) && $sujet.bloque==0}
                        <div style="float:right;margin-top:10px;">
                            <a href="{$url_cloture_sujet}{$sujet.idSujet}&a=1" class="bouton-forum" onclick="return(confirm('Etes-vous sur de vouloir cloturer ce sujet ?'));"><span class="rouge bold">Cloturer</span></a>
                        </div>
                    {elseif $login.nom_f == 'superadmin' &&  $sujet.bloque==1}
                        <div style="float:right;margin-top:10px;">
                            <a href="{$url_cloture_sujet}{$sujet.idSujet}&a=0" class="bouton-forum" onclick="return(confirm('Etes-vous sur de vouloir ouvrir ce sujet ?'));"><span class="rouge bold">Ouvrir</span></a>
                        </div>
                    {/if}
                </div>
                <table border="0">
                  {foreach from=$messages item=m name=message}
                    <tr>
                        <td rowspan="3" width="170" align="center" style="padding-top:10px;padding-bottom:10px;padding-top:10px;" class="td-paire">
                            <a href="{$base_url}/forum/fiche?id={$comptes[$m.idCompte].idCompte}"><span class="rouge bold" style="font-size:13px;">{$comptes[$m.idCompte].login|utf8_encode}</span></a><br/>
                            <a href="{$base_url}/forum/fiche?id={$comptes[$m.idCompte].idCompte}">
                            {if $comptes[$m.idCompte].img != ""}
                                <img src="{$base_url}/images/comptes/{$comptes[$m.idCompte].img}" alt="{$comptes[$m.idCompte].login|utf8_encode}" title="{$comptes[$m.idCompte].login|utf8_encode}" style="margin-top:8px;margin-bottom:8px;"/>
                            {else}
                                <img src="{$base_url}/images/comptes/no_logo.png" style="margin-top:8px;margin-bottom:8px;"/>
                            {/if}
                            </a>
                            <br/>
                            {if $comptes[$m.idCompte].nom_f == 'superadmin'}
                                <strong>God Master</strong>
                            {elseif $comptes[$m.idCompte].nom_f == 'admin'}
                                <strong>Master</strong>
                            {else}
                                {$comptes[$m.idCompte].nom_g|utf8_encode}
                            {/if}
                            <br/>
                            <span class="italic">Inscrit le : {$comptes[$m.idCompte].dateins|date_format:"%d.%m.%Y"}</span><br/>
                            <span class="italic">Messages : {$comptes[$m.idCompte].nb_messages}</span><br/>

                        </td>
                        <td width="652" height="20" valign="top" style="border:0px;padding-top:10px;padding-bottom:10px;" class="td-impaire">
                            <span style="font-size:14px" class="bold rouge">{$sujet.titre|utf8_encode}</span> >
                            <span class="italic font-min">Post&eacute; le {$m.date_m|date_format:"%d/%m/%Y"} &agrave; {$m.date_m|date_format:"%H:%M:%S"}</span>
                            {if $login.nom_f == 'superadmin'}
                                <div style="float:right;">
                                <a href="{$url_upd_message}{$m.idMessage}">Editer</a>
                                &nbsp;&nbsp; - &nbsp;&nbsp;
                                <a href="{$url_del_message}{$m.idMessage}" onclick="return(confirm('Etes-vous sur de vouloir supprimer cette reponse ?'));"> Supprimer </a></div>
                            {elseif $login.idCompte == $m.idCompte}
                                <div style="float:right;">
                                <a href="{$url_upd_message}{$m.idMessage}">Editer</a></div>
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td height="140" valign="top" style="padding-top:10px;padding-bottom:10px;border:0px;border-top: 1px dotted #999999;" class="td-impaire border-top-pointer">
                            {$m.description|nl2br|utf8_encode}
                        </td>
                    </tr>
                    <tr>
                        <td height="25" class="td-impaire" style="border-top: 1px dotted #999999;">
                            {if $m.date_edition != 0}
                            <div class="italic font-min" style="float:left">Edit&eacute; le {$m.date_edition|date_format:"%d/%m/%Y"} &agrave; {$m.date_edition|date_format:"%H:%M:%S"} par {$m.auteur_edition} <br/>
                            {$m.annotation_edition|utf8_encode}</div>
                            {/if}
                            <div class="italic font-min" style="float:right">{$comptes[$m.idCompte].citationpreferee|utf8_encode}</div>
                        </td>
                    </tr>

                  {/foreach}
                  </table>
                
                  <div style="float:left;width:827px;height:50px;">
                    {if $sujet.bloque==0}
                        <div style="float:left;margin-top:17px;">
                            <a href="{$url_reponse}" class="bouton-forum"><span class="rouge bold">R&eacute;pondre</span></a>
                        </div>
                    {/if}

                    {if ($login.nom_f == 'superadmin' || ($login.nom_f == 'admin' && ($sujet.nom=='joueur' || $sujet.nom=='admin')) || ($login.idCompte == $sujet.idCompte)) && $sujet.bloque==0}
                        <div style="float:right;margin-top:17px;">
                            <a href="{$url_cloture_sujet}{$sujet.idSujet}&a=1" class="bouton-forum" onclick="return(confirm('Etes-vous sur de vouloir cloturer ce sujet ?'));"><span class="rouge bold">Cloturer</span></a>
                        </div>
                    {elseif $login.nom_f == 'superadmin' &&  $sujet.bloque==1}
                        <div style="float:right;margin-top:17px;">
                            <a href="{$url_cloture_sujet}{$sujet.idSujet}&a=0" class="bouton-forum" onclick="return(confirm('Etes-vous sur de vouloir ouvrir ce sujet ?'));"><span class="rouge bold">Ouvrir</span></a>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>

