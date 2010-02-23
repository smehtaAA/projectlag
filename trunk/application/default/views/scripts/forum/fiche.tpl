<div id="content-left">
    <div class="content-princ">
        <div class="content-left-top"></div>
        <div class="content-left-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-left"><h3>{$datas.login}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-left-text">
            	<strong>Pr&eacute;nom :</strong> {$datas.prenom|utf8_encode} <br/>
            	<strong>Ville :</strong> {$datas.ville|utf8_encode} <br/>
            	{if $datas.site|utf8_encode != ""}
            		<strong>Site :</strong> {$datas.site|utf8_encode} <br/>
            	{/if}
            	<strong>Citation pr&eacute;f&eacute;r&eacute;e :</strong> {$datas.citationpreferee|utf8_encode} <br/>
            	<strong>Description : </strong>{$datas.description|utf8_encode|nl2br} <br/>
            	
            	<br/>
            	<strong>Nombre de messages :</strong> {$nb} <br/>
            	<strong>Dernier message : </strong> <a href="{$base_url}/sujet?id={$last.idSujet}">{$last.titre|utf8_encode} - {$last.date_m|date_format:"%d/%m/%Y"}</a>
            </div>
        </div>
        <div class="content-left-bottom"></div>
    </div>
</div>

<div id="content-right">
    <div class="content-princ">
        <div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Informations</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
                <center><img src="{$base_url}/images/comptes/{$datas.img}" /></center>
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
    
</div>