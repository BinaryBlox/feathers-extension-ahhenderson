package feathers.extension.ahhenderson.controls.renderers {

	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import ahhenderson.core.managers.ObjectPoolManager;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	import feathers.extension.ahhenderson.controls.renderers.defaultCard.CardItem;
	import feathers.extension.ahhenderson.enums.FeathersComponentPoolType;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;


	public class DefaultCardItemRenderer extends FeathersControl implements IListItemRenderer {

		/**
		 * @private
		 * This will only work in a single list. If this item renderer needs to
		 * be used by multiple lists, this data should be stored differently.
		 */
		private static const CACHED_BOUNDS:Dictionary = new Dictionary( false );

		/**
		 * @private
		 */
		private static const HELPER_POINT:Point = new Point();

		/**
		 * @private
		 */
		private static const HELPER_TOUCHES_VECTOR:Vector.<Touch> = new <Touch>[];

		/**
		 * Constructor.
		 */
		public function DefaultCardItemRenderer() {

			this.isQuickHitAreaEnabled = true;
			this.addEventListener( TouchEvent.TOUCH, touchHandler );
			this.addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler )
		}

		/**
		 * @private
		 */
		protected var _itemHasLabel:Boolean = true;

		protected var _label:Label;

		/**
		 * @private
		 */
		protected var _labelField:String = "label";

		protected var _labelFunction:Function;

		/**
		 * @private
		 */
		protected var _owner:List;

		/**
		 * @private
		 */
		protected var fadeTween:Tween;

		/**
		 * @private
		 */
		protected var image:ImageLoader;

		/**
		 * @private
		 */
		protected var touchPointID:int = -1;

		/**
		 * @private
		 */
		private var _data:CardItem;

		private var _fmgr:FeathersApplicationManager;

		/**
		 * @private
		 */
		private var _index:int = -1;

		/**
		 * @private
		 */
		private var _isSelected:Boolean;

		private var _padding:Number = 5;

		private var _poolMgr:ObjectPoolManager;

		/**
		 * @inheritDoc
		 */
		public function get data():Object {

			return this._data;
		}

		/**
		 * @private
		 */
		public function set data( value:Object ):void {

			if ( this._data == value ) {
				return;
			}
			this.touchPointID = -1;
			this._data = CardItem( value );
			this.invalidate( INVALIDATION_FLAG_DATA );
		}

		public function get fmgr():FeathersApplicationManager {

			if ( !_fmgr ) {
				_fmgr = FeathersApplicationManager.instance;
			}

			return _fmgr;
		}

		/**
		 * @inheritDoc
		 */
		public function get index():int {

			return this._index;
		}

		/**
		 * @private
		 */
		public function set index( value:int ):void {

			if ( this._index == value ) {
				return;
			}
			this._index = value;
			this.invalidate( INVALIDATION_FLAG_DATA );
		}

		/**
		 * @inheritDoc
		 */
		public function get isSelected():Boolean {

			return this._isSelected;
		}

		/**
		 * @private
		 */
		public function set isSelected( value:Boolean ):void {

			if ( this._isSelected == value ) {
				return;
			}
			this._isSelected = value;
			this.dispatchEventWith( Event.CHANGE );
		}

		/**
		 * If true, the label will come from the renderer's item using the
		 * appropriate field or function for the label. If false, the label may
		 * be set externally.
		 *
		 * <p>In the following example, the item doesn't have a label:</p>
		 *
		 * <listing version="3.0">
		 * renderer.itemHasLabel = false;</listing>
		 *
		 * @default true
		 */
		public function get itemHasLabel():Boolean {

			return this._itemHasLabel;
		}

		/**
		 * @private
		 */
		public function set itemHasLabel( value:Boolean ):void {

			if ( this._itemHasLabel == value ) {
				return;
			}
			this._itemHasLabel = value;
			this.invalidate( INVALIDATION_FLAG_DATA );
		}

		/**
		 * Using <code>labelField</code> and <code>labelFunction</code>,
		 * generates a label from the item.
		 *
		 * <p>All of the label fields and functions, ordered by priority:</p>
		 * <ol>
		 *     <li><code>labelFunction</code></li>
		 *     <li><code>labelField</code></li>
		 * </ol>
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
		 * A function used to generate label text for a specific item. If this
		 * function is not null, then the <code>labelField</code> will be
		 * ignored.
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
		 * <p>In the following example, the label function is customized:</p>
		 *
		 * <listing version="3.0">
		 * renderer.labelFunction = function( item:Object ):String
		 * {
		 *    return item.firstName + " " + item.lastName;
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

			if ( this._labelFunction == value ) {
				return;
			}
			this._labelFunction = value;
			this.invalidate( INVALIDATION_FLAG_DATA );
		}

		/**
		 * @inheritDoc
		 */
		public function get owner():List {

			return List( this._owner );
		}

		/**
		 * @private
		 */
		public function set owner( value:List ):void {

			if ( this._owner == value ) {
				return;
			}

			if ( this._owner ) {
				this._owner.removeEventListener( FeathersEventType.SCROLL_START, owner_scrollStartHandler );
				this._owner.removeEventListener( FeathersEventType.SCROLL_COMPLETE, owner_scrollCompleteHandler );
			}
			this._owner = value;

			if ( this._owner ) {
				if ( this.image ) {
					this.image.delayTextureCreation = this._owner.isScrolling;
				}
				this._owner.addEventListener( FeathersEventType.SCROLL_START, owner_scrollStartHandler );
				this._owner.addEventListener( FeathersEventType.SCROLL_COMPLETE, owner_scrollCompleteHandler );
			}
			this.invalidate( INVALIDATION_FLAG_DATA );
		}

		public function get padding():Number {

			return _padding;
		}

		public function set padding( value:Number ):void {

			_padding = value;
		}

		public function get poolMgr():ObjectPoolManager {

			if ( !_poolMgr ) {
				_poolMgr = ObjectPoolManager.instance;
			}

			return _poolMgr;
		}

		/**
		 * @private
		 */
		protected function autoSizeIfNeeded():Boolean {

			var needsWidth:Boolean = isNaN( this.explicitWidth );
			var needsHeight:Boolean = isNaN( this.explicitHeight );

			if ( !needsWidth && !needsHeight ) {
				return false;
			}

			this.image.width = this.image.height = NaN;
			this.image.validate();
			var newWidth:Number = this.explicitWidth;

			if ( needsWidth ) {
				if ( this.image.isLoaded ) {
					if ( !CACHED_BOUNDS.hasOwnProperty( this._index )) {
						CACHED_BOUNDS[ this._index ] = new Point();
					}
					var boundsFromCache:Point = Point( CACHED_BOUNDS[ this._index ]);
					//also save it to a cache so that we can reuse the width and
					//height values later if the same image needs to be loaded
					//again.
					newWidth = boundsFromCache.x = this.image.width;
				} else {
					if ( CACHED_BOUNDS.hasOwnProperty( this._index )) {
						//if the image isn't loaded yet, but we've loaded it at
						//least once before, we can use a cached value to avoid
						//jittering when the image resizes
						boundsFromCache = Point( CACHED_BOUNDS[ this._index ]);
						newWidth = boundsFromCache.x;
					} else {
						//default to 100 if we've never displayed an image for
						//this index yet.
						newWidth = 100;
					}

				}
			}
			var newHeight:Number = this.explicitHeight;

			if ( needsHeight ) {
				if ( this.image.isLoaded ) {
					if ( !CACHED_BOUNDS.hasOwnProperty( this._index )) {
						CACHED_BOUNDS[ this._index ] = new Point();
					}
					boundsFromCache = Point( CACHED_BOUNDS[ this._index ]);
					newHeight = boundsFromCache.y = this.image.height;
				} else {
					if ( CACHED_BOUNDS.hasOwnProperty( this._index )) {
						boundsFromCache = Point( CACHED_BOUNDS[ this._index ]);
						newHeight = boundsFromCache.y;
					} else {
						newHeight = 100;
					}
				}
			}
			return this.setSizeInternal( newWidth, newHeight, false );
		}

		protected function commitData():void {

			//trace( "Committed..." );
			if ( this.fadeTween ) {
				this.fadeTween.advanceTime( Number.MAX_VALUE );
			}
			
			if ( this._data ) {
				this.image.visible = false;
				this.image.source = this._data.thumbURL;
			} else {
				this.image.source = null;
			}
			 
		}

		/**
		 * @private
		 */
		override protected function draw():void {

			var dataInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_DATA );
			var stylesInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_STYLES );
			var selectionInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_SELECTED );
			var sizeInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_SIZE );

			// TODO: Address later
			
			if ( dataInvalid ) { 
				
				this.commitData();
			}

			if ( stylesInvalid ) {
 
			}

			//this.autoSizeIfNeeded();
			this.layoutChildren();
			  
			sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;

			if ( sizeInvalid ) {
				this.image.width = this.actualWidth;
				this.image.height = this.actualHeight;
			}
		}

		/**
		 * @private
		 */
		protected function fadeTween_onComplete():void {

			this.fadeTween = null;
		}

		/**
		 * @private
		 */
		protected function image_completeHandler( event:Event ):void {

			this.image.alpha = 0;
			this.image.visible = true;
			this.fadeTween = new Tween( this.image, 1, Transitions.EASE_OUT );
			this.fadeTween.fadeTo( 1 );
			this.fadeTween.onComplete = fadeTween_onComplete;
			Starling.juggler.add( this.fadeTween );
			this.invalidate( INVALIDATION_FLAG_SIZE );
		}

		protected function image_errorHandler( event:Event ):void {

			this.invalidate( INVALIDATION_FLAG_SIZE );
		}

		/**
		 * @private
		 */
		override protected function initialize():void {

			this.image = this.poolMgr.borrowObj(FeathersComponentPoolType.IMAGE_LOADER);
			//this.image = new ImageLoader();
			this.image.textureQueueDuration = 0.25;
			this.image.addEventListener( Event.COMPLETE, image_completeHandler );
			this.image.addEventListener( FeathersEventType.ERROR, image_errorHandler );
			this.addChild( this.image );
			
			if ( !this._label ) { 
				this._label = this.poolMgr.borrowObj(FeathersComponentPoolType.LABEL);
				//this._label = new Label();
				this.addChild( this._label );
			}
		}

		override public function dispose():void{
			 
			this.poolMgr.returnObj(this.image);
			this.poolMgr.returnObj(this._label);
			
			super.dispose();
		}
		
		protected function layoutChildren():void {

			this._label.x = this._padding;
			this._label.y = this._padding;
			this._label.width = this.actualWidth - 2 * this._padding;
			this._label.height = this.actualHeight - 2 * this._padding;

			var backgroundWidth:Number = this.actualWidth; // - xPosition - widthOffset;
			var backgroundHeight:Number = this.actualHeight; // - yPosition - heightOffset;

	
			/*if ( this._backgroundSkin ) {
				this._backgroundSkin.x = 0;
				this._backgroundSkin.y = 0;
				this._backgroundSkin.width = backgroundWidth;
				this._backgroundSkin.height = backgroundHeight;
			}
	
			if ( this._borderSkin ) {
				this.borderSkin.drawBackground( this.actualWidth, this.actualHeight );
			}*/

		}

		/**
		 * @private
		 */
		protected function owner_scrollCompleteHandler( event:Event ):void {

			this.image.delayTextureCreation = false;
		}

		/**
		 * @private
		 */
		protected function owner_scrollStartHandler( event:Event ):void {

			this.touchPointID = -1;
			this.image.delayTextureCreation = true;
		}

		/**
		 * @private
		 */
		protected function removedFromStageHandler( event:Event ):void {

			this.touchPointID = -1;
		}

		/**
		 * @private
		 */
		protected function touchHandler( event:TouchEvent ):void {

			var touches:Vector.<Touch> = event.getTouches( this, null, HELPER_TOUCHES_VECTOR );

			if ( touches.length == 0 ) {
				return;
			}

			if ( this.touchPointID >= 0 ) {
				var touch:Touch;

				for each ( var currentTouch:Touch in touches ) {
					if ( currentTouch.id == this.touchPointID ) {
						touch = currentTouch;
						break;
					}
				}

				if ( !touch ) {
					HELPER_TOUCHES_VECTOR.length = 0;
					return;
				}

				if ( touch.phase == TouchPhase.ENDED ) {
					this.touchPointID = -1;

					touch.getLocation( this, HELPER_POINT );

					if ( this.hitTest( HELPER_POINT, true ) != null && !this._isSelected ) {
						this.isSelected = true;
					}
				}
			} else {
				for each ( touch in touches ) {
					if ( touch.phase == TouchPhase.BEGAN ) {
						this.touchPointID = touch.id;
						break;
					}
				}
			}
			HELPER_TOUCHES_VECTOR.length = 0;
		}
		
		public function get factoryID():String
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function set factoryID(value:String):void
		{
			// TODO Auto Generated method stub
			
		}
		
	}
}
