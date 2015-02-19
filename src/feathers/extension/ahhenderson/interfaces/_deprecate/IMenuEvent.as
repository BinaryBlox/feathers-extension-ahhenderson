//------------------------------------------------------------------------------
//
//   Anthony Henderson  Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.interfaces._deprecate {
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	import ahhenderson.core.interfaces.IStarlingEventDispatcher;
	

	public interface IMenuEvent extends IStarlingEventDispatcher {
 
		function get id():String;
		function set id(value:String):void;
		
		function get message():FacadeMessage;
		function set message(value:FacadeMessage):void;
		
	/*	function get menuIcon():String;
		function set menuIcon(value:String):void;
		
		function get menuLabel():String;
		function set menuLabel(value:String):void;*/
	/*	function onChange(event:Event):void;
		function onRelease(event:Event):void;*/
		 
	}
}
