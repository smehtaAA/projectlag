<div id="content-left">
<div class="content-princ">
	<div class="content-left-top"></div>
    <div class="content-left-middle">
    	<div class="content-left-text">
        	<div style="float:left;width: 80px;padding-left:10px;">
        		<img src="{$base_url}/images/info/thumb/information_1.jpg" class="img-spec" />
                <br /><br />
                <img src="{$base_url}/images/info/thumb/information_2.jpg" class="img-spec" />
            </div>
            <div style="float:right;">
    			<img src="{$base_url}/images/info/information_1.jpg" align="right" class="img-spec" />
                <div style="float:left;padding-right:5px;position: absolute;width: 402px;background-color:#000000; height:45px;margin-left:25px;margin-top:150px;opacity:0.7; color: #FFFFFF;padding:15px;">
                	<h4>Local Arena Games</h4>
                    <br />
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque orci mauris, auctor sit amet placerat non, adipiscing ac lacus.
                </div>
            </div>
        </div>
    </div>
    <div class="content-left-bottom"></div>
</div>

{if $lan != -1}
    <div class="content-princ">
    	<div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Info Prochaine Lan</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
                Nom : {$lan.nom}<br />
                Date de d&eacute;but : {$lan.datedeb|date_format:"%d/%m/%Y a %H:%M"}<br />
                Lieux : {$lan.adresse}<br />
                Nb. inscrits : {$nb_inscrits}
                <br /><br />
                <a href="{$base_url}/lan/">Plus d'information...</a>
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
{/if}

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
</div>
<div id="content-right">
    <div class="content-right-princ">
        <div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Image al&eacute;atoire</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
    
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
    
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
</div>