package feathers.extension.ahhenderson.interfaces._deprecate {
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	import ahhenderson.core.collections.interfaces.IEnumeration;
	
	import starling.textures.Texture;

	public interface IImageDisplayItem extends IDictionaryItem {

		function get defaultTexture():Texture;
		//function set defaultTexture(value:Texture):void;
		
		function get thumbURL():String;
		//function set thumbURL(value:String):void;

		function get title():String;
		//function set title(value:String):void;
		
		function get args():Array;
		//function set args(value:Array):void;

		function get url():String;
		//function set url(value:String):void;
		
		function get status():IEnumeration;
		function set status(value:IEnumeration):void;
	}

}
