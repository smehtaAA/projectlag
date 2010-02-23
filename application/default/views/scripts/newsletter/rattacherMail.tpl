{literal}
	<style type="text/css">
			#mail_non_rattache { float: left; width: 65%; min-height: 12em; } * html #mail_non_rattache { height: 12em; } /* IE6 */
			.mail_non_rattache.custom-state-active { background: #eee; }
			.mail_non_rattache li { float: left; width: 96px; padding: 0.4em; margin: 0 0.4em 0.4em 0; text-align: center; }
			.mail_non_rattache li h5 { margin: 0 0 0.4em; cursor: move; }
			.mail_non_rattache li a { float: right; }
			.mail_non_rattache li a.ui-icon-zoomin { float: left; }
			.mail_non_rattache li img { width: 100%; cursor: move; }

			#mail_rattache { float: right; width: 32%; min-height: 18em; padding: 1%;} * html #mail_rattache { height: 18em; } /* IE6 */
			#mail_rattache h4 { line-height: 16px; margin: 0 0 0.4em; }
			#mail_rattache h4 .ui-icon { float: left; }
			#mail_rattache .mail_non_rattache h5 { display: none; }
		</style>
		<script type="text/javascript">
			
			$(function() {
				
				dragdrop();
				
				function dragdrop() {
				// there's the gallery and the trash
				var $mail_non_rattache = $('#mail_non_rattache'), $mail_rattache = $('#mail_rattache');
				
				
				// let the gallery items be draggable
				$('li',$mail_non_rattache).draggable({
					cancel: 'a.ui-icon',// clicking an icon won't initiate dragging
					revert: 'invalid', // when not dropped, the item will revert back to its initial position
					containment: $('#demo-frame').length ? '#demo-frame' : 'document', // stick to demo-frame if present
					helper: 'clone',
					cursor: 'move'
				});
				
				// let the trash items be draggable
				$('li',$mail_rattache).draggable({
					cancel: 'a.ui-icon',// clicking an icon won't initiate dragging
					revert: 'invalid', // when not dropped, the item will revert back to its initial position
					containment: $('#demo-frame').length ? '#demo-frame' : 'document', // stick to demo-frame if present
					helper: 'clone',
					cursor: 'move'
				});

				// let the trash be droppable, accepting the gallery items
				$mail_rattache.droppable({
					accept: '#mail_non_rattache > li',
					activeClass: 'ui-state-highlight',
					drop: function(ev, ui) {
						deleteImage(ui.draggable);
					}
				});

				// let the gallery be droppable as well, accepting items from the trash
				$mail_non_rattache.droppable({
					accept: '#mail_rattache li',
					activeClass: 'custom-state-active',
					drop: function(ev, ui) {
						recycleImage(ui.draggable);
					}
				});
				
				

				// image deletion function
				function deleteImage($item) {
					$item.fadeOut(function() {
						var $list = $('ul',$mail_rattache).length ? $('ul',$mail_rattache) : $('<ul class="mail_non_rattache ui-helper-reset"/>').appendTo($mail_rattache);
						$item.appendTo($list).fadeIn(function() {
							//$item.animate({ width: '48px' }).find('img').animate({ height: '36px' });
						});
						
						$.ajax({
							type     : "POST",
							url      : "../rattachemail",
							async    : true,
							data     : "mail="+$item.attr('name')+"&change=1&type="+$("#typeMail").attr('value'),
							dateType : "html",
							error    : function(msg) {
								alert( "Error: " + msg );
							},
							success  : function(msg) {}
						});
						
					});
				}

				// image recycle function
				
				function recycleImage($item) {
					$item.fadeOut(function() {
						$item.css('width','96px').find('img').css('height','72px').end().appendTo($mail_non_rattache).fadeIn();
					});
					
					$.ajax({
							type     : "POST",
							url      : "../rattachemail",
							async    : true,
							data     : "mail="+$item.attr('name')+"&change=0&type="+$("#typeMail").attr('value'),
							dateType : "html",
							error    : function(msg) {
								alert( "Error: " + msg );
							},
							success  : function(msg) {}
						});
				};
				
				
				
				};
					   
				
				
				$("#typeMail").change(function() {
				$.ajax({
							type     : "GET",
							url      : "../rattachermail",
							async    : true,
							data     : "id="+$("#typeMail").attr('value'),
							dateType : "html",
							error    : function(msg) {
								alert( "Error: " + msg );
							},
							success  : function(msg) {
								$("#dragdrop_record").remove();
								$("#dragdrop_content").html( $(msg).find("#dragdrop_content").html());
								dragdrop();	
							}
						});
				});
				
				
			});
	
    </script>{/literal}

        
        <br/> <br/>
        <select id="typeMail">
        {foreach from=$types item=type name=type}
        	{if $type.idNewsletterType==$id}
            <option value="{$type.idNewsletterType}" selected="selected"> {$type.nom|utf8_encode} </option>
            {else}
        	<option value="{$type.idNewsletterType}"> {$type.nom|utf8_encode} </option>
            {/if}
        {/foreach}
        </select>
        
        <br/> <br/>
	
		<div id="dragdrop_content">
    	<div id="dragdrop_record">
    
		<div class="demo ui-widget ui-helper-clearfix">
			
			<ul id="mail_non_rattache" class="mail_non_rattache ui-helper-reset ui-helper-clearfix">
            	{foreach from=$mail_non_rattache item=mail_non_rattache name=mail_non_rattache}
                	<li class="ui-widget-content ui-corner-tr" name="{$mail_non_rattache.mail}">
                        {$mail_non_rattache.mail}
                    </li>              
                
                {/foreach}

			</ul>

			<div id="mail_rattache" class="ui-widget-content ui-state-default">
				<h4 class="ui-widget-header"><span class="ui-icon ui-icon-mail_rattache">Mail Rattach&eacute;</span> Mail Rattach&eacute;</h4>
                
                <ul id="mail_non_rattache" class="mail_non_rattache ui-helper-reset ui-helper-clearfix">
                    {foreach from=$mail_rattache item=mail_rattache name=mail_rattache}
                        <li class="ui-widget-content ui-corner-tr" name="{$mail_rattache.mail}">
                            {$mail_rattache.mail}
                        </li>
                    {/foreach}
                
                </ul>
			</div>

		</div>
        </div>
        </div><!-- End demo -->
