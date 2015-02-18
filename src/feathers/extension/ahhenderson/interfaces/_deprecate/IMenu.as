//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.interfaces._deprecate {
	import feathers.data.ListCollection;
	
	import starling.display.DisplayObject;
	import ahhenderson.core.interfaces.IStarlingEventDispatcher;


	public interface IMenu extends IStarlingEventDispatcher {

		// Primary functions
		function hide():void;
		
		function show():void;
		
		// Getter/Setters 
		function get visible():Boolean;
		function set visible(value:Boolean):void;
		  
		function get defaultContent():DisplayObject;
		function set defaultContent(value:DisplayObject):void;
		
		function get dataProvider():ListCollection;
		function set dataProvider(value:ListCollection):void;
		 
		function get height():Number;
		function set height(value:Number):void;
	   
		function get padding():Number;
		function set padding(value:Number):void;
  
		function get width():Number;
		function set width(value:Number):void;
		
		/*function get configurationId():String;
		function set configurationId(value:String):void;*/
	 
		function initializeMenu():void;
		 
	}
}
