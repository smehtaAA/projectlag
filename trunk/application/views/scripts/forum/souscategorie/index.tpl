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
            		<li><a href="{$base_url}/forum">Forum</a> > <a href="{$base_url}/categorie?id={$fil_arianne.cat.id}">{$fil_arianne.cat.nom|utf8_encode}{if $fil_arianne.cat.admin==1} [Admin]{/if}</a> > <a href="{$base_url}/souscategorie?id={$fil_arianne.sscat.id}"><strong>{$fil_arianne.sscat.nom|utf8_encode}{if $fil_arianne.sscat.admin==1} [Admin]{/if}</strong></a> </li>
                </ul>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>


	<div class="content-total-princ content-separator">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$souscat.titre|utf8_encode}{if $souscat.admin==1} [Admin] {/if}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            <br/>
            {if $login.login!=''}
            	<a href="{$url_addsujet}" class="bouton-forum"><span class="rouge bold">Ajouter un Sujet</span> </a> <br/><br/><br/>
            {/if}
            <table border=1>
                <tr height="30" class="table-th">
                    <th width="40"></th>
                    <th width="450"> Forum </th>
                    <th width="65"> R&eacute;ponses </th>
                    <th width="65"> Vu </th>
                    <th width="200" > Dernier message </th>
                </tr>
            
            	{foreach from=$sujets item=s name=sujet}
            		{if $smarty.foreach.sujet.index%2}
                    <tr height="40" class="td-paire">
                    {else}
                    <tr height="40" class="td-impaire">
                    {/if}
                        <td style="vertical-align:bottom;">
							{if $lecture[$s.idSujet] == 1}
								<img src="images/icones/icon-forum-gris.png" />
							{else}
								<img src="images/icones/icon-forum.png" />
							{/if}
						</td>
						<td><a href="{$url_viewsujet}{$s.idSujet}"><span class="rouge"><strong>{$s.titre|utf8_encode}</strong></span></a></td>
                        <td align="center">{$nb[$s.idSujet].reponses}</td>
                        <td align="center">{$s.vu}</td>
                        <td>
                        	{if $last_messages[$s.idSujet] == -1} 
                            	<em>Aucun Message </em>
                            {else}
                                <span class="font-min">{$last_messages[$s.idSujet].date_m|date_format:"%d/%m/%Y à %H:%M"|utf8_encode} 
                                par <span class="rouge">{$last_messages[$s.idSujet].login}</span></span>
                            {/if}
                        </td>
                    </tr>
            	{/foreach}
            </table>
            <br /><br />
            {if $login.login!=''}
            	<a href="{$url_addsujet}" class="bouton-forum"><span class="rouge"><strong> Ajouter un Sujet </strong></span> </a>
            {/if}
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>