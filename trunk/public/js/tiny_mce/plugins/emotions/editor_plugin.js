(function(){tinymce.create("tinymce.plugins.EmotionsPlugin",{init:function(a,b){a.addCommand("mceEmotion",function(){a.windowManager.open({file:b+"/emotions.htm",width:200+parseInt(a.getLang("emotions.delta_width",0)),height:250+parseInt(a.getLang("emotions.delta_height",0)),inline:1},{plugin_url:b})});a.addButton("emotions",{title:"emotions.emotions_desc",cmd:"mceEmotion"})},getInfo:function(){return{longname:"Emotions",author:"Moxiecode Systems AB",authorurl:"http://tinymce.moxiecode.com",infourl:"http://wiki.moxiecode.com/index.php/TinyMCE:Plugins/emotions",version:tinymce.majorVersion+"."+tinymce.minorVersion}}});tinymce.PluginManager.add("emotions",tinymce.plugins.EmotionsPlugin)})();