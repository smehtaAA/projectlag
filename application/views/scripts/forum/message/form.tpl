<div id="content-total">
	<div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$title}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
          {$form}
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    <div class="content-total-princ content-separator">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Messages du sujet {$sujet.titre|utf8_encode|Capitalize}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
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
                    
                    <br/>
                    <hr />
            		{$m.description|nl2br|utf8_encode} <br /> <br />
                    <hr />
                    <div class="italic font-min" style="float:right">{$comptes[$m.idCompte].citationpreferee|utf8_encode}</div>
                </td>
            </tr>
            
          {/foreach}
          </table>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>

