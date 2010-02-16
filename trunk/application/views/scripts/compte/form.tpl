{literal}
<script type="text/javascript">
$(document).ready(function() {
	$('#datenaissance').datepicker({
			format:'dd/mm/Y',
			date: $('#datedeb').val(),
			current: $('#datedeb').val(),
			numberOfMonths: 3,
			showButtonPanel: true,
			changeMonth: true,
			changeYear: true,
			starts: 1,
			position: 'right',
			onBeforeShow: function(){
				$('#datedeb').DatePickerSetDate($('#datedeb').val(), true);
			},
			onChange: function(formated, dates){
				$('#datedeb').val(formated);
				$('#datedeb').DatePickerHide();
			}
	});	
}); 
</script>
{/literal}

<div id="content-left">
    <div class="content-princ">
        <div class="content-left-top"></div>
        <div class="content-left-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-left"><h3>Modifier mon profil</h3></div>
            <div class="content-title-right"></div>
            <div class="content-left-text">
            	<br /><center><span class="rouge italic">Les informations en rouge sont obligatoires</span></center><br /><br />
                {$form}
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
                <center><img src="{$base_url}/images/comptes/{$img}" /></center>
                <center><span class="italic"><a href="{$base_url}/compte/delavatar" onclick="return(confirm('Etes-vous sur de vouloir supprimer votre avatar ?'));">Supprimer mon avatar</a></span></center>
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
    <div class="content-princ content-separator">
        <div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Modifier mon mot de passe</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
                {$formmdp}
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
    <div class="content-princ content-separator">
        <div class="content-right-top"></div>
        <div class="content-right-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-right"><h3>Mes Lans</h3></div>
            <div class="content-title-right"></div>
            <div class="content-right-text">
                <ul>
                    <li> <a href="{$base_url}/compte/viewinscriptions">Voir mes inscriptions</a> </li>
                    <li> Cotisations </li>
                </ul>
            </div>
        </div>
        <div class="content-right-bottom"></div>
    </div>
</div>



