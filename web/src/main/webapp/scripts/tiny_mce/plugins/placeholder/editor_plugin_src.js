/**
 * $Id: editor_plugin_src.js 677 2008-03-07 13:52:41Z spocke $
 *
 * @author Moxiecode
 * @copyright Copyright © 2004-2008, Moxiecode Systems AB, All rights reserved.
 */

(function() {
	tinymce.create('tinymce.plugins.PlaceHolderPlugin', {
		init : function(ed, url) {
			// Register commands
			ed.addCommand('mcePlaceHolder', function() {

				ed.windowManager.open({
					file : url + '/placeholder.htm',
					width : 420 + parseInt(ed.getLang('placeholder.delta_width', 0)),
					height : 160 + parseInt(ed.getLang('placeholder.delta_height', 0)),
					inline : 1
				}, {
					plugin_url : url
				});
			});

			// Register buttons
			ed.addButton('placeholder', {
				title : 'Placeholder',
        image : url + '/img/placeholder.gif',
				cmd : 'mcePlaceHolder'
			});
		},

		getInfo : function() {
			return {
				longname : 'PlaceHolder',
				author : 'Moxiecode Systems AB',
				authorurl : 'http://tinymce.moxiecode.com',
				infourl : 'http://wiki.moxiecode.com/index.php/TinyMCE:Plugins/advimage',
				version : tinymce.majorVersion + "." + tinymce.minorVersion
			};
		}
	});

	// Register plugin
	tinymce.PluginManager.add('placeholder', tinymce.plugins.PlaceHolderPlugin);
})();