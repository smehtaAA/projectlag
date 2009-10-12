{literal}
	<script type="text/javascript">
		function verif_clan()
		{
			if (document.getElementById('team').value == "0") {
				document.getElementById('hide_new_team').style.display = "";
				document.getElementById('hide_new_team').className="";
			}else {
				document.getElementById('hide_new_team').style.display = "none";
				document.getElementById('hide_new_team').className="default_display_none";
			}
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
            	<br/>
            
                Date de la lan : du <strong>{$lan.datedeb|date_format:"%A %e %B %Y a %H:%M"|capitalize|utf8_encode}</strong> au <strong>{$lan.datefin|date_format:"%A %e %B %Y a %H:%M"|capitalize|utf8_encode}</strong> <br/>
				Lieu : {$lan.adresse|nl2br|utf8_encode} &agrave; {$lan.ville|utf8_encode}<br/>
                
                
                <a href="http://maps.google.fr/maps?f=q&source=s_q&hl=fr&geocode=&q=Mont Notre Dame&sll=49.293001,3.584118&sspn=0.043159,0.087891&g=Mont+notre+dame+02220&ie=UTF8&hq=&hnear=Mont-Notre-Dame,+Aisne,+Picardie&ll=49.29468,3.609009&spn=0.690516,1.40625&z=10" target="_blank"> Lien Google </a> <br/>
                <br/>
                
                {$lan.extra|utf8_encode}
                <hr />
                
			<!-- Informations sur le joueur -->
            <span class="rouge"><h2> Informations sur {$joueur.login|utf8_encode} </h2></span>
                <br/>
                Login : {$joueur.login|utf8_encode} <br/>
                Email : {$joueur.email} <br/><br/>
                
                Si il y a une erreur dans votre email, veuillez la corriger dans le profil de votre compte <strong>avant</strong> de vous inscrire.
                <hr/>

			<!-- Informations sur l'inscription -->
            <span class="rouge"><h2> Votre inscription </h2></span>
            	<br/>
            	{if $tournoi}
            		Tournois Organisés :
                    <ul>
                    {foreach from=$jeux name=jeu item=jeu}
                    
                        <li>
                        {if $jeu.tournoi==true}
                            {$jeu.nom} ({$jeu.nbmaxjoueurparteam}vs{$jeu.nbmaxjoueurparteam})
                        {/if}
                        
                        </li>
                    
                    
                    {/foreach}
                {else}
                	Aucun tournoi (lan "Fun")
                {/if}
                
                </ul>
            
                <br/><br/><br/>
                
                {$form}
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>


