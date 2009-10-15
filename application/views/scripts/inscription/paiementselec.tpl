<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Pré-inscription</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <br />
                Votre pré-inscription pour la lan {$lan.nom|utf8_encode} est termin&eacute;e.
                <br /><br />
				{if $idp == 1}
                	Nous vous remercions pour votre paiement par ch&eacute;que. Un administrateur validera votre inscription des la r&eacute;ception de votre paiement.
                {elseif $idp == 2}
                    Nous vous remercions pour votre paiement via paypal. Un administrateur validera votre inscription des la r&eacute;ception de votre paiement.
                {/if}
                <br /><br />
                Au bientôt pour l'&eacute;v&eacute;nement ;) !
                 <br /><br />
                <a href="{$base_url}"><span class="bold italic">Revenir &agrave; l'accueil</span></a>
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>
