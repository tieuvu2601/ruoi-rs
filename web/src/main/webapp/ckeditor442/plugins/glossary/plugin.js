CKEDITOR.plugins.add( 'glossary', {
    lang:['en'],
    init: function( editor ) {

        editor.addCommand( 'glossaryDialog', new CKEDITOR.dialogCommand( 'glossaryDialog' ) );
        editor.ui.addButton( 'Glossary', {
            label: 'Insert Glossary',
            command: 'glossaryDialog',
            toolbar: 'insert',
            icon:this.path+"images/glossary.gif"
        });
        CKEDITOR.dialog.add( 'glossaryDialog', this.path + 'dialogs/glossary.js' );
    }
});


