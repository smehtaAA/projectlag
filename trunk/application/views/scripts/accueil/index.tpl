{literal}
<script type="text/javascript">
$(document).ready(function() {
	$('.img-spec').mouseover(function () { 
	 switch (this.name)
	 {
		 case '1': 
			$("#info_1").attr("style",""); $("#com_info_1").attr("style","");
			$("#info_2").attr("style","display:none;"); $("#com_info_2").attr("style","display:none;");
			$("#info_3").attr("style","display:none;");  $("#com_info_3").attr("style","display:none;");
			break;
		case '2': 
			$("#info_2").attr("style",""); $("#com_info_2").attr("style","");
			$("#info_1").attr("style","display:none;");  $("#com_info_1").attr("style","display:none;");
			$("#info_3").attr("style","display:none;");  $("#com_info_3").attr("style","display:none;");
			break;
		case '3': 
			$("#info_3").attr("style",""); $("#com_info_3").attr("style","");
			$("#info_2").attr("style","display:none;");  $("#com_info_2").attr("style","display:none;");
			$("#info_1").attr("style","display:none;");  $("#com_info_1").attr("style","display:none;");
			break;
	 }
    });			   
}); 
</script>
{/literal}

<div id="content-left">
<div class="content-princ">
	<div class="content-left-top"></div>
    <div class="content-left-middle">
    	<div class="content-left-text">
        	<div style="float:left;width: 80px;padding-left:10px;">
            	{foreach from=$infos item=info name=in}
        			<img src="{$base_url}/images/info/thumb/{$info.img}" class="img-spec" name="{$smarty.foreach.in.iteration}" style="cursor:pointer;" alt="{$info.titre|utf8_encode}" title="{$info.titre|utf8_encode}" />
                    {if $smarty.foreach.in.last == false}
                		<br /><br />
                    {/if}
                {/foreach}
            </div>
            <div style="float:right;">
            	{foreach from=$infos item=info name=info}
                {if $smarty.foreach.info.first}
                    <div id="com_info_{$smarty.foreach.info.iteration}" class="commentInfo">
                        {else}
                    <div id="com_info_{$smarty.foreach.info.iteration}" class="commentInfo" style="display:none;">

                        {/if}
                        <h4>{$info.titre|utf8_encode}</h4>
                        <br />
                        {$info.description|utf8_encode}
                    </div>
                    {if $smarty.foreach.info.first}
                        <div id="info_{$smarty.foreach.info.iteration}">
                    {else}
                        <div id="info_{$smarty.foreach.info.iteration}" style="display:none;">
                    {/if}
                    <img src="{$base_url}/images/info/{$info.img}" class="img-spec" style="float:left;" id="image_info" alt="{$info.titre|utf8_encode}" title="{$info.titre|utf8_encode}" />
                    
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
    <div class="content-left-bottom"></div>
</div>

{foreach from=$news item=new name=new}
    <div class="content-princ content-separator">
    	<div class="content-left-top"></div>
        <div class="content-left-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-left"><h3>{$new.titre|utf8_encode}</h3><div class="right italic">{$new.date|date_format:"%A %e %B %Y"|capitalize}</div></div>
            <div class="content-title-right"></div>
            <div class="content-left-text">
            	{if $new.img}
                	<img src="{$base_url}/images/news/{$new.img}" align="right" style="float:right;" alt="{$new.titre|utf8_encode}" title="{$new.titre|utf8_encode}" />
                {/if}
                {$new.description|nl2br|utf8_encode}
                <hr />
                <span class="tag">Tag : {$new.type_n|utf8_encode}</span>
            </div>
        </div>
        <div class="content-left-bottom"></div>
    </div>
{/foreach}

    <div class="content-princ content-separator">
        <center>
            Pages - 
            {foreach from=$pages item=page name=paget}
               [<a href='{$url}{$page}'>{$page}</a>] 
            {/foreach}
            <br /><br /><br />
        </center>
    </div>
