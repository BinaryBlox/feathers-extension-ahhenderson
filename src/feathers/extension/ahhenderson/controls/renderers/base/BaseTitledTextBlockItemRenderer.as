package feathers.extension.ahhenderson.controls.renderers.base {
 
	import flash.geom.Point;
	
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.IFeathersControl;
	import feathers.extension.ahhenderson.controls.TitledTextBlock;
	import feathers.extension.ahhenderson.enums.CustomComponentPoolType;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.ILayout;
	import feathers.layout.ILayoutData;
	import feathers.layout.VerticalLayout;
	import feathers.skins.IStyleProvider;
	import feathers.utils.math.roundToNearest;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
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

		protected var _labelIcon:Image;
		
		protected var _drillDownIcon:Image;

		protected var _padding:Number = 0;

		protected var _titledTextBlock:TitledTextBlock;

		protected var touchID:int = -1;

		private const ACCESSORY_PERCENT_WIDTH:Number = 40;

		private const CONTENT_PERCENT_WIDTH:Number = 100;

		private var _accessoryPercentWidth:Number = NaN;

		private var _fmgr:FeathersApplicationManager;

		private var _titledTextBlockLayoutData:ILayoutData;
		
		private var _customTitleTextBlockStylename:String;
		
		public function get customTitleTextBlockStylename():String
		{
			return this._customTitleTextBlockStylename;
		}
		
		/**
		 * The default <code>IStyleProvider</code> for all <code>ToggleButton</code>
		 * components. If <code>null</code>, falls back to using
		 * <code>Button.globalStyleProvider</code> instead.
		 *
		 * @default null
		 * @see feathers.core.FeathersControl#styleProvider
		 * @see feathers.controls.Button#globalStyleProvider
		 */
		public static var globalStyleProvider:IStyleProvider;
		
		
		/**
		 * @private
		 */
		override protected function get defaultStyleProvider():IStyleProvider {
			
			return BaseTitledTextBlockItemRenderer.globalStyleProvider;
		}
		
		/**
		 * @private
		 */
		public function set customTitleTextBlockStylename(value:String):void
		{
			if(this._customTitleTextBlockStylename == value)
			{
				return;
			}
			
			this._customTitleTextBlockStylename = value;
			
			if(!this._titledTextBlock)
				return;
			
			var doValidation:Boolean;
			
			// Remove default if it exists
			if(this._titledTextBlock.styleNameList.contains(TitledTextBlock.TITLED_TEXT_BLOCK_ITEM_RENDERER)){
				this._titledTextBlock.styleNameList.remove(TitledTextBlock.TITLED_TEXT_BLOCK_ITEM_RENDERER);
				doValidation=true;
			}
			
			if(!this._titledTextBlock.styleNameList.contains(this._customTitleTextBlockStylename)){
				this._titledTextBlock.styleNameList.add(this._customTitleTextBlockStylename);
				doValidation=true;
			}
			
			if(doValidation)
				this._titledTextBlock.validate();
		}

		override public function dispose():void {

			removeHandlers();
			
			super.dispose();

		}
		
		override public function set isSelected(value:Boolean):void{
			
			if (this._isSelected == value) {
				return;
			}
			
			//trace("Select class item");
			if (this.backgroundSkin) {
				
				this.backgroundSkin.visible = value
				/*if (value && !selectedBackground.visible) {
					 
				} else {
					this.selectedBackground.visible = value;  
				}*/
			}
			
			// Only allow child events from selected item.
			//this.isQuickHitAreaEnabled = (value) ? false : true;
			this._isSelected = value;
			this.dispatchEventWith(Event.CHANGE);
		}
		public function removeHandlers():void{
			this.removeEventListener( TouchEvent.TOUCH, touchHandler );
			this.removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}
		
		public function addHandlers():void{
			this.addEventListener( TouchEvent.TOUCH, touchHandler );
			this.addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
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

		protected function addIconToDisplayList( icon:Image, position:int=-1 ):void {

			if ( !icon ) {
				return;
			}

			icon.smoothing = TextureSmoothing.NONE;
			icon.width = roundToNearest( icon.width );
			icon.height = roundToNearest( icon.height );

			if(position>-1){
				this.addChildAt( icon, position );
			}
			else{
				this.addChild(icon);
			}
			
		}
		 
 
		override protected function commitData():void {

			if ( this._data && this._owner ) {
				//this._label.text = this._data.title;

				this._titledTextBlock.title = this.data.title;
				this._titledTextBlock.content = this.data.content;
				this._accessoryPercentWidth = this.data.accessoryPercentWidth;

				// Add label icon
				if ( this.data.icon && this.data.icon as Texture ) {
 
					if ( this._labelIcon && this.contains( this._labelIcon )) {

						if ( this._labelIcon.texture !== ( this.data.icon as Texture )) {

							this.removeChild( this._labelIcon, true );
							this._labelIcon = new Image( this.data.icon as Texture );
							addIconToDisplayList( this._labelIcon, 0 );
						}
					} else {
						this._labelIcon = new Image( this.data.icon as Texture );
						addIconToDisplayList( this._labelIcon, 0 );
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
				
				// Add drilldown icon
				if ( this.data.drillDownIcon && this.data.drillDownIcon as Texture ) {
					
					if ( this._drillDownIcon && this.contains( this._drillDownIcon )) {
						
						if ( this._drillDownIcon.texture !== ( this.data.drillDownIcon as Texture )) {
							
							this.removeChild( this._drillDownIcon, true );
							this._drillDownIcon = new Image( this.data.drillDownIcon as Texture );
							addIconToDisplayList( this._drillDownIcon, this.numChildren );
						}
					} else {
						this._drillDownIcon = new Image( this.data.drillDownIcon as Texture );
						addIconToDisplayList( this._drillDownIcon, this.numChildren );
					}
				}
				
			} else {
				//this._label.text = null;
				this._titledTextBlock.title = null;
				this._titledTextBlock.content = null;

				if ( this._labelIcon && this.contains( this._labelIcon )) {
					this.removeChild( this._labelIcon, true );
				}

				if ( this._drillDownIcon && this.contains( this._drillDownIcon )) {
					this.removeChild( this._drillDownIcon, true );
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

		protected var selectedBackground:Quad;
		
		override protected function initialize():void {

			addHandlers()
				
			this.backgroundSkin = new Quad(10, 10, 0x000000);
			this.backgroundSkin.alpha=.1;
			this.backgroundSkin.visible=false;
			
			super.initialize();

			this._titledTextBlock =  fmgr.pool.borrowObj(CustomComponentPoolType.TITLED_TEXT_BLOCK);
			this._titledTextBlock.verticalLayout = setTitledTextBlockLayout();

			this._titledTextBlock.layoutData = this.controlLayoutData;
			
			if(this.customTitleTextBlockStylename && !(this._titledTextBlock.styleNameList.contains(this.customTitleTextBlockStylename))){ 
				this._titledTextBlock.styleNameList.add( this.customTitleTextBlockStylename );
			}
			else{
				this._titledTextBlock.styleNameList.add( TitledTextBlock.TITLED_TEXT_BLOCK_ITEM_RENDERER );
			}

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
