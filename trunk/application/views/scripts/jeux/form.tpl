{literal}
<script type="text/javascript">
$(document).ready(function() {
	$('#datesortie').datepicker({
			format:'dd/mm/Y',
			date: $('#datesortie').val(),
			current: $('#datesortie').val(),
			showButtonPanel: true,
			changeMonth: true,
			changeYear: true,
			starts: 1,
			position: 'right',
			onBeforeShow: function(){
				$('#datesortie').DatePickerSetDate($('#datesortie').val(), true);
			},
			onChange: function(formated, dates){
				$('#datesortie').val(formated);
				$('#datesortie').DatePickerHide();
			}
	});	
}); 
</script>
{/literal}

<h2>{$title}</h2>

{$form}