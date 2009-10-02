<h2> Pré-inscription </h2>

Votre pré-inscription pour la lan {$lan.nom} a bien &eacute;t&eacute; enregistr&eacute;.<br/>

Afin de terminer votre inscription, il vous est demandé de nous faire parvenir par chèque ou PayPal un règlement équivalant au tarif de la LAN soit
{if $lan.telethon == true}
<strong>un minimum de</strong>
{/if}
<strong>{$lan.prix_prepaiement} &euro;</strong>
<br/>
<ul>
	<li> Par Ch&egrave;que </li>
    <ul>
      <li> Il vous suffit de nous faire parvenir un ch&egrave;que &agrave; l'ordre de "LAG" &agrave; l'adresse suivante :</li>
      <ul>
      	<li> LAG <br/>
        	39 rue de la gare <br/>
            02220 Mont Notre Dame
      </ul>
    </ul>
    
    <li> Par PayPal </li>
    <ul>
      <li> En cliquant simplement sur ce bouton <br/>
     <form action="https://www.paypal.com/fr/cgi-bin/webscr" method="post" name="f">
<input type="hidden" name="cmd" value="_ext-enter">
<input type="hidden" name="redirect_cmd" value="_xclick">
<input type="hidden" name="business" value="association.lag@gmail.com">
<input type="hidden" name="item_name" value="Association LAG - {$lan.nom}">
<input type="hidden" name="currency_code" value="EUR">
<input type="text" name="amount" value="">
<input type="hidden" name="email" value="{$compte.email}">
<input type="hidden" name="first_name" value="{$compte.prenom}">
<input type="hidden" name="last_name" value="{$compte.nom}">
<input type="hidden" name="address1" value="">
<input type="hidden" name="city" value="">
<input type="hidden" name="state" value="FR">
<input type="hidden" name="zip" value="">
<input type="hidden" name="H_PhoneNumber" value="{$compte.phone}">

<input type="image" src="https://www.paypal.com/fr_FR/FR/i/btn/btn_paynowCC_LG.gif" border="0" name="submit" alt="PayPal - la solution de paiement en ligne la plus simple et la plus sécurisée !" onclick="document.forms.f.submit()">

 </li>
    </ul>
</ul>
