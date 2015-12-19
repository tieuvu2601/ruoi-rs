/**
 * The span dialog definition.
 *
 * Created out of the CKEditor Plugin SDK:
 * http://docs.ckeditor.com/#!/guide/plugin_sdk_sample_1
 */

// Our dialog definition.
CKEDITOR.dialog.add( 'spanDialog', function( editor ) {
	return {

		// Basic properties of the dialog window: title, minimum size.
		title: 'Create Span Container',
		minWidth: 400,
		minHeight: 200,

		// Dialog window contents definition.
		contents: [
			{
				// Definition of the Basic Settings dialog tab (page).
				id: 'tab-basic',
				label: 'Basic Settings',

				// The tab contents.
				elements: [
					{
						// Text input field for the spaneviation text.
						type: 'text',
						id: 'span',
						label: 'Content',

						// Validation checking whether the field is not empty.
						//validate: CKEDITOR.dialog.validate.notEmpty( "Span field cannot be empty" ),

						// Called by the main setupContent call on dialog initialization.
						setup: function( element ) {
							this.setValue( element.getText() );
						},

						// Called by the main commitContent call on dialog confirmation.
						commit: function( element ) {
							element.setText( this.getValue() );
						}
					},
					{
						// Text input field for the spaneviation title (explanation).
						type: 'text',
						id: 'class',
						label: 'Class',
						//validate: CKEDITOR.dialog.validate.notEmpty( "Style field cannot be empty" ),

						// Called by the main setupContent call on dialog initialization.
						setup: function( element ) {
							this.setValue( element.getAttribute( "class" ) );
						},

						// Called by the main commitContent call on dialog confirmation.
						commit: function( element ) {
                            element.setAttribute( "class", this.getValue() );
						}
					},
                    {
                        // Text input field for the spaneviation title (explanation).
                        type: 'text',
                        id: 'style',
                        label: 'Style',
                        //validate: CKEDITOR.dialog.validate.notEmpty( "Style field cannot be empty" ),

                        // Called by the main setupContent call on dialog initialization.
                        setup: function( element ) {
                            this.setValue( element.getAttribute( "style" ) );
                        },

                        // Called by the main commitContent call on dialog confirmation.
                        commit: function( element ) {
                            element.setAttribute( "style", this.getValue() );
                        }
                    }
				]
			},

			/*// Definition of the Advanced Settings dialog tab (page).
			{
				id: 'tab-adv',
				label: 'Advanced Settings',
				elements: [
					{
						// Another text field for the span element id.
						type: 'text',
						id: 'id',
						label: 'Id',

						// Called by the main setupContent call on dialog initialization.
						setup: function( element ) {
							this.setValue( element.getAttribute( "id" ) );
						},

						// Called by the main commitContent call on dialog confirmation.
						commit: function ( element ) {
							var id = this.getValue();
							if ( id )
								element.setAttribute( 'id', id );
							else if ( !this.insertMode )
								element.removeAttribute( 'id' );
						}
					}
				]
			}*/
		],

		// Invoked when the dialog is loaded.
		onShow: function() {

			// Get the selection in the editor.
			var selection = editor.getSelection();

			// Get the element at the start of the selection.
			var element = selection.getStartElement();

			// Get the <span> element closest to the selection, if any.
			if ( element )
				element = element.getAscendant( 'span', true );

			// Create a new <span> element if it does not exist.
			if ( !element || element.getName() != 'span' ) {
				element = editor.document.createElement( 'span' );

				// Flag the insertion mode for later use.
				this.insertMode = true;
			}
			else
				this.insertMode = false;

			// Store the reference to the <span> element in an internal property, for later use.
			this.element = element;

			// Invoke the setup methods of all dialog elements, so they can load the element attributes.
			if ( !this.insertMode )
				this.setupContent( this.element );
		},

		// This method is invoked once a user clicks the OK button, confirming the dialog.
		onOk: function() {

			// The context of this function is the dialog object itself.
			// http://docs.ckeditor.com/#!/api/CKEDITOR.dialog
			var dialog = this;

			// Creates a new <span> element.
			var span = this.element;

			// Invoke the commit methods of all dialog elements, so the <span> element gets modified.
			this.commitContent( span );

			// Finally, in if insert mode, inserts the element at the editor caret position.
			if ( this.insertMode )
				editor.insertElement( span );
		}
	};
});