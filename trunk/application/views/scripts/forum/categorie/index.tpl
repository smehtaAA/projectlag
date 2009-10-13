<div id="content-total">
	<div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Info Forum</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            	<a href="{$base_url}/forum"> Forum </a> > <a href="{$base_url}/categorie?id={$fil_arianne.cat.id}"> {$fil_arianne.cat.nom|utf8_encode}</a>
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
            {if $login.login!=''}
            	Bienvenue, <span class="rouge"><em>{$login.login|utf8_encode}</em></span> <br/><br/>
            {else}
            	Bienvenue, <span class="rouge"><em>Invit&eacute;</em></span> <br/>
				Merci de vous identifier ou de vous inscrire. <br/><br/>
            {/if}
            
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
                                <span class="rouge"><strong>{$last_messages[$sc.idSousCategorie].titre}</strong></span><br/>
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
</div>