</div>
<div id="content-right">
   
    {if $lan != -1}
    <div class="content-princ">
    	<div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Info Prochaine Lan</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
            	<table>
                    <tr>
                    	<td width="20"><img src="{$base_url}/images/icones/icon-network.png" alt="Nom" title="Nom" /> </td>
                    	<td><strong>Nom</strong></td>
                        <td>&nbsp;:&nbsp;</td>
                        <td>{$lan.nom|utf8_encode}</td>
                    </tr>
                    <tr>
                    	<td><img src="{$base_url}/images/icones/icon-date.png" alt="Date" title="Date" /> </td>
                    	<td><strong>Date</strong></td>
                        <td>&nbsp;:&nbsp;</td>
                        <td>{$lan.datedeb|date_format:"%d.%m.%Y"} au {$lan.datefin|date_format:"%d.%m.%Y"}</td>
                    </tr>
                    <tr>
                    	<td><img src="{$base_url}/images/icones/icon-city.png" alt="Lieu" title="Lieu" /> </td>
                    	<td><strong>Lieu</strong></td>
                        <td>&nbsp;:&nbsp;</td>
                        <td>{$lan.adresse|utf8_encode}</td>
                    </tr>
                    <tr>
                    	<td colspan="3"></td>
                        <td> {$lan.ville|utf8_encode} ({$lan.cp|utf8_encode}) </td>
                    </tr>
                    <tr>
                    	<td colspan="4" height="20"></td>
                    </tr>
                    <tr>
                    	<td><img src="{$base_url}/images/icones/icon-user.png" alt="Pre-inscrits" title="Pre-inscrits" /> </td>
                    	<td colspan="3"><a href="{$base_url}/lan/viewinscrits?id={$lan.idLan}"><strong>{$lan.nb_preinscrits}</strong> Pr&eacute;-inscrits</a></td>
                    </tr>
                    <tr>
                    	<td><img src="{$base_url}/images/icones/icon-user.png" alt="Inscrits" title="Inscrits" /> </td>
                    	<td colspan="3"><a href="{$base_url}/lan/viewinscrits?id={$lan.idLan}"><strong>{$lan.nb_inscrits}</strong> Inscrits</a></td>
                    </tr>
                </table>
                <br /><br />
                <a href="{$base_url}/lan/"><span class="rouge"><em>Plus d'informations...</em></span></a>
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
	{/if}
    
    {if $lan != -1}
    	<div class="content-right-princ content-separator">
    {else}
    	<div class="content-right-princ">
    {/if}
        <div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Newsletter</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
                <form method="post" action="{$base_url}/newslettermail/ajoutmail">
                    <table border="0">
                        <tr>
                            <td valign="middle">Email</td>
                            <td valign="middle"> : </td>
                            <td valign="middle"> <input type="text" name="mail" /> <input type="submit" value="ok" class="button" /></td>
                        </tr>
                    </table>
                </form>		
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
    
    <div class="content-right-princ content-separator">
        <div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Partenaire al&eacute;atoire</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
    			<center><a href="{$partenaire[0].lien}" target="_blank"><img src="{$base_url}/images/partenaires/{$partenaire[0].logo}" title="{$partenaire[0].titre|utf8_encode}" alt="{$partenaire[0].titre|utf8_encode}" /></a></center>
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
    
    <div class="content-right-princ content-separator">
        <div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>News Partenaire</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
    			{foreach from=$newsp item=np name=np}
                	<span class="rouge"><strong>{$partenaires[$np.idPartenaire]} : {$np.titre|utf8_encode}</strong></span> <br/> <br/>
                    {$np.description|utf8_encode|truncate:200:'..'} <br/> <br/>
                    <a href="{$base_url}/news/index?id={$np.idNews}"><span class="rouge"><em>Voir la suite ...</em></span></a>
                    <hr />
                    {if $smarty.foreach.np.last}
                    	<a href="{$base_url}/news/indexpartenaire"><span class="rouge"><strong><em>Voir l'ensemble des news partenaires</em></strong></span></a>
                    {/if}
                {/foreach}
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
</div>

    <div id="content-total">
     <div class="content-total-princ content-separator">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Partenaires</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <center>
                {foreach from=$logos item=logo name=logo}
                    <a href="{$logo.lien}" target="_blank"><img src="{$base_url}/images/partenaires/{$logo.logo}" alt="{$logo.titre|utf8_encode}" title="{$logo.titre|utf8_encode}" style="margin-right:50px;vertical-align:middle;" /></a>
                {/foreach}
                </center>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    </div>