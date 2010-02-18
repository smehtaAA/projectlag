{literal}
<script type="text/javascript">
$(document).ready(function() {
	$('#datenaissance').datepicker({
			format:'dd/mm/Y',
			date: $('#datenaissance').val(),
			current: $('#datenaissance').val(),
			showButtonPanel: true,
			changeMonth: true,
			changeYear: true,
			starts: 1,
			position: 'right',
			onBeforeShow: function(){
				$('#datenaissance').DatePickerSetDate($('#datenaissance').val(), true);
			},
			onChange: function(formated, dates){
				$('#datenaissance').val(formated);
				$('#datenaissance').DatePickerHide();
			}
	});	
}); 
</script>
{/literal}


<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$titre|utf8_encode}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
                <br/>
                    <center> <strong> Important : </strong> L'inscription sur le site permet &eacute;galement l'inscription aupr&egrave;s
                    des diff&eacute;rents &eacute;v&egrave;nements organis&eacute;s par l'association. </center>

            	<br/>
				<center>
                    <span class="bold">Attention :</span> Il est important d'indiquer un <strong>email valide</strong> pour confirmer son inscription au site.<br/>
                                <div style="margin-left:60px;">Les champs en <span class="rouge bold">rouge</span> sont obligatoires.</div>
                </center>
            	<br/><br/><br/>
                {if $login_existant==1}
                    <br/>
                	<span class="rouge"> Erreur : <ul>
                	<li>Le login choisit existe d&eacute;j&agrave; !!!</li></ul></span>
                    <br/><br/>
                {/if}
            	
                <div class="form-inscription">
                    {$form} 
                </div>  
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>



