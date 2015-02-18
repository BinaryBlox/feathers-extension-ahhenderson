//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.interfaces._deprecate {
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	import ahhenderson.core.interfaces.IStarlingEventDispatcher;
	

	public interface IMenuItem extends IStarlingEventDispatcher {
 
		function get id():String;
		function set id(value:String):void;
		
		function get message():FacadeMessage;
		function set message(value:FacadeMessage):void;
		 
		function get icon():String;
		function set icon(value:String):void;
		
		function get label():String;
		function set label(value:String):void;
		
	/*	function onChange(event:Event):void;
		function onRelease(event:Event):void;*/
		 
	}
}
