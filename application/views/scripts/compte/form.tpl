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

<div id="content-total">
    <div class="content-total-princ">
        <div class="content-total-top"></div>
        <div class="content-total-middle">
            <div class="content-title-left"></div>
            <div class="content-title-middle content-title-middle-total"><h3>{$title}</h3></div>
            <div class="content-title-right"></div>
            <div class="content-left-text">
                {$formmdp}

				{$form}
            </div>
        </div>
        <div class="content-total-bottom"></div>
    </div>
</div>



