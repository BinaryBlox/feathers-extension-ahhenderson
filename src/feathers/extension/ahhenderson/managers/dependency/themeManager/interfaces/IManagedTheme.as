 
package feathers.extension.ahhenderson.managers.dependency.themeManager.interfaces {
	import flash.display.Bitmap;
	
	import ahhenderson.core.interfaces.IDisposable;
	

	public interface IManagedTheme extends IDisposable {

	    
		function get isMultitouch():Boolean;
		
		function get baseAssetsPath():String;
		
		function get scaledAssetsFolderPrefix():String;
		
		function get contentScaleFactor():uint;
		
		function get deviceOrientation():String;
		
		function get audioAssetsFolder():String;
		
		function get fontAssetsFolder():String;
		
		function get imageAssetsFolder():String;
		
		function get backgroundImage():Bitmap;
		
		function initialize():void;
		
		function preinitialize():void
			  
		function preinitializeThemeParams():void;
		
		function validateThemeConfiguration():String;
		
		//function onContextRestored():void;
		 
	}
}
