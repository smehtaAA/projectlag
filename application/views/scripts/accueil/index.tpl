{literal}
<script type="text/javascript">
$(document).ready(function() {
	$('.img-spec').click(function () { 
     alert('test'+this.name);
	 switch (this.name)
	 {
		 case '1': 
			$("#info_1").attr("style","");
			$("#info_2").attr("style","display:none;");
			$("#info_3").attr("style","display:none;");
			break;
		case '2': 
			$("#info_2").attr("style","");
			$("#info_1").attr("style","display:none;");
			$("#info_3").attr("style","display:none;");
			break;
		case '3': 
			$("#info_3").attr("style","");
			$("#info_2").attr("style","display:none;");
			$("#info_1").attr("style","display:none;");
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
        			<img src="{$base_url}/images/info/thumb/{$info.img}" class="img-spec" name="{$smarty.foreach.in.iteration}" />
                    {if $smarty.foreach.in.last == false}
                		<br /><br />
                    {/if}
                {/foreach}
            </div>
            <div style="float:right;">
            	{foreach from=$infos item=info name=info}
                    {if $smarty.foreach.info.first}
                        <div id="info_{$smarty.foreach.info.iteration}">
                    {else}
                        <div id="info_{$smarty.foreach.info.iteration}" style="display:none;">
                    {/if}
                    <img src="{$base_url}/images/info/{$info.img}" align="right" class="img-spec" id="image_info" />
                    <div style="float:left;padding-right:5px;position: absolute;width: 402px;background-color:#000000; height:45px;margin-left:25px;margin-top:150px;opacity:0.7; color: #FFFFFF;padding:15px;">
                        <h4>{$info.titre}</h4>
                        <br />
                        {$info.description}
                    </div>
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
            <div class="content-title-middle content-title-middle-left"><h3>{$new.titre}</h3><div class="right italic">{$new.date|date_format:"%A %e %B %Y"|capitalize}</div></div>
            <div class="content-title-right"></div>
            <div class="content-left-text">
            	{if $new.img}
                	<img src="{$base_url}/images/news/{$new.img}" align="right" alt="{$new.titre}" tittle="{$new.titre}" />
                {/if}
                {$new.description|nl2br}
                <hr />
                <span class="tag">Tag : {$new.type_n}</span>
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
    </center>
</div>
<br/><br/>

    <div class="content-princ-total content-separator">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Partenaires</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            <center>
                {foreach from=$logos item=logo name=logo}
                	
                    <img src="{$base_url}/images/partenaires/{$logo.logo}" alt="{$logo.titre}" name="{$logo.titre}" style="margin:10px" />
                
                {/foreach}
            </center>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>

</div>
<div id="content-right">
	{if $log_joueur == 1}
	<div class="content-right-princ">
        <div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Mon Menu</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
            		<ul>
						<li><a href="{$base_url}/compte/form">Mon Compte</a></li>
						<li><a href="{$base_url}/lan/indexjoueur">Mes Inscriptions</a></li>
						<!--<li><a href="<?= $this->url(array('controller' => 'forum', 'action' => 'indexjoueur'),'default', true) ?>">Mes messages</a></li>-->
						<li><a href="{$base_url}/log/deconnexion">Deconnexion</a></li>
					</ul>
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
	{/if}
    
    {if $lan != -1}
        {if $log_joueur == 1}
            <div class="content-princ content-separator">
        {else}
            <div class="content-princ">
        {/if}
    	<div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Info Prochaine Lan</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
                Nom : {$lan.nom}<br />
                Date de d&eacute;but : {$lan.datedeb|date_format:"%d/%m/%Y a %H:%M"}<br />
                Lieux : {$lan.adresse}<br />
                Nb. pr&eacute;-inscrits : {$nb_preinscrits}<br />
                Nb. inscrits : {$nb_inscrits}
                <br /><br />
                <a href="{$base_url}/lan/">Plus d'information...</a>
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
	{/if}
    
    <div class="content-right-princ content-separator">
        <div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Newsletter</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
                <form method="post" action="">
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
            <div class="content-title-middle content-title-middle-right"><h3>Partenaires</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
    			<center><img src="{$base_url}/images/partenaires/{$partenaire[0].logo}" name="{$partenaire[0].titre}" alt="{$partenaire[0].titre}" /></center>
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
                	<span class="rouge"><strong>{$partenaires[$np.idPartenaire]} : {$np.titre}</strong></span> <br/> <br/>
                    {$np.description|truncate:200:'..'} <br/> <br/>
                    <a href="{$base_url}/news/index?id={$np.idNews}"><span class="rouge">Voir la suite ...</span></a>
                    <hr />
                    {if $smarty.foreach.np.last}
                    	<a href="{$base_url}/news/indexpartenaire"><span class="rouge"><strong>Voir l'ensemble des news partenaires</strong></span></a>
                    {/if}
                {/foreach}
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
    
    

    
</div>