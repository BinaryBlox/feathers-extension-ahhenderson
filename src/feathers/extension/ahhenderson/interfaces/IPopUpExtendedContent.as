//------------------------------------------------------------------------------
//
//   Anthony Henderson  Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.interfaces {
	import ahhenderson.core.interfaces.IStarlingEventDispatcher;
	
	import starling.display.DisplayObject;


	public interface IPopUpExtendedContent  extends IStarlingEventDispatcher {
 
		// Primary functions
		function hide():void;
		
		function show():void;
		
		// Getter/Setters 
		function get visible():Boolean;
		function set visible(value:Boolean):void;
		
		function get defaultContent():DisplayObject;
		function set defaultContent(value:DisplayObject):void;
		  
		function get height():Number;
		function set height(value:Number):void;
		
		function get padding():Number;
		function set padding(value:Number):void;
		
		function get width():Number;
		function set width(value:Number):void;
		
		/*function get configurationId():String;
		function set configurationId(value:String):void;*/
		
		function initializeContent():void;
	 
	}
}
