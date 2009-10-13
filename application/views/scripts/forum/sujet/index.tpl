<div id="content-total">
	<div class="content-total-princ">
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
                    {$comptes[$m.idCompte].nom}<br/>
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

