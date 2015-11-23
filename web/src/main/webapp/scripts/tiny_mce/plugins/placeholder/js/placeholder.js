var PlaceHolderDialog = {
  insert : function() {
		var ed = tinyMCEPopup.editor, se = ed.selection, r = se.getRng(), f, m = this.lastMode, s, b, fl = 0, w = ed.getWin(), wm = ed.windowManager, fo = 0;
    
    function get_user_input() {
      for (i=0;i<document.forms[0].placeholder_object.length;i++) {
        if (document.forms[0].placeholder_object[i].checked) {
          return document.forms[0].placeholder_object[i].value;
        }
      }
    }
    
    f = document.forms[0];
    placeholder_val = get_user_input();
    
    
    if (tinymce.isIE)
      ed.selection.getRng().duplicate().pasteHTML(placeholder_val); // Needs to be duplicated due to selection bug in IE
    else
      ed.getDoc().execCommand('InsertHTML', false, placeholder_val);
      
    tinyMCEPopup.close();
  }
};