<div id="content-total">
	<div class="content-princ-total">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$souscat.titre|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            <br/>
            {if $login==1}
            	Bienvenue <br/>
            	<a href="{$url_addsujet}"><span class="rouge"><strong> Ajouter un Sujet </strong></span> </a> <br/><br/>
            {else}
            	Bienvenue, Invit&eacute; <br/>
				Merci de vous identifier ou de vous inscrire. <br/><br/>
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
                        <td align="center"></td>
                        <td align="center"></td>
                        <td></td>
                    </tr>
            	{/foreach}
            </table>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>