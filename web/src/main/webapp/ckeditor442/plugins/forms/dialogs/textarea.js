/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */
CKEDITOR.dialog.add( 'textarea', function( editor ) {
	return {
		title: editor.lang.forms.textarea.title,
		minWidth: 350,
		minHeight: 220,
		onShow: function() {
			delete this.textarea;

			var element = this.getParentEditor().getSelection().getSelectedElement();
			if ( element && element.getName() == "textarea" ) {
				this.textarea = element;
				this.setupContent( element );
			}
		},
		onOk: function() {
			var editor,
				element = this.textarea,
				isInsertMode = !element;

			if ( isInsertMode ) {
				editor = this.getParentEditor();
				element = editor.document.createElement( 'textarea' );
			}
			this.commitContent( element );

			if ( isInsertMode )
				editor.insertElement( element );
		},
		contents: [
			{
			id: 'info',
			label: editor.lang.forms.textarea.title,
			title: editor.lang.forms.textarea.title,
			elements: [
				{
				id: '_cke_saved_name',
				type: 'text',
				label: editor.lang.common.name,
				'default': '',
				accessKey: 'N',
				setup: function( element ) {
					this.setValue( element.data( 'cke-saved-name' ) || element.getAttribute( 'name' ) || '' );
				},
				commit: function( element ) {
					if ( this.getValue() )
						element.data( 'cke-saved-name', this.getValue() );
					else {
						element.data( 'cke-saved-name', false );
						element.removeAttribute( 'name' );
					}
				}
			},
				{
				type: 'hbox',
				widths: [ '50%', '50%' ],
				children: [
					{
					id: 'cols',
					type: 'text',
					label: editor.lang.forms.textarea.cols,
					'default': '',
					accessKey: 'C',
					style: 'width:50px',
					validate: CKEDITOR.dialog.validate.integer( editor.lang.common.validateNumberFailed ),
					setup: function( element ) {
						var value = element.hasAttribute( 'cols' ) && element.getAttribute( 'cols' );
						this.setValue( value || '' );
					},
					commit: function( element ) {
						if ( this.getValue() )
							element.setAttribute( 'cols', this.getValue() );
						else
							element.removeAttribute( 'cols' );
					}
				},
					{
					id: 'rows',
					type: 'text',
					label: editor.lang.forms.textarea.rows,
					'default': '',
					accessKey: 'R',
					style: 'width:50px',
					validate: CKEDITOR.dialog.validate.integer( editor.lang.common.validateNumberFailed ),
					setup: function( element ) {
						var value = element.hasAttribute( 'rows' ) && element.getAttribute( 'rows' );
						this.setValue( value || '' );
					},
					commit: function( element ) {
						if ( this.getValue() )
							element.setAttribute( 'rows', this.getValue() );
						else
							element.removeAttribute( 'rows' );
					}
				}
				]
			},
                {
                    id : 'class',
                    type : 'text',
                    label : editor.lang.textfield.cssClass,
                    'default' : 'dynamic_textbox',
                    setup: function( element ) {
                        var value = element.hasAttribute( 'class' ) && element.getAttribute( 'class' );
                        this.setValue( value || '' );
                    },
                    commit: function( element ) {
                        if ( this.getValue() )
                            element.setAttribute( 'class', this.getValue() );
                        else
                            element.removeAttribute( 'class' );
                    }
                },
                {
                    type : 'hbox',
                    widths : [ '50%', '50%' ],
                    children :
                        [
                            {
                                id : 'autocomplete',
                                type : 'text',
                                label : editor.lang.textfield.autocomplete,
                                'default' : 'off',
                                setup: function( element ) {
                                    var value = element.hasAttribute( 'autocomplete' ) && element.getAttribute( 'autocomplete' );
                                    this.setValue( value || '' );
                                },
                                commit: function( element ) {
                                    if ( this.getValue() )
                                        element.setAttribute( 'autocomplete', this.getValue() );
                                    else
                                        element.removeAttribute( 'autocomplete' );
                                }
                            },
                            {
                                id : 'autocorrect',
                                type : 'text',
                                label : editor.lang.textfield.autocorrect,
                                'default' : 'off',
                                setup: function( element ) {
                                    var value = element.hasAttribute( 'autocorrect' ) && element.getAttribute( 'autocorrect' );
                                    this.setValue( value || '' );
                                },
                                commit: function( element ) {
                                    if ( this.getValue() )
                                        element.setAttribute( 'autocorrect', this.getValue() );
                                    else
                                        element.removeAttribute( 'autocorrect' );
                                }
                            }
                        ],
                    onLoad : function()
                    {
                        // Repaint the style for IE7 (#6068)
                        if ( CKEDITOR.env.ie7Compat )
                            this.getElement().setStyle( 'zoom', '100%' );
                    }
                },
                {
                    type : 'hbox',
                    widths : [ '50%', '50%' ],
                    children :
                        [
                            {
                                id : 'autocapitalize',
                                type : 'text',
                                label : editor.lang.textfield.autocapitalize,
                                'default' : 'off',
                                setup: function( element ) {
                                    var value = element.hasAttribute( 'autocapitalize' ) && element.getAttribute( 'autocapitalize' );
                                    this.setValue( value || '' );
                                },
                                commit: function( element ) {
                                    if ( this.getValue() )
                                        element.setAttribute( 'autocapitalize', this.getValue() );
                                    else
                                        element.removeAttribute( 'autocapitalize' );
                                }
                            },
                            {
                                id : 'spellcheck',
                                type : 'text',
                                label : editor.lang.textfield.spellcheck,
                                'default' : 'false',
                                setup: function( element ) {
                                    var value = element.hasAttribute( 'spellcheck' ) && element.getAttribute( 'spellcheck' );
                                    this.setValue( value || '' );
                                },
                                commit: function( element ) {
                                    if ( this.getValue() )
                                        element.setAttribute( 'spellcheck', this.getValue() );
                                    else
                                        element.removeAttribute( 'spellcheck' );
                                }
                            }
                        ],
                    onLoad : function()
                    {
                        // Repaint the style for IE7 (#6068)
                        if ( CKEDITOR.env.ie7Compat )
                            this.getElement().setStyle( 'zoom', '100%' );
                    }
                },
                {
                    id : 'style',
                    type : 'text',
                    label : editor.lang.textfield.cssStyle,
                    'default' : '',
                    setup: function( element ) {
                        var value = element.hasAttribute( 'style' ) && element.getAttribute( 'style' );
                        this.setValue( value || '' );
                    },
                    commit: function( element ) {
                        if ( this.getValue() )
                            element.setAttribute( 'style', this.getValue() );
                        else
                            element.removeAttribute( 'style' );
                    }
                }
                ,
				{
				id: 'value',
				type: 'textarea',
				label: editor.lang.forms.textarea.value,
				'default': '',
				setup: function( element ) {
					this.setValue( element.$.defaultValue );
				},
				commit: function( element ) {
					element.$.value = element.$.defaultValue = this.getValue();
				}
			}

			]
		}
		]
	};
} );
