<div id="content-total">
    {foreach from=$lans item=l name=lan}
    <div class="content-princ-total">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$l.nom}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            	<strong><img src="{$base_url}/images/icones/icon-city.png" alt="Lieu" title="Lieu" style="vertical-align:middle" /> &nbsp;Lieux &nbsp;:</strong>&nbsp; {$l.adresse}<br />
                <strong><img src="{$base_url}/images/icones/icon-date.png" alt="Date debut" title="Date debut" style="vertical-align:middle" /> &nbsp;Date de d&eacute;but &nbsp;:</strong>&nbsp; Le {$l.datedeb|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$l.datedeb|date_format:"%H:%M"}<br />
                <strong><img src="{$base_url}/images/icones/icon-date.png" alt="Date fin" title="Date fin" style="vertical-align:middle" /> &nbsp;Date de fin &nbsp;:</strong>&nbsp; Le {$l.datefin|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$l.datefin|date_format:"%H:%M"}
                <br /><br />
                <strong><img src="{$base_url}/images/icones/icon-user.png" alt="Inscrits" title="Inscrits" style="vertical-align:middle" /> &nbsp;{$chiffre[$l.idLan].insc}</strong> Inscrits<br />
                <strong><img src="{$base_url}/images/icones/icon-user.png" alt="Presents" title="Presents" style="vertical-align:middle" /> &nbsp;{$chiffre[$l.idLan].present}</strong> Pr&eacute;sents<br /><br />
                
                {$l.description|nl2br}
                <br/><br/>
    
                <strong><img src="{$base_url}/images/icones/icon-games.png" alt="Jeux" title="Jeux" style="vertical-align:middle" /> &nbsp;Liste des jeux :</strong> 
                <ul>
                {foreach from=$jeux[$l.idLan] item=j name=jeu}
                    <li>{$j.nom}</li>
                {/foreach}
                </ul>
                <br/><br/>
                {$l.extra|nl2br}
                
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
    {/foreach}
</div>
