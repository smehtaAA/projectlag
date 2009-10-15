tinyMCEPopup.requireLangPack();

var EmotionsDialog = {
	init : function(ed) {
		tinyMCEPopup.resizeToInnerSize();
	},

	insert : function(file, title) {
		var ed = tinyMCEPopup.editor, dom = ed.dom;
		
		var pa = window.location.pathname;
		var sp = pa.split('/');

		tinyMCEPopup.execCommand('mceInsertContent', false, dom.createHTML('img', {
			src : 'http://'+sp[1]+'/images/smilies/'+file,
			alt : ed.getLang(title),
			title : ed.getLang(title),
			border : 0
		}));

		tinyMCEPopup.close();
	}
};

tinyMCEPopup.onInit.add(EmotionsDialog.init, EmotionsDialog);
