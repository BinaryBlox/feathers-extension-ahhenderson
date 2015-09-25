package feathers.extension.ahhenderson.controls.renderers.base {

	import flash.events.Event;
	import flash.geom.Point;
	
	import ahhenderson.core.ui.layout.HorizontalAlign;
	
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.IFeathersControl;
	import feathers.extension.ahhenderson.controls.TitledTextBlock;
	import feathers.extension.ahhenderson.helpers.LayoutHelper;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.ILayout;
	import feathers.layout.ILayoutData;
	import feathers.layout.VerticalLayout;
	import feathers.utils.math.roundToNearest;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;


	public class BaseTitledTextBlockItemRenderer extends LayoutGroupListItemRenderer {

		private static const HELPER_POINT:Point = new Point();

		public function BaseTitledTextBlockItemRenderer() {
		}

		protected var _accessory:IFeathersControl;

		protected var _icon:Image;

		protected var _padding:Number = 0;

		protected var _titledTextBlock:TitledTextBlock;

		protected var touchID:int = -1;

		private const ACCESSORY_PERCENT_WIDTH:Number = 40;

		private const CONTENT_PERCENT_WIDTH:Number = 100;

		private var _accessoryPercentWidth:Number = NaN;

		private var _fmgr:FeathersApplicationManager;

		private var _titledTextBlockLayoutData:ILayoutData;

		override public function dispose():void {

			super.dispose();

		}

		public function get padding():Number {

			return this._padding;
		}

		public function set padding( value:Number ):void {

			if ( this._padding == value ) {
				return;
			}
			this._padding = value;
			this.invalidate( INVALIDATION_FLAG_LAYOUT );
		}

		public function setTitledTextBlockLayout():VerticalLayout {

			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.firstGap = 10 * this.scaledResolution;
			verticalLayout.lastGap = 10 * this.scaledResolution;
			verticalLayout.gap = 10 * this.scaledResolution;
			verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;

			// Set Textblock layout type
			this.controlLayoutData = new HorizontalLayoutData( 100, 100 );

			return verticalLayout;
		}

		protected function addIconToDisplayList( icon:Image ):void {

			if ( !icon ) {
				return;
			}

			icon.smoothing = TextureSmoothing.NONE;
			icon.width = roundToNearest( icon.width );
			icon.height = roundToNearest( icon.height );

			this.addChildAt( icon, 0 );
		}

		override protected function commitData():void {

			if ( this._data && this._owner ) {
				//this._label.text = this._data.title;

				this._titledTextBlock.title = this.data.title;
				this._titledTextBlock.content = this.data.content;
				this._accessoryPercentWidth = this.data.accessoryPercentWidth;

				// Add icon
				if ( this.data.icon && this.data.icon as Texture ) {
 
					if ( this._icon && this.contains( this._icon )) {

						if ( this._icon.texture !== ( this.data.icon as Texture )) {

							this.removeChild( this._icon, true );
							this._icon = new Image( this.data.icon as Texture );
							addIconToDisplayList( this._icon );
						}
					} else {
						this._icon = new Image( this.data.icon as Texture );
						addIconToDisplayList( this._icon );
					}
				}

				// Add accessory if it exists
				if ( this.data.accessory && !this.contains( this.data.accessory )) {
					this.addChild( this.data.accessory )

					const accessoryWidth:Number =
						( !this._accessoryPercentWidth ||
						isNaN( this._accessoryPercentWidth )) ? this.ACCESSORY_PERCENT_WIDTH : this._accessoryPercentWidth;

					const contentWidth:Number = this.CONTENT_PERCENT_WIDTH - accessoryWidth;

					// Update layout based on accessory
					this._titledTextBlock.layoutData = new HorizontalLayoutData( contentWidth, 100 );
					FeathersControl( this.data.accessory ).layoutData = new HorizontalLayoutData( accessoryWidth, 100 );

				}
			} else {
				//this._label.text = null;
				this._titledTextBlock.title = null;
				this._titledTextBlock.content = null;

				if ( this._icon && this.contains( this._icon )) {
					this.removeChild( this._icon, true );
				}

					//this._titledTextBlock = null;
			}
		}

		protected function defaultLayout():ILayout {

			const horizontalLayout:HorizontalLayout = new HorizontalLayout();

			horizontalLayout.firstGap = 10 * this.fmgr.theme.scaledResolution;
			horizontalLayout.lastGap = 10 * this.fmgr.theme.scaledResolution;
			horizontalLayout.gap = 15 * this.fmgr.theme.scaledResolution;
			horizontalLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			horizontalLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;

			horizontalLayout.padding = 10 * this.fmgr.theme.scaledResolution;

			return horizontalLayout;
		}

		protected function get fmgr():FeathersApplicationManager {

			if ( !_fmgr ) {
				_fmgr = FeathersApplicationManager.instance;
			}

			return _fmgr;
		}

		override protected function initialize():void {

			/*	this.addEventListener( TouchEvent.TOUCH, touchHandler );
				this.addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );*/
			super.initialize();

			this._titledTextBlock = new TitledTextBlock();
			this._titledTextBlock.verticalLayout = setTitledTextBlockLayout();

			this._titledTextBlock.layoutData = this.controlLayoutData;
			this._titledTextBlock.styleNameList.add( TitledTextBlock.TITLED_TEXT_BLOCK_ITEM_RENDERER );

			this.addChild( this._titledTextBlock );

		}

		override protected function preLayout():void {

			this.layout = defaultLayout();

		}

		protected function get titledTextBlock():TitledTextBlock {

			return _titledTextBlock;
		}

		protected function get controlLayoutData():ILayoutData {

			return _titledTextBlockLayoutData;
		}

		protected function set controlLayoutData( value:ILayoutData ):void {

			_titledTextBlockLayoutData = value;
		}

		private function removedFromStageHandler( event:Event ):void {

			this.touchID = -1;
		}
		
		

		private function touchHandler( event:TouchEvent ):void {

			if ( !this._isEnabled ) {
				// if we were disabled while tracking touches, clear the touch id.
				this.touchID = -1;
				return;
			}

			if ( this.touchID >= 0 ) {
				// a touch has begun, so we'll ignore all other touches.

				var touch:Touch = event.getTouch( this, null, this.touchID );

				if ( !touch ) {
					// this should not happen.
					return;
				}

				if ( touch.phase == TouchPhase.ENDED ) {
					touch.getLocation( this.stage, HELPER_POINT );
					var isInBounds:Boolean = this.contains( this.stage.hitTest( HELPER_POINT, true ));

					if ( isInBounds ) {
						this.isSelected = true;
					}

					// the touch has ended, so now we can start watching for a new one.
					this.touchID = -1;
				}
				return;
			} else {
				// we aren't tracking another touch, so let's look for a new one.

				touch = event.getTouch( this, TouchPhase.BEGAN );

				if ( !touch ) {
					// we only care about the began phase. ignore all other phases.
					return;
				}

				// save the touch ID so that we can track this touch's phases.
				this.touchID = touch.id;
			}
		}
	}
}
