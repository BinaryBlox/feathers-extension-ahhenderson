//------------------------------------------------------------------------------
//
//   ViziFit, Inc.  Copyright 2012  
//   All rights reserved. 
//
//------------------------------------------------------------------------------

/**
 * File: DrawingUtils.as
 * @Author: Tony Henderson
 * Purpose:

 */

package feathers.extension.ahhenderson.util {

	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.Graphics; 
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import feathers.utils.math.roundDownToNearest;
	import feathers.utils.math.roundToNearest;
	
	import starling.display.Image; 
	import starling.display.Shape;
	import starling.textures.Texture;

	public class DrawingUtils {

		private static var _matrix:Matrix;
	 
		
		public static function starlingDrawBorder(shape:Shape, width:Number, height:Number, padding:int=0, strokeThickness:int=1, strokeColor:uint=0x000000, strokeAlpha:Number=1, cornerRadius:Number=NaN):void{
			 
			shape.graphics.clear();
			shape.graphics.beginFill( 0x000000, 0 ); 
			shape.graphics.lineStyle( strokeThickness, strokeColor, strokeAlpha );
			
			var rectWidth:int = roundDownToNearest(width);
			var rectHeight:int = roundDownToNearest(height);
			
			/*else if ( shape ) {
				//_borderShape.graphics.drawRoundRectComplex(this.padding, this.padding, rectWidth, rectHeight, _complexCornerRadius., _rectangleRadius.top, _complexCornerRadius.bottom, _complexCornerRadius.bottomRight);
			}*/
			if ( isNaN(cornerRadius) ) {
				shape.graphics.drawRect( padding, padding, rectWidth, rectHeight );
				//_borderShape.graphics.drawRoundRect( this.padding, this.padding, rectWidth, rectHeight, cornerRadius );
			}  else {
				//_borderShape.graphics.drawRoundRect( this.padding, this.padding, rectWidth, rectHeight, cornerRadius );
				shape.graphics.drawRect(  padding,  padding, rectWidth, rectHeight );
			}
			
			shape.graphics.endFill();
			 
			
		}

		public static function drawCircle(radius:uint=15, bitmapFill:BitmapData=null, borderColor:uint=0xFFFFFF,  borderThickness:Number=2, borderAlpha:Number=0.6):BitmapData{
			 
			var shape:Sprite = new flash.display.Sprite();
		 
			// Bitmap or color fill 
			if(bitmapFill){
				
				shape.graphics.beginFill(borderColor, borderAlpha);
				shape.graphics.drawCircle(radius, radius, radius);
				shape.graphics.endFill();
				
				shape.graphics.beginBitmapFill(bitmapFill, null, false);
				shape.graphics.drawCircle(radius, radius, radius-(borderThickness*2));
				shape.graphics.endFill();
				
				
			}
			else{
				shape.graphics.beginFill(borderColor, borderAlpha);
				shape.graphics.drawCircle(radius, radius, radius);
				shape.graphics.endFill();
			}
			  
		
			var radiusWithPadding:Number =  (radius * 2); // + 8;
			
			var bmd:BitmapData = new BitmapData(radiusWithPadding, radiusWithPadding, true, borderColor);
			
			bmd.drawWithQuality(shape,null, null, null, null, true, StageQuality.BEST);
		  
			return  bmd; 
		} 
		
		public static function drawRectangleToTexture(scale:Number=1, rect:Rectangle=null, corner:Number=0, bitmapFill:BitmapData=null, borderColor:uint=0xFFFFFF,  borderThickness:Number=2, borderAlpha:Number=0.6):Texture{
			 
			return Texture.fromBitmapData(drawRectangle(scale, rect, corner, bitmapFill, borderColor, borderThickness, borderAlpha));
			 
		}
		
		public static function drawRectangleToImage(scale:Number=1, rect:Rectangle=null, corner:Number=0, bitmapFill:BitmapData=null, borderColor:uint=0xFFFFFF,  borderThickness:Number=2, borderAlpha:Number=0.6):Image{
			  
			return new Image(drawRectangleToTexture(scale, rect, corner, bitmapFill, borderColor, borderThickness, borderAlpha)); 
		}
		
		
		public static function drawRectangle(scale:Number=1, rect:Rectangle=null, corner:Number=0, bitmapFill:BitmapData=null, borderColor:uint=0xFFFFFF,  borderThickness:Number=2, borderAlpha:Number=0.6):BitmapData{
			
			var shape:Sprite = new flash.display.Sprite();
			
			rect.width = roundToNearest(rect.width);
			rect.height = roundToNearest(rect.height);
	 
			borderThickness = roundToNearest(borderThickness);
			// Bitmap or color fill 
			if(bitmapFill){
				
				if(borderThickness>0){
					shape.graphics.beginFill(borderColor, borderAlpha);
					shape.graphics.drawRoundRect(rect.y, rect.x, rect.width, rect.height, corner, corner);
					shape.graphics.endFill(); 
				}
				
				var udpatedWidth:Number= rect.width  - (borderThickness * 2);
				var udpatedHeight:Number= rect.height - (borderThickness * 2);
				 
			 	shape.graphics.beginBitmapFill(bitmapFill, null, false);
				shape.graphics.drawRoundRect(borderThickness, borderThickness, udpatedWidth, udpatedHeight, corner, corner);
				shape.graphics.endFill();  
			}
			else{
				shape.graphics.beginFill(borderColor, borderAlpha);
				shape.graphics.drawRoundRect(rect.y, rect.x, rect.width, rect.height, corner, corner);
				shape.graphics.endFill();
			}
			 
			var padding:Number =  6; //2 * Math.ceil(scale);  
			
			var bmd:BitmapData = new BitmapData(rect.width + 6,  rect.height + 6, true, borderColor);
			
			bmd.drawWithQuality(shape,null, null, null, null, true, StageQuality.BEST);
			
			return  bmd; 
		}
		public static function curvedBox(graphics:Graphics, x:Number, y:Number, w:Number, h:Number, radius:Number, gapType:String = "none", corners:Array = null):void {

			var circ:Number = 0.707107
			var off:Number = 0.6

			var tL:Number;
			var tR:Number;
			var bL:Number;
			var bR:Number;


			// Handle partial corners.
			if (corners && corners.length == 4) {
				tL=corners[0];
				bL=corners[1];
				bR=corners[2];
				tR=corners[3];
			} else
				tL=tR=bL=bR=radius;

			graphics.moveTo(x + 0, y + bL);
			graphics.lineTo(x + 0, y + h - bL);
			graphics.curveTo(x + 0, y + (h - bL) + bL * (1 - off), x + 0 + (1 - circ) * bL, y + h - (1 - circ) * bL);
			graphics.curveTo(x + (0 + bL) - bL * (1 - off), y + h, x + bL, y + h);

			if (gapType && gapType == "bottom") {
				graphics.moveTo(x + w - bR, y + h);
			} else
				graphics.lineTo(x + w - bR, y + h);

			graphics.curveTo(x + (w - bR) + bR * (1 - off), y + h, x + w - (1 - circ) * bR, y + h - (1 - circ) * bR);
			graphics.curveTo(x + w, y + (h - bR) + bR * (1 - off), x + w, y + h - bR);
			graphics.lineTo(x + w, y + 0 + tR);
			graphics.curveTo(x + w, y + tR - tR * (1 - off), x + w - (1 - circ) * tR, y + 0 + (1 - circ) * tR);
			graphics.curveTo(x + (w - tR) + tR * (1 - off), y + 0, x + w - tR, y + 0);

			if (gapType && gapType == "top") {
				graphics.moveTo(x + tL, y + 0);
			} else
				graphics.lineTo(x + tL, y + 0);

			graphics.lineTo(x + tL, y + 0);
			graphics.curveTo(x + tL - tL * (1 - off), y + 0, x + (1 - circ) * tL, y + (1 - circ) * tL);
			graphics.curveTo(x + 0, y + tL - tL * (1 - off), x + 0, y + tL);
		}


		public static function curvedBoxWithTail(graphics:Graphics,
												 x:Number,
												 y:Number,
												 w:Number,
												 h:Number,
												 radius:Number,
												 tailWidth:int,
												 tailHeight:int,
												 tailOrientation:String = "top",
												 tailOffset:Number = 0,
												 hideBottomRadius:Boolean = false,
												 hideTopRadius:Boolean = false):void {

			var circ:Number = 0.707107
			var off:Number = 0.6
			var radiusInput:Number = radius;
			var bUseTailOffset:Boolean;
			var leftOffset:Number;
			var rightOffset:Number;
			var centerOffset:Number;


			leftOffset=(x + (w / 2)) + (tailWidth / 2);
			rightOffset=(x + (w / 2)) - (tailWidth / 2);
			centerOffset=(x + (w / 2));

			if (tailOffset != 0) {
				bUseTailOffset=true;

				leftOffset+=tailOffset;
				rightOffset+=tailOffset;
				centerOffset+=tailOffset;
			}

			// TODO: Set boundaries of tail offset.


			if (hideBottomRadius)
				radius=0;

			graphics.moveTo(x + 0, y + radius);
			graphics.lineTo(x + 0, y + h - radius);
			graphics.curveTo(x + 0, y + (h - radius) + radius * (1 - off), x + 0 + (1 - circ) * radius, y + h - (1 - circ) * radius);
			graphics.curveTo(x + (0 + radius) - radius * (1 - off), y + h, x + radius, y + h);

			// Build arrow on bottom
			if (tailOrientation == "bottom") {

				graphics.lineTo(rightOffset, y + h);
				graphics.lineTo(centerOffset, y + h + tailHeight);
				graphics.lineTo(leftOffset, y + h);
			}

			graphics.lineTo(x + w - radius, y + h);
			graphics.curveTo(x + (w - radius) + radius * (1 - off), y + h, x + w - (1 - circ) * radius, y + h - (1 - circ) * radius);
			graphics.curveTo(x + w, y + (h - radius) + radius * (1 - off), x + w, y + h - radius);
			graphics.lineTo(x + w, y + 0 + radius);

			if (hideTopRadius)
				radius=0;
			else
				radius=radiusInput;


			graphics.curveTo(x + w, y + radius - radius * (1 - off), x + w - (1 - circ) * radius, y + 0 + (1 - circ) * radius);
			graphics.curveTo(x + (w - radius) + radius * (1 - off), y + 0, x + w - radius, y + 0);

			// Build arrow on top
			if (tailOrientation == "top") {
				graphics.lineTo(leftOffset, y + 0);
				graphics.lineTo(centerOffset, y - tailHeight);
				graphics.lineTo(rightOffset, y + 0);
			}

			graphics.lineTo(x + radius, y + 0);
			graphics.curveTo(x + radius - radius * (1 - off), y + 0, x + (1 - circ) * radius, y + (1 - circ) * radius);
			graphics.curveTo(x + 0, y + radius - radius * (1 - off), x + 0, y + radius);
		}



		public static function curvedGradientBox(graphics:Graphics,
												 x:Number,
												 y:Number,
												 w:Number,
												 h:Number,
												 radius:Number,
												 gapType:String = "none",
												 fillColors:Array = null,
												 fillRatios:Array = null,
												 fillAlphas:Array = null,
												 focalYOffset:Number = 0,
												 corners:Array = null):void {

			var circ:Number = 0.707107
			var off:Number = 0.6

			// Don't create a new Matrix everytime(this will add up on all the redraws)
			if (!_matrix)
				_matrix=new Matrix();

			_matrix.createGradientBox(w, h, Math.PI / 2, 0, focalYOffset);

			if (!fillColors)
				fillColors=[0x00FF00, 0x000088];

			if (!fillRatios)
				fillRatios=[0, 255];

			if (!fillAlphas)
				fillAlphas=[1, 1];


			graphics.beginGradientFill(GradientType.LINEAR, fillColors, fillAlphas, fillRatios, _matrix, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB, 0);

			curvedBox(graphics, x, y, w, h, radius, gapType, corners);

			graphics.endFill();
		}

		
		public static function drawGradientCircle(graphics:Graphics,
												 x:Number,
												 y:Number,
												 radius:Number,   
												 fillColors:Array = null,
												 fillRatios:Array = null,
												 fillAlphas:Array = null,	
												 border:Boolean=false,
												 shadow:Boolean = false,
												 borderColor:uint=0xFFFFFF,
												 borderThickness:int=1,  
												 shadowColor:uint = 0x000000,
												 shadowDistance:int = 1 ):void {
			
			var circ:Number = 0.707107
			var off:Number = 0.6
			
			// Don't create a new Matrix everytime(this will add up on all the redraws)
			if (!_matrix)
				_matrix=new Matrix();
			
			_matrix.createGradientBox(radius*2, radius*2, Math.PI / 2, 0, 0);
			
			if (!fillColors)
				fillColors=[0x00FF00, 0x000088];
			
			if (!fillRatios)
				fillRatios=[0, 255];
			
			if (!fillAlphas)
				fillAlphas=[1, 1];
			 
			graphics.beginGradientFill(GradientType.LINEAR, fillColors, fillAlphas, fillRatios, _matrix, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB, 0);
			
			if(border) 
				graphics.lineStyle(borderThickness, borderColor, 1 , false, "normal", CapsStyle.ROUND);	
			else
				graphics.lineStyle(0, 0, 0 , false, "normal", CapsStyle.ROUND);	
			
			graphics.drawCircle( x, y, radius );
			 
			graphics.endFill();
		}

		public static function curvedGradientBoxStroke(graphics:Graphics,
													   weight:Number,
													   x:Number,
													   y:Number,
													   w:Number,
													   h:Number,
													   radius:Number,
													   gapType:String = "none",
													   fillColors:Array = null,
													   fillRatios:Array = null,
													   fillAlphas:Array = null,
													   focalYOffset:Number = 0,
													   corners:Array = null):void {

			var circ:Number = 0.707107
			var off:Number = 0.6

			// Don't create a new Matrix everytime(this will add up on all the redraws)
			if (!_matrix)
				_matrix=new Matrix();

			_matrix.createGradientBox(w, h, Math.PI / 2, 0, focalYOffset);

			if (!fillColors)
				fillColors=[0x00FF00, 0x000088];

			if (!fillRatios)
				fillRatios=[0, 255];

			if (!fillAlphas)
				fillAlphas=[1, 1];

			graphics.lineStyle(weight);

			graphics.lineGradientStyle(GradientType.LINEAR,
									   fillColors,
									   fillAlphas,
									   fillRatios,
									   _matrix,
									   SpreadMethod.PAD,
									   InterpolationMethod.LINEAR_RGB,
									   0);

			//graphics.beginGradientFill(GradientType.LINEAR, fillColors, fillAlphas, fillRatios, _matrix, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB, 0);
			curvedBox(graphics, x, y, w, h, radius, gapType, corners);

			graphics.endFill();
		}


		public static function drawGradientLine(graphics:Graphics,
												x:Number,
												y:Number,
												thickness:Number,
												length:Number,
												gradientType:String = GradientType.RADIAL,
												fillColors:Array = null,
												fillRatios:Array = null,
												fillAlphas:Array = null,
												stretchRatio:Number = .8,
												focalYOffset:Number = 80):void {

			// Don't create a new Matrix everytime(this will add up on all the redraws)
			if (!_matrix)
				_matrix=new Matrix();

			var stretchRatioValue:Number;

			var boxHeight:Number = 200;
			var boxWidth:Number = length;

			stretchRatioValue=boxWidth * stretchRatio;

			var focalY:Number = (focalYOffset + y) + (((boxHeight / 2) + thickness) * -1);
			var focalX:Number = x - (stretchRatioValue / 2);

			if (!fillColors)
				fillColors=[0x00FF00, 0x000088];

			if (!fillRatios)
				fillRatios=[0, 255];

			if (!fillAlphas)
				fillAlphas=[1, 1];

			_matrix.createGradientBox(boxWidth + stretchRatioValue, boxHeight, 0, focalX, focalY);

			graphics.lineStyle(thickness);

			graphics.lineGradientStyle(gradientType,
									   fillColors,
									   fillAlphas,
									   fillRatios,
									   _matrix,
									   SpreadMethod.PAD,
									   InterpolationMethod.LINEAR_RGB,
									   0);
			graphics.moveTo(x, y);
			/*graphics.lineTo(x, y)*/
			graphics.lineTo(x + length, y);
			graphics.endFill();
		}


		//override protected function updateBackground( display:Graphics, width:int, height:int ):void
		//{
		/*super.updateBackground( display, width, height );
		var length:Number = width * 0.5;
		var depth:Number = height * 0.14;
		display.lineStyle( 2, 0xCCCCCC, 1, true, "normal", "square", "miter" );
		display.beginFill( 0x999999 );
		display.moveTo( length * 0.5, ( height * 0.5 ) - depth  );
		display.lineTo( ( width - ( length * 0.5 ) ), ( height * 0.5 ) - depth );
		display.lineStyle( 2, 0x666666, 1, true, "normal", "square", "miter" );
		display.lineTo( width * 0.5, ( height * 0.5 ) + depth );
		display.lineStyle( 2, 0xCCCCCC, 1, true, "normal", "square", "miter" );
		display.moveTo( length * 0.5, ( height * 0.5 ) - depth  );
		display.endFill();*/
		//}
		public static function drawTriangle(graphics:Graphics,
											x:int,
											y:int,
											height:int,
											width:int,
											direction:String,
											fillColors:Array=null,
											fillRatios:Array=null,
											fillAlphas:Array=null,
											border:Boolean=false,
											shadow:Boolean = false,
											borderColor:uint=0xFFFFFF,
											borderThickness:int=1,  
											shadowColor:uint = 0x000000,
											shadowDistance:int = 1):void {
 
			var point1:Point;
			var point2:Point;
			var point3:Point;
 
			var verticies:Vector.<Number>;
			var shadowVerticies:Vector.<Number>;
 
			if(border){
				height = height-(borderThickness*2);
				width = width-(borderThickness*2);
			}
			
			if(!fillColors)
				fillColors = [0xFFFFFF];
			
			switch (direction) {

				case "top":
					point1=new Point(x, y + height);
					point2=new Point(x + (width / 2), y);
					point3=new Point(x + width, y + height);
					break;

				case "bottom":
					point1=new Point(x, y);
					point2=new Point(x + (width / 2), y + height);
					point3=new Point(x + width, y);
					break;
				
				case "right":
					point1=new Point(x, y);
					point2=new Point(x + (height / 2), y + (width/2));
					point3=new Point(x, y + width);
					break;
				
				
				case "left":
					point1=new Point(x, y);
					point2=new Point(x - (height / 2), y + (width/2));
					point3=new Point(x, y + width);
					break;
				default:

					break;

			}

			verticies=Vector.<Number>([point1.x, point1.y, point2.x, point2.y, point3.x, point3.y]);

			if (shadow) {
				shadowVerticies=Vector.<Number>([point1.x + shadowDistance, point1.y + shadowDistance, point2.x + shadowDistance, point2.y + shadowDistance, point3.x + shadowDistance, point3.y + shadowDistance]);

				graphics.beginFill(shadowColor, 1);
				
				if(border)
					graphics.lineStyle(borderThickness, shadowColor, 1 , false, "normal", CapsStyle.ROUND);
				else
					graphics.lineStyle(0, 0, 0 , false, "normal", CapsStyle.ROUND);	
				
				graphics.drawTriangles(shadowVerticies);
				graphics.endFill();
			}
 
			graphics.beginGradientFill(GradientType.LINEAR, fillColors, fillAlphas, fillRatios, null, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB, 0);
			
			if(border) 
				graphics.lineStyle(borderThickness, borderColor, 1 , false, "normal", CapsStyle.ROUND);	
			else
				graphics.lineStyle(0, 0, 0 , false, "normal", CapsStyle.ROUND);	
			//graphics.lineStyle(2, fillColors[0], 1, false, "normal", CapsStyle.ROUND);
			graphics.drawTriangles(verticies);
			graphics.endFill();

		/*	graphics.beginFill(0xffffff, .32);
			graphics.lineStyle(2, 0xFFFFFF, 1, false, "normal", CapsStyle.ROUND);
			graphics.drawTriangles(verticies);
			graphics.endFill();*/

		/*	  point1 = new Point(0, 0);
			  point2 = new Point(25, -25);
			  point3  = new Point(50, 0);
			*/
		/*	graphics.beginFill(0xffffff, 0);
			graphics.lineStyle(2, 0xff0000, 1);
			graphics.drawTriangles(verticies);
			graphics.endFill();*/


		/*	graphics.beginFill(0x00FF00, 0);
			graphics.lineStyle(2, 0xFFFFFF, 1, false, "normal", CapsStyle.ROUND);
			graphics.moveTo(x - (width / 2), y + height);
			graphics.lineTo(x, y);
			graphics.moveTo(x, y);
			graphics.lineTo(x + (width / 2), y + height);*/
			//graphics.lineTo(200 + triangleHeight / 2, 0); 
			//graphics.endFill();
		}


		public static function initAlphasArray(count:int, alphas:Array, alpha:Number = 1.0):Array {

			alphas=[];

			for (var i:int=0; i < count; i++)
				alphas[i]=alpha;

			return alphas;
		}


		public static function initRatiosArray(count:int, ratios:Array):Array {

			ratios=[];

			for (var i:int=0; i < count; i++)
				ratios[i]=Math.floor(255 * (i / (count - 1)));

			return ratios;
		}
	}
}
