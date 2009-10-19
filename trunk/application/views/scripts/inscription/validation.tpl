<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>Inscription enregistr&eacute;e</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            {if $valid==0}
            	<br />
                Votre inscription a bien &eacute;t&eacute; prise en compte !
                <br /><br />
                Vous recevrez un <strong>email</strong> dans les 24h maximum afin de <strong>confirmer la cr&eacute;ation de votre compte</strong>.
                <br /><br />
				&nbsp;&nbsp;<img src="{$base_url}/images/icones/icon-warning.png" alt="Attention" title="Attention" style="vertical-align:middle;" /> <em>V&eacute;rifier le dossier spams ou courriers ind&eacute;sirables de vote bo&icirc;te mail.</em>
				<br /><br />
                Une fois votre compte confirm&eacute;, vous pourrez vous <strong>inscrire aux lans</strong> et participez &agrave; la vie du site et de son forum.
                <br /><br /><br />
                <a href="http://www.asso-lag.fr"><strong><em>Revenir &agrave; la page d'accueil</em></strong></a>
            {else}
				<br />
            	Votre compte vient d'&ecirc;tre valid&eacute;.
                <br /><br />
                Vous avez la possibilit&eacute; de vous connecter afin de vous inscrire aux lans et participez &agrave; la vie du site et de son forum.
				<br /><br /><br />
                <a href="http://www.asso-lag.fr"><strong><em>Revenir &agrave; la page d'accueil</em></strong></a>
            {/if}
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>