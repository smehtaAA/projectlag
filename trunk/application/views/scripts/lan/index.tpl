<div id="content-total">
    {foreach from=$lans item=l name=lan}
    <div class="content-princ-total">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><A href="#"><h3>{$l.nom}</h3></A></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <strong>Date de d&eacute;but &nbsp;:</strong>&nbsp; Le {$l.datedeb|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$l.datedeb|date_format:"%H:%M"}<br />
                <strong>Date de fin &nbsp;:</strong>&nbsp; Le {$l.datefin|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$l.datefin|date_format:"%H:%M"}<br /><br />
                <strong>Nombre d'inscrits &nbsp;:</strong>&nbsp; {$chiffre[$l.idLan].insc}<br />
                <strong>Nombre de pr&eacute;sents :</strong>&nbsp; {$chiffre[$l.idLan].present}<br /><br />
                
                {$l.description|nl2br}
                <br/><br/>
    
                <strong>Liste des jeux :</strong> 
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
