//------------------------------------------------------------------------------
//
//   ViziFit Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.ui.menu {
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	import feathers.extension.ahhenderson.interfaces._deprecate.ITileListItem;
	
	import starling.textures.Texture;

	public class MenuItem implements IDictionaryItem, ITileListItem {

		public function MenuItem(key:String, label:String, icon:String=null, message:FacadeMessage=null, placement:String=null, isUpdateable:Boolean=true ) {
			_key=key;
			_label=label;
			_icon=icon;
			_message=message;
			_isUpdateable=isUpdateable;
			_placement = placement;
		 
		}

		private var _icon:*;

		private var _isUpdateable:Boolean;

		private var _key:String;
		
		private var _label:String;

		private var _message:*;
		
		private var _placement:String;
		  

		public function get placement():String
		{
			return _placement;
		}

		public function set placement(value:String):void
		{
			_placement = value;
		}

		public function get icon():* {
			return _icon;
		}

		public function get isUpdateable():Boolean {
			return _isUpdateable;
		}

		public function get key():String {
			return _key;
		}

		public function get label():String {
			return _label;
		}

		public function get message():FacadeMessage {
			return _message;
		}

		public function get texture():Texture {
			
			try
			{
				//return AssetHpr.getImage(_icon).texture;
			} 
			catch(error:Error) 
			{
				//LogHpr.log(LType.ERROR, null, error.message, error.getStackTrace());
			}
			
			return null;
			 
		}
	}
}