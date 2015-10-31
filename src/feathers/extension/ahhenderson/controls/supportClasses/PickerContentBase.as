/*
Feathers
Copyright 2012-2015 Bowler Hat LLC. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package feathers.extension.ahhenderson.controls.supportClasses {

	import flash.ui.Keyboard;
	
	import mx.utils.ObjectUtil;
	
	import feathers.controls.Button;
	import feathers.controls.ToggleButton;
	import feathers.controls.popups.BottomDrawerPopUpContentManager;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.popups.IPopUpContentManager;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.core.FeathersControl;
	import feathers.core.IFocusDisplayObject;
	import feathers.core.IToggle;
	import feathers.core.PropertyProxy;
	import feathers.events.FeathersEventType;
	import feathers.extension.ahhenderson.controls.interfaces.IPickerContent;
	import feathers.extension.ahhenderson.helpers.DialogHelper;
	import feathers.skins.IStyleProvider;
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;


	/**
	 * Dispatched when the pop-up list is opened.
	 *
	 * <p>The properties of the event object have the following values:</p>
	 * <table class="innertable">
	 * <tr><th>Property</th><th>Value</th></tr>
	 * <tr><td><code>bubbles</code></td><td>false</td></tr>
	 * <tr><td><code>currentTarget</code></td><td>The Object that defines the
	 *   event listener that handles the event. For example, if you use
	 *   <code>myButton.addEventListener()</code> to register an event listener,
	 *   myButton is the value of the <code>currentTarget</code>.</td></tr>
	 * <tr><td><code>data</code></td><td>null</td></tr>
	 * <tr><td><code>target</code></td><td>The Object that dispatched the event;
	 *   it is not always the Object listening for the event. Use the
	 *   <code>currentTarget</code> property to always access the Object
	 *   listening for the event.</td></tr>
	 * </table>
	 *
	 * @eventType starling.events.Event.OPEN
	 */
	[Event( name = "open", type = "starling.events.Event" )]
	/**
	 * Dispatched when the pop-up list is closed.
	 *
	 * <p>The properties of the event object have the following values:</p>
	 * <table class="innertable">
	 * <tr><th>Property</th><th>Value</th></tr>
	 * <tr><td><code>bubbles</code></td><td>false</td></tr>
	 * <tr><td><code>currentTarget</code></td><td>The Object that defines the
	 *   event listener that handles the event. For example, if you use
	 *   <code>myButton.addEventListener()</code> to register an event listener,
	 *   myButton is the value of the <code>currentTarget</code>.</td></tr>
	 * <tr><td><code>data</code></td><td>null</td></tr>
	 * <tr><td><code>target</code></td><td>The Object that dispatched the event;
	 *   it is not always the Object listening for the event. Use the
	 *   <code>currentTarget</code> property to always access the Object
	 *   listening for the event.</td></tr>
	 * </table>
	 *
	 * @eventType starling.events.Event.CLOSE
	 */
	[Event( name = "close", type = "starling.events.Event" )]
	/**
	 * Dispatched when the selected item changes.
	 *
	 * <p>The properties of the event object have the following values:</p>
	 * <table class="innertable">
	 * <tr><th>Property</th><th>Value</th></tr>
	 * <tr><td><code>bubbles</code></td><td>false</td></tr>
	 * <tr><td><code>currentTarget</code></td><td>The Object that defines the
	 *   event listener that handles the event. For example, if you use
	 *   <code>myButton.addEventListener()</code> to register an event listener,
	 *   myButton is the value of the <code>currentTarget</code>.</td></tr>
	 * <tr><td><code>data</code></td><td>null</td></tr>
	 * <tr><td><code>target</code></td><td>The Object that dispatched the event;
	 *   it is not always the Object listening for the event. Use the
	 *   <code>currentTarget</code> property to always access the Object
	 *   listening for the event.</td></tr>
	 * </table>
	 *
	 * @eventType starling.events.Event.CHANGE
	 */
	[Event( name = "change", type = "starling.events.Event" )]
	/**
	 * Displays a button that may be triggered to display a pop-up list.
	 * The list may be customized to display in different ways, such as a
	 * drop-down, in a <code>Callout</code>, or as a modal overlay.
	 *
	 * <p>The following example creates a picker list, gives it a data provider,
	 * tells the item renderer how to interpret the data, and listens for when
	 * the selection changes:</p>
	 *
	 * <listing version="3.0">
	 * var list:PickerList = new PickerList();
	 *
	 * list.dataProvider = new ListCollection(
	 * [
	 *     { text: "Milk", thumbnail: textureAtlas.getTexture( "milk" ) },
	 *     { text: "Eggs", thumbnail: textureAtlas.getTexture( "eggs" ) },
	 *     { text: "Bread", thumbnail: textureAtlas.getTexture( "bread" ) },
	 *     { text: "Chicken", thumbnail: textureAtlas.getTexture( "chicken" ) },
	 * ]);
	 *
	 * list.listProperties.itemRendererFactory = function():IListItemRenderer
	 * {
	 *     var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
	 *     renderer.labelField = "text";
	 *     renderer.iconSourceField = "thumbnail";
	 *     return renderer;
	 * };
	 *
	 * list.addEventListener( Event.CHANGE, list_changeHandler );
	 *
	 * this.addChild( list );</listing>
	 *
	 * @see ../../../help/picker-list.html How to use the Feathers PickerList component
	 */
	public class PickerContentBase extends FeathersControl implements IFocusDisplayObject {

		public static const DEFAULT_CHILD_STYLE_NAME_BUTTON:String = "feathers-picker-list-button";

		public static const DEFAULT_CHILD_STYLE_NAME_PICKER_CONTENT:String = "default-child-style-name-picker-content";

		protected static const INVALIDATION_FLAG_BUTTON_FACTORY:String = "buttonFactory";
		
		protected static const INVALIDATION_FLAG_PICKER_CONTENT_FACTORY:String = "invalidation-flag-custom-content-factory";
		
		/**
		 * The default <code>IStyleProvider</code> for all <code>PickerList</code>
		 * components.
		 *
		 * @default null
		 * @see feathers.core.FeathersControl#styleProvider
		 */
		public static var globalStyleProvider:IStyleProvider;
 

		/**
		 * @private
		 */
		protected static function defaultButtonFactory():Button {

			return new Button();
		}

		/**
		 * @private
		 */
		protected function defaultPickerContentFactory():IPickerContent {

			throw new Error("Must override defaultPickerContentFactory method");
		}

		/**
		 * Constructor.
		 */
		public function PickerContentBase() {

			super();
		}

		/**
		 * @private
		 */
		protected var _buttonFactory:Function;

		/**
		 * @private
		 */
		protected var _buttonHasFocus:Boolean = false;

		/**
		 * @private
		 */
		protected var _buttonProperties:PropertyProxy;

		/**
		 * @private
		 */
		protected var _buttonTouchPointID:int = -1;

		/**
		 * @private
		 */
		protected var _customButtonStyleName:String;

		/**
		 * @private
		 */
		protected var _pickerContentFactory:Function;

		/**
		 * @private
		 */
		protected var _pickerContentProperties:PropertyProxy;

		/**
		 * @private
		 */
		protected var _pickerContentStyleName:String;

		/**
		 * @private
		 */
		protected var _ignoreSelectionChanges:Boolean = false;

		/**
		 * @private
		 */
		protected var _isCloseContentPending:Boolean = false;

		/**
		 * @private
		 */
		protected var _isOpenContentPending:Boolean = false;

		/**
		 * @private
		 */
		protected var _labelField:String = "label";

		/**
		 * @private
		 */
		protected var _labelFunction:Function;

		/**
		 * @private
		 */
		protected var _listIsOpenOnTouchBegan:Boolean = false;

		/**
		 * @private
		 */
		protected var _popUpContentManager:IPopUpContentManager;

		/**
		 * @private
		 */
		protected var _prompt:String;

		protected var _selectedItem:Object;

		/**
		 * @private
		 */
		protected var _toggleButtonOnOpenAndClose:Boolean = false;

		/**
		 * @private
		 */
		protected var _typicalItem:Object = null;

		/**
		 * @private
		 */
		protected var _typicalItemHeight:Number = NaN;

		/**
		 * @private
		 */
		protected var _typicalItemWidth:Number = NaN;

		/**
		 * The button sub-component.
		 *
		 * <p>For internal use in subclasses.</p>
		 *
		 * @see #buttonFactory
		 * @see #createButton()
		 */
		protected var button:Button;

		protected var buttonStyleName:String = DEFAULT_CHILD_STYLE_NAME_BUTTON;

		protected var pickerContent:IPickerContent;

		protected var pickerContentStyleName:String = DEFAULT_CHILD_STYLE_NAME_PICKER_CONTENT;

		public function get buttonFactory():Function {

			return this._buttonFactory;
		}

		/**
		 * @private
		 */
		public function set buttonFactory( value:Function ):void {

			if ( this._buttonFactory == value ) {
				return;
			}
			this._buttonFactory = value;
			this.invalidate( INVALIDATION_FLAG_BUTTON_FACTORY );
		}

		/**
		 * An object that stores properties for the picker's button
		 * sub-component, and the properties will be passed down to the button
		 * when the picker validates. For a list of available
		 * properties, refer to
		 * <a href="Button.html"><code>feathers.controls.Button</code></a>.
		 *
		 * <p>If the subcomponent has its own subcomponents, their properties
		 * can be set too, using attribute <code>&#64;</code> notation. For example,
		 * to set the skin on the thumb which is in a <code>SimpleScrollBar</code>,
		 * which is in a <code>List</code>, you can use the following syntax:</p>
		 * <pre>list.verticalScrollBarProperties.&#64;thumbProperties.defaultSkin = new Image(texture);</pre>
		 *
		 * <p>Setting properties in a <code>buttonFactory</code> function
		 * instead of using <code>buttonProperties</code> will result in better
		 * performance.</p>
		 *
		 * <p>In the following example, the button properties are passed to the
		 * picker list:</p>
		 *
		 * <listing version="3.0">
		 * list.buttonProperties.defaultSkin = new Image( upTexture );
		 * list.buttonProperties.downSkin = new Image( downTexture );</listing>
		 *
		 * @default null
		 *
		 * @see #buttonFactory
		 * @see feathers.controls.Button
		 */
		public function get buttonProperties():Object {

			if ( !this._buttonProperties ) {
				this._buttonProperties = new PropertyProxy( childProperties_onChange );
			}
			return this._buttonProperties;
		}

		/**
		 * @private
		 */
		public function set buttonProperties( value:Object ):void {

			if ( this._buttonProperties == value ) {
				return;
			}

			if ( !value ) {
				value = new PropertyProxy();
			}

			if ( !( value is PropertyProxy )) {
				var newValue:PropertyProxy = new PropertyProxy();

				for ( var propertyName:String in value ) {
					newValue[ propertyName ] = value[ propertyName ];
				}
				value = newValue;
			}

			if ( this._buttonProperties ) {
				this._buttonProperties.removeOnChangeCallback( childProperties_onChange );
			}
			this._buttonProperties = PropertyProxy( value );

			if ( this._buttonProperties ) {
				this._buttonProperties.addOnChangeCallback( childProperties_onChange );
			}
			this.invalidate( INVALIDATION_FLAG_STYLES );
		}

		/**
		 * Closes the pop-up list, if it is open.
		 */
		public function closeContent():void {

			this._isOpenContentPending = false;

			if ( !this._popUpContentManager.isOpen ) {
				return;
			}

			if ( !this._isValidating && this.isInvalid()) {
				this._isCloseContentPending = true;
				return;
			}
			this._isCloseContentPending = false;
			this.pickerContent.validate();

			//don't clean up anything from openList() in closeList(). The list
			//may be closed by removing it from the PopUpManager, which would
			//result in closeList() never being called.
			//instead, clean up in the Event.REMOVED_FROM_STAGE listener.
			this._popUpContentManager.close();
		}

		public function get customButtonStyleName():String {

			return this._customButtonStyleName;
		}

		/**
		 * @private
		 */
		public function set customButtonStyleName( value:String ):void {

			if ( this._customButtonStyleName == value ) {
				return;
			}
			this._customButtonStyleName = value;
			this.invalidate( INVALIDATION_FLAG_BUTTON_FACTORY );
		}

		public function get pickerContentFactory():Function {

			return this._pickerContentFactory;
		}

		/**
		 * @private
		 */
		public function set pickerContentFactory( value:Function ):void {

			if ( this._pickerContentFactory == value ) {
				return;
			}
			this._pickerContentFactory = value;
			this.invalidate( INVALIDATION_FLAG_PICKER_CONTENT_FACTORY );
		}

		public function get pickerContentProperties():Object {

			if ( !this._pickerContentProperties ) {
				this._pickerContentProperties = new PropertyProxy( childProperties_onChange );
			}
			return this._pickerContentProperties;
		}

		/**
		 * @private
		 */
		public function set pickerContentProperties( value:Object ):void {

			if ( this._pickerContentProperties == value ) {
				return;
			}

			if ( !value ) {
				value = new PropertyProxy();
			}

			if ( !( value is PropertyProxy )) {
				var newValue:PropertyProxy = new PropertyProxy();

				for ( var propertyName:String in value ) {
					newValue[ propertyName ] = value[ propertyName ];
				}
				value = newValue;
			}

			if ( this._pickerContentProperties ) {
				this._pickerContentProperties.removeOnChangeCallback( childProperties_onChange );
			}
			this._pickerContentProperties = PropertyProxy( value );

			if ( this._pickerContentProperties ) {
				this._pickerContentProperties.addOnChangeCallback( childProperties_onChange );
			}
			this.invalidate( INVALIDATION_FLAG_STYLES );
		}

		public function get customListStyleName():String {

			return this._pickerContentStyleName;
		}

		/**
		 * @private
		 */
		public function set customListStyleName( value:String ):void {

			if ( this._pickerContentStyleName == value ) {
				return;
			}
			this._pickerContentStyleName = value;
			this.invalidate( INVALIDATION_FLAG_PICKER_CONTENT_FACTORY );
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose():void {

			if ( this.pickerContent ) {
				this.closeContent();
				this.pickerContent.dispose();
				this.pickerContent = null; 
			}

			if ( this._popUpContentManager ) {
				this._popUpContentManager.dispose();
				this._popUpContentManager = null;
			}
			//clearing selection now so that the data provider setter won't
			//cause a selection change that triggers events.
			this.selectedItem = null; 
			super.dispose();
		}

		/**
		 * @private
		 */
		override public function hideFocus():void {

			if ( !this.button ) {
				return;
			}
			this.button.hideFocus();
		}

		/**
		 * Using <code>labelField</code> and <code>labelFunction</code>,
		 * generates a label from the selected item to be displayed by the
		 * picker list's button control.
		 *
		 * <p><strong>Important:</strong> This value only affects the selected
		 * item displayed by the picker list's button control. It will <em>not</em>
		 * affect the label text of the pop-up list's item renderers.</p>
		 */
		public function itemToLabel( item:Object ):String {

			if ( this._labelFunction != null ) {
				var labelResult:Object = this._labelFunction( item );

				if ( labelResult is String ) {
					return labelResult as String;
				}
				return labelResult.toString();
			} else if ( this._labelField != null && item && item.hasOwnProperty( this._labelField )) {
				labelResult = item[ this._labelField ];

				if ( labelResult is String ) {
					return labelResult as String;
				}
				return labelResult.toString();
			} else if ( item is String ) {
				return item as String;
			} else if ( item ) {
				return item.toString();
			}
			return "";
		}

		/**
		 * The field in the selected item that contains the label text to be
		 * displayed by the picker list's button control. If the selected item
		 * does not have this field, and a <code>labelFunction</code> is not
		 * defined, then the picker list will default to calling
		 * <code>toString()</code> on the selected item. To omit the
		 * label completely, define a <code>labelFunction</code> that returns an
		 * empty string.
		 *
		 * <p><strong>Important:</strong> This value only affects the selected
		 * item displayed by the picker list's button control. It will <em>not</em>
		 * affect the label text of the pop-up list's item renderers.</p>
		 *
		 * <p>In the following example, the label field is changed:</p>
		 *
		 * <listing version="3.0">
		 * list.labelField = "text";</listing>
		 *
		 * @default "label"
		 *
		 * @see #labelFunction
		 */
		public function get labelField():String {

			return this._labelField;
		}

		/**
		 * @private
		 */
		public function set labelField( value:String ):void {

			if ( this._labelField == value ) {
				return;
			}
			this._labelField = value;
			this.invalidate( INVALIDATION_FLAG_DATA );
		}

		/**
		 * A function used to generate label text for the selected item
		 * displayed by the picker list's button control. If this
		 * function is not null, then the <code>labelField</code> will be
		 * ignored.
		 *
		 * <p><strong>Important:</strong> This value only affects the selected
		 * item displayed by the picker list's button control. It will <em>not</em>
		 * affect the label text of the pop-up list's item renderers.</p>
		 *
		 * <p>The function is expected to have the following signature:</p>
		 * <pre>function( item:Object ):String</pre>
		 *
		 * <p>All of the label fields and functions, ordered by priority:</p>
		 * <ol>
		 *     <li><code>labelFunction</code></li>
		 *     <li><code>labelField</code></li>
		 * </ol>
		 *
		 * <p>In the following example, the label field is changed:</p>
		 *
		 * <listing version="3.0">
		 * list.labelFunction = function( item:Object ):String
		 * {
		 *     return item.firstName + " " + item.lastName;
		 * };</listing>
		 *
		 * @default null
		 *
		 * @see #labelField
		 */
		public function get labelFunction():Function {

			return this._labelFunction;
		}

		/**
		 * @private
		 */
		public function set labelFunction( value:Function ):void {

			this._labelFunction = value;
			this.invalidate( INVALIDATION_FLAG_DATA );
		}

		/**
		 * Opens the pop-up list, if it isn't already open.
		 */
		public function openContent():void {

			this._isCloseContentPending = false;
			this._isSelectedItemChanged = false;
			
			if ( this._popUpContentManager.isOpen ) {
				return;
			}

			if ( !this._isValidating && this.isInvalid()) {
				this._isOpenContentPending = true;
				return;
			}
			this._isOpenContentPending = false;

			if ( !( pickerContent is DisplayObject )) {
				DialogHelper.showAlert( "Error", "Custom content is not DisplayObject" );
				return
			}
		 
			// Handle setting Panel Title
			if(_popUpContentManager is BottomDrawerPopUpContentManager){
				(_popUpContentManager as BottomDrawerPopUpContentManager).prompt = this.prompt;
			}
			
			this._popUpContentManager.open( this.pickerContent as DisplayObject, this );

			this.pickerContent.validate();

			if ( this._focusManager ) {
				this._focusManager.focus = this.pickerContent;
				this.stage.addEventListener( KeyboardEvent.KEY_UP, stage_keyUpHandler );
				this.pickerContent.addEventListener( FeathersEventType.FOCUS_OUT, content_focusOutHandler );
			}
		}

		/**
		 * A manager that handles the details of how to display the pop-up list.
		 *
		 * <p>In the following example, a pop-up content manager is provided:</p>
		 *
		 * <listing version="3.0">
		 * list.popUpContentManager = new CalloutPopUpContentManager();</listing>
		 *
		 * @default null
		 */
		public function get popUpContentManager():IPopUpContentManager {

			return this._popUpContentManager;
		}

		/**
		 * @private
		 */
		public function set popUpContentManager( value:IPopUpContentManager ):void {

			if ( this._popUpContentManager == value ) {
				return;
			}

			if ( this._popUpContentManager is EventDispatcher ) {
				var dispatcher:EventDispatcher = EventDispatcher( this._popUpContentManager );
				dispatcher.removeEventListener( Event.OPEN, popUpContentManager_openHandler );
				dispatcher.removeEventListener( Event.CLOSE, popUpContentManager_closeHandler );
			}
			this._popUpContentManager = value;

			if ( this._popUpContentManager is EventDispatcher ) {
				dispatcher = EventDispatcher( this._popUpContentManager );
				dispatcher.addEventListener( Event.OPEN, popUpContentManager_openHandler );
				dispatcher.addEventListener( Event.CLOSE, popUpContentManager_closeHandler );
			}
			this.invalidate( INVALIDATION_FLAG_STYLES );
		}

		/**
		 * Text displayed by the button sub-component when no items are
		 * currently selected.
		 *
		 * <p>In the following example, a prompt is given to the picker list
		 * and the selected item is cleared to display the prompt:</p>
		 *
		 * <listing version="3.0">
		 * list.prompt = "Select an Item";
		 * list.selectedIndex = -1;</listing>
		 *
		 * @default null
		 */
		public function get prompt():String {

			return this._prompt;
		}

		/**
		 * @private
		 */
		public function set prompt( value:String ):void {

			if ( this._prompt == value ) {
				return;
			}
			this._prompt = value;
			this.invalidate( INVALIDATION_FLAG_SELECTED );
		}

		public function get selectedItem():Object {

			return _selectedItem;
		}

		/**
		 * @private
		 */
		public function set selectedItem( value:Object ):void {

			_selectedItem = value;
		}

		/**
		 * @private
		 */
		override public function showFocus():void {

			if ( !this.button ) {
				return;
			}
			this.button.showFocus();
		}

		public function get toggleButtonOnOpenAndClose():Boolean {

			return this._toggleButtonOnOpenAndClose;
		}

		/**
		 * @private
		 */
		public function set toggleButtonOnOpenAndClose( value:Boolean ):void {

			if ( this._toggleButtonOnOpenAndClose == value ) {
				return;
			}
			this._toggleButtonOnOpenAndClose = value;

			if ( this.button is IToggle ) {
				if ( this._toggleButtonOnOpenAndClose && this._popUpContentManager.isOpen ) {
					IToggle( this.button ).isSelected = true;
				} else {
					IToggle( this.button ).isSelected = false;
				}
			}
		}

		/**
		 * Used to auto-size the list. If the list's width or height is NaN, the
		 * list will try to automatically pick an ideal size. This item is
		 * used in that process to create a sample item renderer.
		 *
		 * <p>The following example provides a typical item:</p>
		 *
		 * <listing version="3.0">
		 * list.typicalItem = { text: "A typical item", thumbnail: texture };
		 * list.itemRendererProperties.labelField = "text";
		 * list.itemRendererProperties.iconSourceField = "thumbnail";</listing>
		 *
		 * @default null
		 */
		public function get typicalItem():Object {

			return this._typicalItem;
		}

		/**
		 * @private
		 */
		public function set typicalItem( value:Object ):void {

			if ( this._typicalItem == value ) {
				return;
			}
			this._typicalItem = value;
			this._typicalItemWidth = NaN;
			this._typicalItemHeight = NaN;
			this.invalidate( INVALIDATION_FLAG_STYLES );
		}

		protected function autoSizeIfNeeded():Boolean {

			var needsWidth:Boolean = this.explicitWidth !== this.explicitWidth; //isNaN
			var needsHeight:Boolean = this.explicitHeight !== this.explicitHeight; //isNaN

			if ( !needsWidth && !needsHeight ) {
				return false;
			}

			var buttonWidth:Number;
			var buttonHeight:Number;

			if ( this._typicalItem ) {
				if ( this._typicalItemWidth !== this._typicalItemWidth || //isNaN
					this._typicalItemHeight !== this._typicalItemHeight ) //isNaN
				{
					var oldWidth:Number = this.button.width;
					var oldHeight:Number = this.button.height;
					this.button.width = NaN;
					this.button.height = NaN;

					if ( this._typicalItem ) {
						this.button.label = this.itemToLabel( this._typicalItem );
					}
					this.button.validate();
					this._typicalItemWidth = this.button.width;
					this._typicalItemHeight = this.button.height;
					this.refreshButtonLabel();
					this.button.width = oldWidth;
					this.button.height = oldHeight;
				}
				buttonWidth = this._typicalItemWidth;
				buttonHeight = this._typicalItemHeight;
			} else {
				this.button.validate();
				buttonWidth = this.button.width;
				buttonHeight = this.button.height;
			}

			var newWidth:Number = this.explicitWidth;
			var newHeight:Number = this.explicitHeight;

			if ( needsWidth ) {
				if ( buttonWidth === buttonWidth ) //!isNaN
				{
					newWidth = buttonWidth;
				} else {
					newWidth = 0;
				}
			}

			if ( needsHeight ) {
				if ( buttonHeight === buttonHeight ) //!isNaN
				{
					newHeight = buttonHeight;
				} else {
					newHeight = 0;
				}
			}

			return this.setSizeInternal( newWidth, newHeight, false );
		}

		/**
		 * @private
		 */
		protected function button_touchHandler( event:TouchEvent ):void {

			if ( this._buttonTouchPointID >= 0 ) {
				var touch:Touch = event.getTouch( this.button, TouchPhase.ENDED, this._buttonTouchPointID );

				if ( !touch ) {
					return;
				}
				this._buttonTouchPointID = -1;
				//the button will dispatch Event.TRIGGERED before this touch
				//listener is called, so it is safe to clear this flag.
				//we're clearing it because Event.TRIGGERED may also be
				//dispatched after keyboard input.
				this._listIsOpenOnTouchBegan = false;
			} else {
				touch = event.getTouch( this.button, TouchPhase.BEGAN );

				if ( !touch ) {
					return;
				}
				this._buttonTouchPointID = touch.id;
				this._listIsOpenOnTouchBegan = this._popUpContentManager.isOpen;
			}
		}

		/**
		 * @private
		 */
		protected function button_triggeredHandler( event:Event ):void {

			if ( this._focusManager && this._listIsOpenOnTouchBegan ) {
				return;
			}

			if ( this._popUpContentManager.isOpen ) {
				this.closeContent();
				return;
			}
			this.openContent();
		}

		/**
		 * @private
		 */
		protected function childProperties_onChange( proxy:PropertyProxy, name:String ):void {

			this.invalidate( INVALIDATION_FLAG_STYLES );
		}

		private var _isSelectedItemChanged:Boolean;
		
		/**
		 * @private
		 */
		protected function content_changeHandler( event:Event ):void {

			if ( this._ignoreSelectionChanges ) {
				return;
			} 
			
			if(this.selectedItem !== this.pickerContent.selectedItem){
				this.selectedItem = ObjectUtil.copy(this.pickerContent.selectedItem);
				this._isSelectedItemChanged = true;
				return;
			}
			 
			this._isSelectedItemChanged = false;
		}

		/**
		 * @private
		 */
		protected function content_focusOutHandler( event:Event ):void {

			if ( !this._popUpContentManager.isOpen ) {
				return;
			}
			this.closeContent();
		}

		/**
		 * @private
		 */
		protected function content_removedFromStageHandler( event:Event ):void {

			if ( this._focusManager ) {
				this.pickerContent.stage.removeEventListener( KeyboardEvent.KEY_UP, stage_keyUpHandler );
				this.pickerContent.removeEventListener( FeathersEventType.FOCUS_OUT, content_focusOutHandler );
			}
		}

		/**
		 * @private
		 */
		protected function content_triggeredHandler( event:Event ):void {

			if ( !this._isEnabled ) {
				return;
			}
			this.closeContent();
		}

		/**
		 * Creates and adds the <code>button</code> sub-component and
		 * removes the old instance, if one exists.
		 *
		 * <p>Meant for internal use, and subclasses may override this function
		 * with a custom implementation.</p>
		 *
		 * @see #button
		 * @see #buttonFactory
		 * @see #customButtonStyleName
		 */
		protected function createButton():void {

			if ( this.button ) {
				this.button.removeFromParent( true );
				this.button = null;
			}

			var factory:Function = this._buttonFactory != null ? this._buttonFactory : defaultButtonFactory;
			var buttonStyleName:String = this._customButtonStyleName;
			this.button = Button( factory());

			if ( this.button is ToggleButton ) {
				//we'll control the value of isSelected manually
				ToggleButton( this.button ).isToggle = false;
			}
			this.button.styleNameList.add( buttonStyleName );
			this.button.addEventListener( TouchEvent.TOUCH, button_touchHandler );
			this.button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
			this.addChild( this.button );
		}

		/**
		 * Creates and adds the <code>list</code> sub-component and
		 * removes the old instance, if one exists.
		 *
		 * <p>Meant for internal use, and subclasses may override this function
		 * with a custom implementation.</p>
		 *
		 * @see #list
		 * @see #listFactory
		 * @see #customListStyleName
		 */
		protected function createContent():void {

			if ( this.pickerContent ) {
				this.pickerContent.removeFromParent( false );
				//disposing separately because the list may not have a parent
				this.pickerContent.dispose();
				this.pickerContent = null;

			}

			var factory:Function = this._pickerContentFactory != null ? this._pickerContentFactory : this.defaultPickerContentFactory;
			var contentStyleName:String = this._pickerContentStyleName != null ? this._pickerContentStyleName : this.pickerContentStyleName;

			var pickerContent:IPickerContent = factory() as IPickerContent;

			if ( !pickerContent ) {
				DialogHelper.showAlert( "Error", "Error setting picker content" );
				return;
			}

			// Set picker content
			this.pickerContent = pickerContent;

			this.pickerContent.focusOwner = this;
			this.pickerContent.styleNameList.add( contentStyleName );
			this.pickerContent.addEventListener( Event.CHANGE, content_changeHandler );
			this.pickerContent.addEventListener( Event.TRIGGERED, content_triggeredHandler );
			this.pickerContent.addEventListener( Event.REMOVED_FROM_STAGE, content_removedFromStageHandler );

		}

		/**
		 * @private
		 */
		override protected function get defaultStyleProvider():IStyleProvider {

			return PickerContentBase.globalStyleProvider;
		}

		/**
		 * @private
		 */
		override protected function draw():void {

			var dataInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_DATA );
			var stylesInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_STYLES );
			var stateInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_STATE );
			var selectionInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_SELECTED );
			var sizeInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_SIZE );
			var buttonFactoryInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_BUTTON_FACTORY );
			var pickerContentFactoryInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_PICKER_CONTENT_FACTORY );

			if ( buttonFactoryInvalid ) {
				this.createButton();
			}

			if ( pickerContentFactoryInvalid ) {
				this.createContent();
				
			}

			if ( buttonFactoryInvalid || stylesInvalid || selectionInvalid ) {
				//this section asks the button to auto-size again, if our
				//explicit dimensions aren't set.
				//set this before buttonProperties is used because it might
				//contain width or height changes.
				if ( this.explicitWidth !== this.explicitWidth ) //isNaN
				{
					this.button.width = NaN;
				}

				if ( this.explicitHeight !== this.explicitHeight ) //isNaN
				{
					this.button.height = NaN;
				}
			}

			if ( buttonFactoryInvalid || stylesInvalid ) {
				this.refreshButtonProperties();
			}
			
			if ( pickerContentFactoryInvalid || stylesInvalid ) {
				this.refreshPickerContentProperties()
			}

			if ( dataInvalid ) {
				var oldIgnoreSelectionChanges:Boolean = this._ignoreSelectionChanges;
				this._ignoreSelectionChanges = true;
				this._ignoreSelectionChanges = oldIgnoreSelectionChanges;
			}

			if ( buttonFactoryInvalid || stateInvalid ) {
				this.button.isEnabled = this._isEnabled;
				this.pickerContent.isEnabled = this._isEnabled;
			}

			if ( buttonFactoryInvalid || dataInvalid || selectionInvalid ) {
				this.refreshButtonLabel();
			}

			if ( dataInvalid || selectionInvalid ) {
				oldIgnoreSelectionChanges = this._ignoreSelectionChanges;
				this._ignoreSelectionChanges = true;
				this._ignoreSelectionChanges = oldIgnoreSelectionChanges;
			}

			sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;

			if ( buttonFactoryInvalid || stylesInvalid || sizeInvalid || selectionInvalid ) {
				this.layout();
			}

			//final validation to avoid juggler next frame issues
			//also, to ensure that property changes on the pop-up list are fully
			//committed
			this.pickerContent.validate();

			this.handlePendingActions();
		}

		/**
		 * @private
		 */
		override protected function focusInHandler( event:Event ):void {

			super.focusInHandler( event );
			this._buttonHasFocus = true;
			this.button.dispatchEventWith( FeathersEventType.FOCUS_IN );
		}

		/**
		 * @private
		 */
		override protected function focusOutHandler( event:Event ):void {

			if ( this._buttonHasFocus ) {
				this.button.dispatchEventWith( FeathersEventType.FOCUS_OUT );
				this._buttonHasFocus = false;
			}
			super.focusOutHandler( event );
		}

		/**
		 * @private
		 */
		protected function handlePendingActions():void {

			if ( this._isOpenContentPending ) {
				this.openContent();
			}

			if ( this._isCloseContentPending ) {
				this.closeContent();
			}
		}

		/**
		 * @private
		 */
		override protected function initialize():void {

			if ( !this._popUpContentManager ) {
				if ( DeviceCapabilities.isTablet( Starling.current.nativeStage )) {
					this.popUpContentManager = new CalloutPopUpContentManager();
				} else {
					this.popUpContentManager = new VerticalCenteredPopUpContentManager();
				}
			}

		}

		/**
		 * @private
		 */
		protected function layout():void {

			this.button.width = this.actualWidth;
			this.button.height = this.actualHeight;

		
			//final validation to avoid juggler next frame issues
			this.button.validate();
		}

		/**
		 * @private
		 */
		protected function popUpContentManager_closeHandler( event:Event ):void {

			if ( this._toggleButtonOnOpenAndClose && this.button is IToggle ) {
				IToggle( this.button ).isSelected = false;
			}
			
			if(_isSelectedItemChanged){
				this.dispatchEventWith( Event.CHANGE ); 
				_isSelectedItemChanged = false;
			}
			 
			
			this.dispatchEventWith( Event.CLOSE );
			
			
		}

		/**
		 * @private
		 */
		protected function popUpContentManager_openHandler( event:Event ):void {

			if ( this._toggleButtonOnOpenAndClose && this.button is IToggle ) {
				IToggle( this.button ).isSelected = true;
			}
			this.dispatchEventWith( Event.OPEN );
		}

		/**
		 * @private
		 */
		protected function refreshButtonLabel():void {
	
			this.button.label = this._prompt;
		}

		/**
		 * @private
		 */
		protected function refreshButtonProperties():void {

			for ( var propertyName:String in this._buttonProperties ) {
				var propertyValue:Object = this._buttonProperties[ propertyName ];
				this.button[ propertyName ] = propertyValue;
			}
		}

		/**
		 * @private
		 */
		protected function refreshPickerContentProperties():void {

			for ( var propertyName:String in this._pickerContentProperties ) {
				var propertyValue:Object = this._pickerContentProperties[ propertyName ];
				
				// If property exists on content, set it
				if(DisplayObject(this.pickerContent).hasOwnProperty(propertyName)){
					this.pickerContent[ propertyName ] = propertyValue;
				} 
			}
		}

		/**
		 * @private
		 */
		protected function stage_keyUpHandler( event:KeyboardEvent ):void {

			if ( !this._popUpContentManager.isOpen ) {
				return;
			}

			if ( event.keyCode == Keyboard.ENTER ) {
				this.closeContent();
			}
		}
	}
}
