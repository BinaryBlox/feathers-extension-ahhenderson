//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.helpers {
	import flash.geom.Rectangle;
	
	import ahhenderson.core.ui.enums.AspectRatioType;
	import ahhenderson.core.ui.layout.HorizontalAlign;
	import ahhenderson.core.ui.layout.VerticalAlign;
	
	import feathers.controls.Scroller;
	import feathers.core.FeathersControl;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_ThemeConstants;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.utils.math.roundToNearest;
	
	import starling.display.DisplayObject;

	/**
	 *
	 * @author developer
	 */
	/**
	 *
	 * @author developer
	 */
	/**
	 * 
	 * @author thenderson
	 */
	public class LayoutHelper {

		/**
		 * 
		 * @default 
		 */
		public static const ABOVE:String="above";

		/**
		 * 
		 * @default 
		 */
		public static const BELOW:String="below";

		/**
		 * 
		 * @default 
		 */
		public static const LEFT:String="left";

		/**
		 * 
		 * @default 
		 */
		public static const RIGHT:String="right";

		/**
		 * Function sets the minTouchHeight & minTouchWidth (based on multiplier and minHeight/minWidth)
		 * 
		 * @param control - Feather control only
		 * @param multiplier - The value reflecting the touch boundary (perimeter is generally larger)
		 */
		public static function setTouchBoundaries(control:FeathersControl, multiplier:Number=NaN):void{
			 
			if(!(control is FeathersControl))
				throw new TypeError("Control is not of FeathersControl type.");
				
			if(isNaN(multiplier))
				multiplier = FeathersExtLib_ThemeConstants.TOUCH_BOUNDARY_MULTIPLIER;
			
			control.minTouchHeight = roundToNearest(control.minHeight * multiplier);
			control.minTouchWidth = roundToNearest(control.minWidth * multiplier);
			 
		}
		
		
		
		/**
		 * 
		 * @param ratio
		 * @param width
		 * @param snapPixels
		 * @return 
		 */
		public static function getAspectRatioHeight(ratio:AspectRatioType, width:Number=NaN, snapPixels:Boolean=true):Number {

			if (isNaN(width))
				return NaN;

			var convertedValue:Number=NaN;

			switch (ratio) {
				case AspectRatioType.RATIO_DEFAULT:
					convertedValue=width * 1;

				case AspectRatioType.RATIO_4X3:
					convertedValue=width * (3 / 4);

				case AspectRatioType.RATIO_16X9:
					convertedValue=width * (9 / 16);

				case AspectRatioType.RATIO_16X10:
					convertedValue=width * (10 / 16);

			}

			if (snapPixels && !isNaN(convertedValue))
				return LayoutHelper.toNearestEvenPixel(convertedValue);

			return convertedValue;
		}

		/**
		 * 
		 * @param ratio
		 * @param height
		 * @param snapPixels
		 * @return 
		 */
		public static function getAspectRatioWidth(ratio:AspectRatioType, height:Number=NaN, snapPixels:Boolean=true):Number {

			if (isNaN(height))
				return NaN;

			var convertedValue:Number=NaN;

			switch (ratio) {

				case AspectRatioType.RATIO_DEFAULT:
					convertedValue=height * 1;

				case AspectRatioType.RATIO_4X3:
					convertedValue=height * (4 / 3);

				case AspectRatioType.RATIO_16X9:
					convertedValue=height * (16 / 9);

				case AspectRatioType.RATIO_16X10:
					convertedValue=height * (16 / 10);
			}

			if (snapPixels && !isNaN(convertedValue))
				return LayoutHelper.toNearestEvenPixel(convertedValue);

			return convertedValue;
		}

		/**
		 * 
		 * @param hAlign
		 * @param containerWidth
		 * @param objectWidth
		 * @param padding
		 * @return 
		 */
		public static function getHorizontalAlignX(hAlign:String=HorizontalAlign.CENTER, containerWidth:Number=0, objectWidth:Number=0, padding:int=0):int {

			switch (hAlign) {
				case HorizontalAlign.CENTER:
					return getHorAlignCenter(containerWidth, objectWidth, padding);

				case HorizontalAlign.LEFT:
					return padding;

				case HorizontalAlign.RIGHT:
					return getHorAlignRight(containerWidth, objectWidth, padding);

				default:
					return getHorAlignCenter(containerWidth, objectWidth, padding);

			}
		}

		/**
		 * 
		 * @param scale
		 * @param hAlign
		 * @param vAlign
		 * @param gap
		 * @param padding
		 * @return 
		 */
		public static function getHorizontalLayout(scale:Number=1, hAlign:String=HorizontalAlign.LEFT, vAlign:String=VerticalAlign.MIDDLE, gap:Number=10, padding:AnchorLayoutData=null):HorizontalLayout {

			const layout:HorizontalLayout=new HorizontalLayout();

			var pTop:Number=gap * scale;
			var pBottom:Number=gap * scale;
			var pRight:Number=gap * scale;
			var pLeft:Number=gap * scale;

			if (padding) {
				pTop=padding.top;
				pBottom=padding.bottom;
				pRight=padding.right;
				pLeft=padding.left;
			}

			layout.gap=gap;
			layout.paddingTop=pTop;
			layout.paddingRight=pRight;
			layout.paddingBottom=pBottom;
			layout.paddingLeft=pLeft;
			layout.horizontalAlign=hAlign;
			layout.verticalAlign=vAlign;
			layout.manageVisibility=true;

			return layout;
		}

		/**
		 * 
		 * @param x
		 * @param y
		 * @param width
		 * @param height
		 * @param toNearestEvenPixel
		 * @return 
		 */
		public static function getPixelSnappedRect(x:Number=0, y:Number=0, width:Number=0, height:Number=0, toNearestEvenPixel:Boolean=false):Rectangle {

			if (toNearestEvenPixel) {

				return new Rectangle(toNearestEvenPixel(x), toNearestEvenPixel(y), toNearestEvenPixel(width), toNearestEvenPixel(height));

			}
			return new Rectangle(Math.floor(x), Math.floor(y), Math.floor(width), Math.floor(height));

		}

		/**
		 * 
		 * @param paging
		 * @param tileHAlign
		 * @param layoutHAlign
		 * @param useSquareTiles
		 * @param manageVisibility
		 * @return 
		 */
		public static function getTiledRowsLayout(paging:String=TiledRowsLayout.PAGING_HORIZONTAL, tileHAlign:String=TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER, layoutHAlign:String=TiledRowsLayout.HORIZONTAL_ALIGN_CENTER, useSquareTiles:Boolean=false, manageVisibility:Boolean=true):TiledRowsLayout {

			const listLayout:TiledRowsLayout=new TiledRowsLayout();
			listLayout.paging=paging;
			listLayout.useSquareTiles=useSquareTiles;
			listLayout.tileHorizontalAlign=tileHAlign;
			listLayout.horizontalAlign=layoutHAlign;
			listLayout.manageVisibility=manageVisibility;

			return listLayout;

		}

		/*public static function getValue(property:LayoutType):* {

			if (AppMgr.instance.conf.layout.itemExists(property)) {
				return AppMgr.instance.conf.layout.getItem(property);
			}

			return null;

		}*/

		/**
		 * 
		 * @param vAlign
		 * @param containerHeight
		 * @param objectHeight
		 * @param padding
		 * @return 
		 */
		public static function getVerticalAlignmentY(vAlign:String=VerticalAlign.TOP, containerHeight:Number=0, objectHeight:Number=0, padding:int=0):int {

			switch (vAlign) {
				case VerticalAlign.MIDDLE:
					return getVertAlignMiddle(containerHeight, objectHeight, padding);

				case VerticalAlign.TOP:
					return padding;

				case VerticalAlign.BOTTOM:
					return getVertAlignBottom(containerHeight, objectHeight, padding);

				default:
					return getVertAlignMiddle(containerHeight, objectHeight, padding);

			}
		}

		/**
		 * 
		 * @param scale
		 * @param hAlign
		 * @param vAlign
		 * @param gap
		 * @param padding
		 * @return 
		 */
		public static function getVerticalLayout(scale:Number=1, hAlign:String=HorizontalAlign.LEFT, vAlign:String=VerticalAlign.TOP, gap:Number=0, padding:AnchorLayoutData=null):VerticalLayout {

			const layout:VerticalLayout=new VerticalLayout();

			var pTop:Number=gap * scale;
			var pBottom:Number=gap * scale;
			var pRight:Number=gap * scale;
			var pLeft:Number=gap * scale;

			if (padding) {
				pTop=padding.top;
				pBottom=padding.bottom;
				pRight=padding.right;
				pLeft=padding.left;
			}

			layout.gap=gap;
			layout.paddingTop=pTop;
			layout.paddingRight=pRight;
			layout.paddingBottom=pBottom;
			layout.paddingLeft=pLeft;
			layout.horizontalAlign=hAlign;
			layout.verticalAlign=vAlign;
			layout.manageVisibility=true;

			return layout;
		}

		/**
		 * 
		 * @param scrollerProperties
		 * @param displayMode
		 * @param hScrollPolicy
		 * @param vScrollPolicy
		 * @param snapScrollToPixels
		 */
		public static function getDefaultScreenScrollerProperties(scrollerProperties:Object, displayMode:String=Scroller.SCROLL_BAR_DISPLAY_MODE_NONE, hScrollPolicy:String=Scroller.SCROLL_POLICY_OFF, vScrollPolicy:String=Scroller.SCROLL_POLICY_OFF, snapScrollToPixels:Boolean=true):void {

			scrollerProperties.scrollBarDisplayMode=displayMode;
			scrollerProperties.horizontalScrollPolicy=hScrollPolicy;
			scrollerProperties.verticalScrollPolicy=vScrollPolicy;
			scrollerProperties.snapScrollPositionsToPixels=snapScrollToPixels;

		}



		/**
		 * 
		 * @param displayObject
		 * @param gap
		 * @param placement
		 * @return 
		 */
		public static function positionDisplayObject(displayObject:Object, gap:int=10, placement:String=LayoutHelper.BELOW):Number {

			var height:Number=-1;
			var width:Number=-1;
			var y:int=-1;
			var x:int=-1;

			if (displayObject.hasOwnProperty("height") && displayObject.hasOwnProperty("y")) {
				height=displayObject.height;
				y=displayObject.y;
			}

			if (displayObject.hasOwnProperty("width") && displayObject.hasOwnProperty("x")) {
				width=displayObject.width;
				x=displayObject.y;
			}


			switch (placement) {

				case ABOVE:
					return y - (height + gap);

				case BELOW:
					return y + height + gap;

				case RIGHT:
					return x + width + gap;
					break;

				case LEFT:
					return x - (width + gap);
					break;
			}

			return -1;

		}


		/**
		 * 
		 * @param value
		 * @param roundUp
		 * @return 
		 * @throws Error
		 */
		public static function toNearestEvenPixel(value:Number, roundUp:Boolean=false):Number {

			var evenValue:Number;

			try {
 
				if (value % 2 != 0){
					
					return (roundUp) ? Math.ceil(value + 1) : Math.ceil(value - 1);
				}
				 
				return value;

			} catch (error:Error) {
				throw new Error("toNearestEvenPixel function failed: " + error.message);
			}

			return value;
		}

		private static function getHorAlignCenter(containerWidth:Number, objectWidth:Number, offset:Number=0):Number {

			if (containerWidth < objectWidth)
				return 0;

			return toNearestEvenPixel(((containerWidth / 2) - (objectWidth / 2)) + offset);
		}


		private static function getHorAlignRight(containerWidth:Number, objectWidth:Number, offset:Number=0):Number {

			if (containerWidth < objectWidth)
				return 0;

			return toNearestEvenPixel(containerWidth - (objectWidth + offset));

		}

		private static function getVertAlignBottom(containerHeight:Number, objectHeight:Number, offset:Number=0):Number {

			if (containerHeight < objectHeight)
				return 0;

			return toNearestEvenPixel(containerHeight - (objectHeight + offset));

		}


		private static function getVertAlignMiddle(containerHeight:Number, objectHeight:Number, offset:Number=0):Number {

			if (containerHeight < objectHeight)
				return 0;


			return toNearestEvenPixel(((containerHeight / 2) - (objectHeight / 2)) + offset);
		}
	}
}
