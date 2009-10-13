<div id="content-total">
	<div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Info Forum</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            	<a href="{$base_url}/forum"> Forum </a> > <a href="{$base_url}/categorie?id={$fil_arianne.cat.id}"> {$fil_arianne.cat.nom|utf8_encode}</a> > <a href="{$base_url}/souscategorie?id={$fil_arianne.sscat.id}"> <strong>{$fil_arianne.sscat.nom|utf8_encode}</strong></a>  <br/><br/>
                
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
            <div class="content-title-middle content-title-middle-total"><h3>{$souscat.titre|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            <br/>
            {if $login.login!=''}
            	<a href="{$url_addsujet}"><span class="rouge"><strong> Ajouter un Sujet </strong></span> </a> <br/><br/>
            {/if}
            <table border=1>
            <tr height="35px" bgcolor="#555555">
            	<th width="450px"> Forum </th>
                <th width="75px"> R&eacute;ponses </th>
                <th width="75px"> Vu </th>
                <th width="240px" > Dernier message </th>
            </tr>
            
            	{foreach from=$sujets item=s name=sujet}
            		<tr height="40px">
                    	<td><a href="{$url_viewsujet}{$s.idSujet}"><span class="rouge"><strong>{$s.titre|utf8_encode}</strong></span></a></td>
                        <td align="center">{$nb[$s.idSujet].reponses}</td>
                        <td align="center">{$s.vu}</td>
                        <td>
                        	{if $last_messages[$s.idSujet] == -1} 
                            	Aucun Message 
                            {else}
                                {$last_messages[$s.idSujet].date_m|date_format:"%d/%m/%Y à %H:%M"|utf8_encode} par <span class="rouge">{$last_messages[$s.idSujet].login}</span>
                            {/if}
                        </td>
                    </tr>
            	{/foreach}
            </table>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>