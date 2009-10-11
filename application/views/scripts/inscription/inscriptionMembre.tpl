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
            <div class="content-title-middle content-title-middle-total"><h3>{$titre}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-total-text">
            	<br/>
                {if $login_existant==1}
                <br/>
                	<span class="rouge"> Erreur : <ul>
                	<li>Le login choisit existe d&eacute;j&agrave; !!!</li></ul></span>
                    <br/><br/>
                {/if}
            	
               {$form}   
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>



