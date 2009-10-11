<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Pré-inscription</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                Votre pré-inscription pour la lan {$lan.nom} a bien &eacute;t&eacute; enregistr&eacute;.<br/>

                Afin de terminer votre inscription, il vous est demandé de nous faire parvenir par chèque ou PayPal un règlement équivalant au tarif de la LAN soit
                {if $lan.telethon == true}
                <strong>un minimum de</strong>
                {/if}
                <strong>{$lan.prix_prepaiement} &euro;</strong>
                {if $lan.telethon == true}
                	par chèque ou <strong>{$lan.prix_prepaiement_paypal} &euro; par PayPal</strong> (dans le but de compenser le fee)</strong>
                {/if}
                <br/>
                {if $lan.telethon == true}
                <br/>
                	<strong>Nous rappelons que l'ensemble des entrées sera reversé &agrave; l'AFM T&eacute;l&eacute;thon.</strong>
                <br/>
                {/if}
                <br/>
                <ul>
                    <li><span class="rouge"><strong> Par Ch&egrave;que </strong> </span></li>
                    <ul>
                      <li> Il vous suffit de nous faire parvenir un ch&egrave;que au montant minimum de <strong>{$lan.prix_prepaiement} &euro;</strong> &agrave; l'ordre de 
                      {if $lan.telethon == true}
                        <strong>AFM Telethon</strong>
                      {else}
                      	<strong> LAG </strong>
                     {/if}
                     &agrave; l'adresse suivante :</li>
                      <ul>
                        <li> LAG <br/>
                            39 rue de la gare <br/>
                            02220 Mont Notre Dame
                      </ul>
                    </ul>
                    <br/>
                    <li><span class="rouge"><strong> Par PayPal</strong> </span></li>
                    <ul>
                      <li> Il vous suffit de choisir le montant de votre don. Il est not&eacute; que le montant minimum est de <strong>{$lan.prix_prepaiement_paypal} &euro; </strong>.<br/>
                     <form action="https://www.paypal.com/fr/cgi-bin/webscr" method="post" name="f">
                        <input type="hidden" name="cmd" value="_ext-enter" />
                        <input type="hidden" name="redirect_cmd" value="_xclick" />
                        <input type="hidden" name="business" value="association.lag@gmail.com" />
                        <input type="hidden" name="item_name" value="Association LAG - {$lan.nom|utf8_encode}" />
                        <input type="hidden" name="currency_code" value="EUR" />
                        Prix : <input type="text" name="amount" align="right" value="{$lan.prix_prepaiement_paypal}" size="5" style="width:20px;" /> &euro;
                        <input type="hidden" name="email" value="{$compte.email}" />
                        <input type="hidden" name="first_name" value="{$compte.prenom}" />
                        <input type="hidden" name="last_name" value="{$compte.nom}" />
                        <input type="hidden" name="address1" value="" />
                        <input type="hidden" name="city" value="" />
                        <input type="hidden" name="state" value="FR" />
                        <input type="hidden" name="zip" value="" />
                        <input type="hidden" name="H_PhoneNumber" value="{$compte.phone}" />
                        <br /><br />
                        <input type="image" src="https://www.paypal.com/fr_FR/FR/i/btn/btn_paynowCC_LG.gif" border="0" name="submit" alt="PayPal - la solution de paiement en ligne la plus simple et la plus sécurisée !" onclick="document.forms.f.submit()" class="paypal" />
					 </form>
                     </li>
                     </ul>
                     <br/>
                    <li> <span class="rouge"><strong>Sur Place</strong> </span> </li>
                    <ul>
                      <li> Il vous est possible de payer directement sur place mais dans ce cas là, le tarif sera supérieur.</li>
                      <li> Un tarif de <strong> {$lan.prix} &euro;</strong> sera appliqué pour toutes inscriptions sur place. </li>
                      
                      </ul>
                    </ul>
                    <br/> <br/>
                    
                    Si vous choisissez le mode de paiement par ch&egrave;que ou par PayPal, vous recevrez un email d&egrave;s r&eacute;ception du paiement et votre inscription sera alors effective.
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>





