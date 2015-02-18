//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.controls
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ahhenderson.core.managers.dependency.objectPool.interfaces.IPoolObject;
	import ahhenderson.core.ui.layout.VerticalAlign;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.extension.ahhenderson.helpers.AssetHelper;
	import feathers.extension.ahhenderson.helpers.LayoutHelper;
	import feathers.skins.IStyleProvider;
	import feathers.utils.math.roundDownToNearest;
	import feathers.utils.math.roundUpToNearest;
	
	import starling.textures.TextureSmoothing;

	public class IconLabel extends Label implements IPoolObject
	{
		
		
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
			
			return IconLabel.globalStyleProvider;
		}
		
		/**
		 * @private
		 */
		private static const HELPER_POINT:Point=new Point();

		private static const ITEM_NAME:String="icon-label";

		public function IconLabel()
		{

			super();
		}

		protected var _isIconInitialized:Boolean;

		private var _firstGap:Number=10;

		private var _icon:ImageLoader;

		private var _iconBounds:Rectangle=new Rectangle();

		private var _iconId:String="";
 
		private var _padding:Number=0;
 
		public function get firstGap():Number
		{

			return _firstGap;
		}

		public function set firstGap(value:Number):void
		{

			if (this._firstGap == value)
			{
				return;
			}
			this._firstGap=value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);

		}

		public function get iconBounds():Rectangle
		{

			return _iconBounds;
		}

		public function set iconBounds(value:Rectangle):void
		{

			if (this._iconBounds == value)
			{
				return;
			}
			this._iconBounds=value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}

		public function get iconId():String
		{

			return _iconId;
		}

		public function set iconId(value:String):void
		{

			if (this._iconId == value)
			{
				return;
			}
			this._iconId=value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}

		 

		override public function get padding():Number
		{

			return _padding;
		}

		override public function set padding(value:Number):void
		{

			if (this._padding == value)
			{
				return;
			}
			this._padding=value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);

		}

		/*override public function get poolType():IPoolType
		{
			return CommonControlPoolType.ICON_LABEL;
		}

		 

		override public function resetObject():void
		{
			this._iconId=null;
			this._firstGap=10;
			this._padding=0;
			this._iconBounds.width=this._iconBounds.height=0;
 
			this.text="";

		}*/

		/**
		 * If the component's dimensions have not been set explicitly, it will
		 * measure its content and determine an ideal size for itself. If the
		 * <code>explicitWidth</code> or <code>explicitHeight</code> member
		 * variables are set, those value will be used without additional
		 * measurement. If one is set, but not the other, the dimension with the
		 * explicit value will not be measured, but the other non-explicit
		 * dimension will still need measurement.
		 *
		 * <p>Calls <code>setSizeInternal()</code> to set up the
		 * <code>actualWidth</code> and <code>actualHeight</code> member
		 * variables used for layout.</p>
		 *
		 * <p>Meant for internal use, and subclasses may override this function
		 * with a custom implementation.</p>
		 */
		override protected function autoSizeIfNeeded():Boolean
		{

			var needsWidth:Boolean=this.explicitWidth != this.explicitWidth; //isNaN
			var needsHeight:Boolean=this.explicitHeight != this.explicitHeight; //isNaN

			if (!needsWidth && !needsHeight)
			{
				return false;
			}

			if (!_icon.source && _iconId)
			{
				this._icon.source=AssetHelper.getTexture(this._iconId);
			}

			var iconHeight:Number=0;
			var iconWidth:Number=0;

			if (_iconBounds.width > 0 && _iconBounds.height > 0)
			{

				iconHeight=roundUpToNearest(_icon.height + (this.padding * 2));
				iconWidth=roundDownToNearest(_icon.width + _firstGap);

				if (_icon.width != _iconBounds.width || _icon.height != _iconBounds.height)
				{
					this._icon.setSize(_iconBounds.width, _iconBounds.height);
				}
			}

			this.textRenderer.minWidth=this._minWidth - iconWidth;
			this.textRenderer.maxWidth=this._maxWidth - iconWidth;
			this.textRenderer.width=this.explicitWidth - iconWidth;
			this.textRenderer.minHeight=this._minHeight;
			this.textRenderer.maxHeight=this._maxHeight;
			this.textRenderer.height=this.explicitHeight;
			this.textRenderer.measureText(HELPER_POINT);

			var newWidth:Number=this.explicitWidth;

			if (needsWidth)
			{
				if (this._text)
				{
					newWidth=HELPER_POINT.x + iconWidth;
				}
				else
				{
					newWidth=0;
				}
			}

			var newHeight:Number=this.explicitHeight;

			if (needsHeight)
			{
				if (this._text)
				{
					newHeight=(iconHeight > 0) ? iconHeight : HELPER_POINT.y;
				}
				else
				{
					newHeight=0;
				}
			}

			return this.setSizeInternal(newWidth, newHeight, false);
		}

		override protected function initialize():void
		{

			super.initialize();

			this._icon=new ImageLoader();
			this._icon.touchable=false;
			this._icon.visible=false;
			this._icon.snapToPixels=true;
			this._icon.smoothing=TextureSmoothing.TRILINEAR;

			this.addChild(this._icon);



		}

		 protected function layout():void
		{

			if (this._icon && !this._icon.source && this._iconId)
			{
				this._icon.source=AssetHelper.getTexture(this._iconId);

				if ((_iconBounds.width == 0 || _iconBounds.height == 0) && this._icon.width > 0)
				{
					_iconBounds.width=_icon.width;
					_iconBounds.height=_icon.height;
				}

				this._icon.setSize(_iconBounds.width, _iconBounds.height);
			}


			// Only size 
			if (this._icon && this._icon.width > 0)
			{


				if (!this._icon.visible)
					this._icon.visible=true;

				// We want to keep this height the same
				this.textRenderer.height=this.actualHeight;

				this._icon.x=0;
				this._icon.y=LayoutHelper.getVerticalAlignmentY(VerticalAlign.MIDDLE, this.actualHeight, this._icon.height);
				this._icon.validate();
				var iconWidth:Number=roundDownToNearest(this._icon.width + this.firstGap);

				this.textRenderer.x=iconWidth;
				this.textRenderer.width=this.actualWidth - iconWidth;
				this.textRenderer.validate();
				//this._baseline=this.textRenderer.baseline;

				this.textRenderer.y=LayoutHelper.getVerticalAlignmentY(VerticalAlign.MIDDLE, this.actualHeight, this.textRenderer.baseline);

				this.textRenderer.validate();

				return;
			}

			this.textRenderer.width=this.actualWidth;
			this.textRenderer.height=this.actualHeight;
			this.textRenderer.validate();
			//this._baseline=this.textRenderer.baseline;
		}
	}
}

