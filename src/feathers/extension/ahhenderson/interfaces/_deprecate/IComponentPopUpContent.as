//------------------------------------------------------------------------------
//
//   Anthony Henderson  Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.interfaces._deprecate {
	import org.osflash.signals.ISignal;

	public interface IComponentPopUpContent {
 
		function get args():Array; 
		function set args(value:Array):void;
 
		function get closeIcon():String; 
		function set closeIcon(value:String):void;

		function get message():String 
		function set message(value:String):void 

		function get padding():int; 
		function set padding(value:int):void;
 
		function get title():String; 
		function set title(value:String):void;
		
		function get width():Number; 
		function set width(value:Number):void;
		
		function get height():Number; 
		function set height(value:Number):void;
		 
		function get onClose():ISignal;

	}
}
