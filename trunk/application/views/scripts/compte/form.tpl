{literal}
<script type="text/javascript">
$(document).ready(function() {
	$('#datenaissance').datepicker({
			format:'dd/mm/Y',
			date: $('#datedeb').val(),
			current: $('#datedeb').val(),
			numberOfMonths: 3,
			showButtonPanel: true,
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


<h2>{$title}</h2>

{$formmdp}

{$form}