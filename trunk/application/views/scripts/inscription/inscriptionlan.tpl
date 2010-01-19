{literal}
	<script type="text/javascript">
		function verif_clan()
		{
			if ($('#team').val() == "0")		
				$('.cacheme').attr('class','cacheme');
			else			
				$('.cacheme').attr('class','cacheme default_display_none');
		}
	</script>
{/literal}

<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Inscription &agrave; la lan {$lan.nom|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            
            <!-- Informations sur la lan -->
            <span class="rouge"><h2> Informations sur {$lan.nom|utf8_encode} </h2></span>
            	<br /><br />
            
                <img src="{$base_url}/images/icones/icon-date.png" alt="Date" title="Date" style="vertical-align:middle;margin-bottom:3px;" /> &nbsp;<strong>Date</strong> : {$lan.datedeb|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$lan.datedeb|date_format:"%H:%M"|capitalize|utf8_encode} au {$lan.datefin|date_format:"%A %e %B %Y"|capitalize|utf8_encode} &agrave; {$lan.datefin|date_format:"%H:%M"|capitalize|utf8_encode} <br/>
				<img src="{$base_url}/images/icones/icon-city.png" alt="Lieu" title="Lieu" style="vertical-align:middle;margin-bottom:3px;" /> &nbsp;<strong>Lieu</strong> : {$lan.adresse|nl2br|utf8_encode} &agrave; {$lan.ville|utf8_encode} ({$lan.cp|utf8_encode})<br/>
                
                
                <img src="{$base_url}/images/icones/icon-google.png" alt="Google" title="Google" style="vertical-align:middle;" /> &nbsp;<strong>Plan</strong> : <a href="http://maps.google.fr/maps?f=q&source=s_q&hl=fr&geocode=&q=Mont Notre Dame&sll=49.293001,3.584118&sspn=0.043159,0.087891&g=Mont+notre+dame+02220&ie=UTF8&hq=&hnear=Mont-Notre-Dame,+Aisne,+Picardie&ll=49.29468,3.609009&spn=0.690516,1.40625&z=10" target="_blank"> Lien Google </a> <br/>
                <br/>
                
                {$lan.extra|utf8_encode}
                <hr />
				
			<!-- Materiels a ramener -->
			
				<span class="rouge"><h2> Mat&eacute;riels &agrave; ramener par le joueur </h2></span>
				<br/>
				
				<ul>
					<li> Ordinateur (Unit&eacute; centrale, &eacute;cran, clavier ...) </li>
					<li> Casque obligatoire (les enceintes sont interdites) </li>
					<li> C&acirc;ble r&eacute;seaux de 5m minimum </li>
					<li> Multi-prise &eacute;lectrique </li>
				</ul>

				Un joueur ne poss&egrave;dant pas ce mat&eacute;riel minimum peut se voir refuser l'acc&eacute; &agrave; la salle.
				<br />
                <hr />
			<!-- Informations sur le joueur -->
            <span class="rouge"><h2> Informations sur votre compte </h2></span>
                <br /><br />
                <img src="{$base_url}/images/icones/icon-user2.png" alt="Login" title="Login" style="vertical-align:middle;margin-bottom:3px;" /> &nbsp;<strong>Login :</strong> {$joueur.login|utf8_encode} <br/>
                <img src="{$base_url}/images/icones/icon-contact.png" alt="Mail" title="Mail" style="vertical-align:middle;margin-bottom:3px;" /> &nbsp;<strong>Email :</strong> {$joueur.email} <br/><br/>
                
                Si il y a une erreur dans votre email, veuillez la corriger dans le profil de votre compte <strong>avant</strong> de vous inscrire.
                <hr/>

			<!-- Informations sur l'inscription -->
            <span class="rouge"><h2> Votre inscription </h2></span>
            	<br /><br />
                <div class="form-inscription2">
                	<center>
                    {if $tournoi}
                        <strong>Tournois Organis&eacute;s :</strong>
                        <ul>
                        {foreach from=$jeux name=jeu item=jeu}
                        
                            <li>
                            {if $jeu.tournoi==true}
                                {$jeu.nom} ({$jeu.nbmaxjoueurparteam}vs{$jeu.nbmaxjoueurparteam})
                            {/if}
                            
                            </li>
                        
                        
                        {/foreach}
                        </ul>
                    {else}
                        <strong>Aucun tournoi (lan "Fun")</strong>
                    {/if}
                    </center>
                    
                
                    <br/><br/><br/>
                
                    {$form}
                </div>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>


