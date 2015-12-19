CKEDITOR.plugins.add( 'span', {
    init: function( editor ) {

        editor.addCommand( 'spanDialog', new CKEDITOR.dialogCommand( 'spanDialog' ) );
        editor.ui.addButton( 'Span', {
            label: 'Insert span',
            command: 'spanDialog',
            //toolbar: 'insert',
            icon:this.path+"icons/span.png"
        });
        CKEDITOR.dialog.add( 'spanDialog', this.path + 'dialogs/span.js' );
    }
});
