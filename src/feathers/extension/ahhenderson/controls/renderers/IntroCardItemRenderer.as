package feathers.extension.ahhenderson.controls.renderers{

	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Label;
	import feathers.extension.ahhenderson.controls.IconLabel;
	import feathers.extension.ahhenderson.enums.CustomComponentPoolType;
	import feathers.extension.ahhenderson.enums.FeathersComponentPoolType;
	import feathers.extension.ahhenderson.themes.constants.FlatThemeCustomTextures;
	import feathers.skins.IStyleProvider;
	import feathers.utils.math.roundUpToNearest;
	
	import starling.display.Shape;
	import starling.events.Event;


	public class IntroCardItemRenderer extends DefaultCardItemRenderer {

		public function IntroCardItemRenderer() {

			super();
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
		override protected function get defaultStyleProvider():IStyleProvider
		{
			return IntroCardItemRenderer.globalStyleProvider;
		}
		
		private var _lblAvailabilityAndDuration:IconLabel;

		private var _lblDescription:Label;

		private var _lblGoals:IconLabel;

		private var _line:Shape;
 
		
		private var _smallTextFormat:ElementFormat;
		
		private var _titleTextFormat:ElementFormat;

		 
		public function get titleTextFormat():ElementFormat
		{
			return _titleTextFormat;
		}

		public function set titleTextFormat(value:ElementFormat):void
		{
			if ( this._titleTextFormat == value ) {
				return;
			}
			
			_titleTextFormat = value;
			
			this.invalidate( INVALIDATION_FLAG_DATA );
		}

		public function get smallTextFormat():ElementFormat
		{
			return _smallTextFormat;
		}

		public function set smallTextFormat(value:ElementFormat):void
		{
			if ( this._smallTextFormat == value ) {
				return;
			}
			
			_smallTextFormat = value;
			this.invalidate( INVALIDATION_FLAG_DATA );
		}

		override protected function commitData():void {

			super.commitData();

			//_program = _data as VzProgram;

			if ( this.data ) {

				if ( this._lblDescription ) {
					this._lblDescription.text = "test";
					
				}
				
				if ( this._lblGoals ) {
					this._lblGoals.text = "Weight loss, toning..."; 
					
				}
				
				if ( this._lblAvailabilityAndDuration ) {
					this._lblAvailabilityAndDuration.text = "9-60 minute workouts available Mon, Tues, Thurs, Fri & Sat.";
					
				}

			} else {

				if ( this._lblAvailabilityAndDuration ) {
					this._lblAvailabilityAndDuration.text = null;
				}
				
				if ( this._lblGoals ) {
					this._lblGoals.text = null;
				}
				
				if ( this._lblDescription ) {
					this._lblDescription.text = null;
				}
			}
		}

		/**
		 * @private
		 */
		override protected function image_completeHandler( event:Event ):void {

			_lblDescription.visible = _line.visible = _lblGoals.visible = _lblAvailabilityAndDuration.visible = true;

			super.image_completeHandler( event );

		}

		override protected function image_errorHandler( event:Event ):void {

			super.image_errorHandler( event );

		}

		override protected function initialize():void {

			super.initialize();

			//this.itemHasLabel=false;
			var scale:Number = this.fmgr.theme.scaledResolution;
			var labelPadding:Number = roundUpToNearest(3*scale,1);
			var iconSize:Number = roundUpToNearest(26*scale,2);
			var iconBounds:Rectangle = new Rectangle(0, 0, iconSize, iconSize);
			
			if ( !_lblDescription ) {
				_lblDescription = new Label();
				//this.poolMgr.borrowObj(BaseComponentPoolType.ICON_LABEL);
				addChild( _lblDescription );
			}

			if ( !this._line ) {
				_line = new Shape();
				this.addChild( this._line );
			}

			
			if ( !_lblGoals ) {
				_lblGoals = this.poolMgr.borrowObj(CustomComponentPoolType.ICON_LABEL);
				_lblGoals.iconId = FlatThemeCustomTextures.ICONS_BUTTON_CHECK;
				_lblGoals.firstGap=5*scale;
				_lblGoals.padding = labelPadding;
				_lblGoals.iconBounds = iconBounds;
				
				addChild( _lblGoals );
			}

			if ( !_lblAvailabilityAndDuration ) {
				
				_lblAvailabilityAndDuration = this.poolMgr.borrowObj(CustomComponentPoolType.ICON_LABEL);
				_lblAvailabilityAndDuration.iconId = FlatThemeCustomTextures.ICONS_BUTTON_CHECK;
				_lblAvailabilityAndDuration.firstGap=5*scale;
				_lblAvailabilityAndDuration.padding = labelPadding;
				_lblAvailabilityAndDuration.iconBounds = iconBounds;
				addChild( _lblAvailabilityAndDuration );
			}

			_lblDescription.visible = _line.visible = _lblGoals.visible = _lblAvailabilityAndDuration.visible = false;

		}

		override protected function layoutChildren():void {

			super.layoutChildren();

			var selectionInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_SELECTED );
			var sizeInvalid:Boolean = this.isInvalid( INVALIDATION_FLAG_SIZE );

			//sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;

			if ( sizeInvalid || selectionInvalid ) {

				//trace( "Image height: ", this.imageHeight, "\n\n" );

				var textWidth:Number = 100;//this._label.width;
				/*if(this.titleTextFormat){
					if(_label.textRendererProperties.elementFormat != this.titleTextFormat)
						_label.textRendererProperties.elementFormat = this.titleTextFormat;
				}*/
				if(this.smallTextFormat){
					
					if(_lblDescription.textRendererProperties.elementFormat != this.smallTextFormat)
						_lblDescription.textRendererProperties.elementFormat = this.smallTextFormat;
					
					if(_lblGoals.textRendererProperties.elementFormat != this.smallTextFormat)
						_lblGoals.textRendererProperties.elementFormat = this.smallTextFormat;
					
					if(_lblAvailabilityAndDuration.textRendererProperties.elementFormat != this.smallTextFormat)
						_lblAvailabilityAndDuration.textRendererProperties.elementFormat = this.smallTextFormat; 
					
				}
				
				this._lblDescription.validate();
				this._lblGoals.validate();
				this._lblAvailabilityAndDuration.validate();
				
				this._lblDescription.y = roundUpToNearest( this._label.y + this._label.baseline + this.padding, 2 )
				this._lblDescription.width = textWidth;
				this._lblDescription.x = this.padding;

				// Line
				/*_line.graphics.clear();
				_line.graphics.beginFill( 0xffffff, .4 );
				_line.graphics.drawRect( this.padding,
										 this._lblDescription.y + _lblDescription.baseline + this.padding,
										 this._lblDescription.width,
										 1 );
				_line.graphics.endFill();*/
				 
				this._lblGoals.y = roundUpToNearest( this._lblDescription.y + _lblDescription.baseline + (this.padding*2), 2 )
				this._lblGoals.width = textWidth;
				this._lblGoals.x = this.padding;
				
				this._lblAvailabilityAndDuration.y = roundUpToNearest( this._lblGoals.y + this._lblGoals.height, 2 )
				this._lblAvailabilityAndDuration.width = textWidth;
				this._lblAvailabilityAndDuration.x = this.padding;
				
			}
		}

		/**
		 * @private
		 */
		override protected function owner_scrollCompleteHandler( event:Event ):void {

			super.owner_scrollCompleteHandler( event );

		}

		override public function dispose():void{
			//this.poolMgr.returnObj(this._lblDescription);
			this.poolMgr.returnObj(this._lblGoals);
			this.poolMgr.returnObj(this._lblAvailabilityAndDuration);
			
			super.dispose();
		}
		
		/**
		 * @private
		 */
		override protected function owner_scrollStartHandler( event:Event ):void {

			super.owner_scrollStartHandler( event );

		}

		
	}
}
