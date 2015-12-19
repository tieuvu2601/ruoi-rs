CKEDITOR.dialog.add( 'glossaryDialog', function( editor ){
    var autoAttributes =
    {
        displaytext : 1,
        class : 1,
        word : 1,
        description : 1
    };

    return {
        title : 'Insert Glossary',
        minWidth : 350,
        minHeight : 210,

        onShow : function(){
            delete this.glossary;

            var element = this.getParentEditor().getSelection().getSelectedElement();
            if ( element && element.getName() == "a")
            {
                this.glossary = element;
                this.setupContent( element );
            }
        },
        onOk : function(){
            var editor,
                element = this.glossary,
                isInsertMode = !element;

            if ( isInsertMode )
            {
                editor = this.getParentEditor();
                var displayText = this.getContentElement('info', 'displaytext').getInputElement().getValue();
                var word = this.getContentElement('info', '_cke_saved_name').getInputElement().getValue();
                element = editor.document.createElement( 'a' );
                element.setAttribute('word', word);
                element.appendText(displayText);
            }

            if ( isInsertMode )
                editor.insertElement( element );
            this.commitContent( { element : element } );
        },
        onLoad : function(){
            var autoSetup = function( element )
            {
                var value = element.hasAttribute( this.id ) && element.getAttribute( this.id );
                this.setValue( value || '' );
            };

            var autoCommit = function( data )
            {
                var element = data.element;
                var value = this.getValue();

                if ( value )
                    element.setAttribute( this.id, value );
                else
                    element.removeAttribute( this.id );
            };

            this.foreach( function( contentObj )
            {
                if ( autoAttributes[ contentObj.id ] )
                {
                    contentObj.setup = autoSetup;
                    contentObj.commit = autoCommit;
                }
            } );
        },
        contents : [
            {
                id : 'info',
                label : editor.lang.glossary.title,
                title : editor.lang.glossary.title,
                elements : [
                    {
                        type : 'hbox',
                        widths : [ '50%', '50%' ],
                        children :
                            [
                                {
                                    id : '_cke_saved_name',
                                    type : 'text',
                                    label : editor.lang.glossary.word,
                                    'default' : '',
                                    accessKey : 'N',
                                    setup : function( element )
                                    {
                                        this.setValue(
                                            element.data( 'cke-saved-name' ) ||
                                                element.getAttribute( 'name' ) ||
                                                '' );
                                    },
                                    commit : function( data )
                                    {
                                        var element = data.element;

                                        if ( this.getValue() )
                                            element.data( 'cke-saved-name', this.getValue() );
                                        else
                                        {
                                            element.data( 'cke-saved-name', false );
                                            element.removeAttribute( 'name' );
                                        }
                                    }
                                },
                                {
                                    id : 'class',
                                    type : 'text',
                                    label : editor.lang.glossary.styleSheetClass,
                                    'default': 'inline_glossary',
                                    accessKey : 'C'
                                }
                            ]
                    },
                    {
                        id : 'displaytext',
                        type : 'text',
                        label : editor.lang.glossary.text,
                        'default' : '',
                        accessKey : 'V',

                        onLoad : function()
                        {
                            // Repaint the style for IE7 (#6068)
                            if ( CKEDITOR.env.ie7Compat )
                                this.getElement().setStyle( 'zoom', '100%' );
                        }
                    },
                    {
                        id : 'description',
                        type : 'textarea',
                        label : editor.lang.glossary.description,

                        onLoad : function()
                        {
                            // Repaint the style for IE7 (#6068)
                            if ( CKEDITOR.env.ie7Compat )
                                this.getElement().setStyle( 'zoom', '100%' );
                        }
                    }

                ]
            }
        ]
    };

});
