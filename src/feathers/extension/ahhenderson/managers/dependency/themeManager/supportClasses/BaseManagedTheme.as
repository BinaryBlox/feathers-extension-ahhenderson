package feathers.extension.ahhenderson.managers.dependency.themeManager.supportClasses {

	import flash.display.Bitmap;
	
	import feathers.extension.ahhenderson.ahhenderson_extension_internal;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	import feathers.extension.ahhenderson.managers.dependency.themeManager.events.ThemeManagerEvent;
	import feathers.extension.ahhenderson.managers.dependency.themeManager.interfaces.IManagedTheme;
	import feathers.themes.StyleNameFunctionTheme;

	use namespace ahhenderson_extension_internal;


	public class BaseManagedTheme extends StyleNameFunctionTheme implements IManagedTheme {
		public function BaseManagedTheme( themeProperties:Object = null, scaleToDPI:Boolean = true ) {

			_scaleToDPI = scaleToDPI;
			_themeProperties = themeProperties;

			preinitialize();

		}

		//protected var _scale:Number = NaN;
		
		protected var _audioAssetsFolder:String;

		protected var _baseAssetsPath:String;

		protected var _contentScaleFactor:uint;

		protected var _deviceOrientation:String;

		protected var _fontAssetsFolder:String;

		protected var _imageAssetsFolder:String;

		protected var _isMultitouch:Boolean;

		protected var _isPreinitialized:Boolean;

		protected var _scaleToDPI:Boolean;

		protected var _scaledAssetsFolderPrefix:String;

		protected var _themeProperties:Object;

		protected var _backgroundImage:Bitmap;
		
		/*protected function set scale(value:Number):void
		{
			_scale = value;
		}*/

		/**
		 * Skins are scaled by a value based on the screen density on the
		 * content scale factor.
		 */
		protected function get scale():Number
		{
			//if(isNaN(_scale))
				return FeathersApplicationManager.instance.theme.scaledResolution;
			
			//return _scale;
		}

		public function get backgroundImage():Bitmap
		{ 
			return _backgroundImage;
		}
		
		public function get themeProperties():Object
		{
			return _themeProperties;
		}

		public function get audioAssetsFolder():String {

			return _audioAssetsFolder;
		}

		public function get baseAssetsPath():String {

			return _baseAssetsPath;
		}

		public function get contentScaleFactor():uint {

			return _contentScaleFactor;
		}

		public function get deviceOrientation():String {

			return _deviceOrientation;
		}

		public function get fontAssetsFolder():String {

			return _fontAssetsFolder;
		}

		public function get imageAssetsFolder():String {

			return _imageAssetsFolder;
		}

		public function initialize():void {

			// Overrride!
			throw new Error( "Override BaseManagedTheme initialize() method" );
		}

		public function get isMultitouch():Boolean {

			return _isMultitouch;
		}

		public function get scaledAssetsFolderPrefix():String {

			return _scaledAssetsFolderPrefix;
		}
 

		public function validateThemeConfiguration():String {

			var message:String = new String();

			if ( !this.contentScaleFactor )
				message += "\nContentScaleFactor not set...";

			if ( !this.deviceOrientation )
				message += "\nDevice Orientation not set...";

			if ( !this.audioAssetsFolder )
				message += "\nAudio assets folder not set...";

			if ( !this.imageAssetsFolder )
				message += "\nImage assets folder not set...";

			if ( !this.fontAssetsFolder )
				message += "\nFont assets folder not set...";

			if ( !this.baseAssetsPath )
				message += "\nBase assets path not set...";

			if ( !this.scaledAssetsFolderPrefix )
				message += "\nScaled assets folder prefix not set...";
			 

			return message;
		}

		public function preinitialize():void {

			preinitializeThemeParams();

			_isPreinitialized = true;

		}
		
		/**
		 * @private
		 */
		protected var _originalDPI:int;
		
		/**
		 * The original screen density used for scaling.
		 */
		public function get originalDPI():int {
			
			return this._originalDPI;
		}
		
		public function getThemePropertyValue(property:*, defaultValue:*=null):*{
			
			if(property)
				return property;
			
			return defaultValue
		}
		
		/**
		 * Indicates if the theme scales skins to match the screen density of
		 * the device.
		 */
		public function get scaleToDPI():Boolean {
			
			return this._scaleToDPI;
		}

		/**
		 * Initializes the theme colors. Expected to be called by subclasses after the
		 * assets have been loaded and the skin texture atlas has been created.
		 */
		public function preinitializeThemeParams():void {
			// Overrride!
			throw new Error( "Override BaseManagedTheme preinitializeThemeParams() method" );
		}

		// Internal namespace parameters
		ahhenderson_extension_internal function set setAudioAssetsFolder( value:String ):void {

			_audioAssetsFolder = value;
		}
		 
		
		ahhenderson_extension_internal function set setBackgroundImage( value:Bitmap ):void {
			
			_backgroundImage = value;
		}
		
		ahhenderson_extension_internal function set setContentScaleFactor( value:uint ):void {
			
			_contentScaleFactor = value;
		}

		ahhenderson_extension_internal function set setBaseAssetsPath( value:String ):void {

			_baseAssetsPath = value;
		}

		ahhenderson_extension_internal function set setDeviceOrientation( value:String ):void {

			_deviceOrientation = value;
		}

		ahhenderson_extension_internal function set setFontAssetsFolder( value:String ):void {

			_fontAssetsFolder = value;
		}

		ahhenderson_extension_internal function set setImageAssetsFolder( value:String ):void {

			_imageAssetsFolder = value;
		}

		ahhenderson_extension_internal function set setIsMultitouch( value:Boolean ):void {

			_isMultitouch = value;
		}

		ahhenderson_extension_internal function set setScaledAssetsFolderPrefix( value:String ):void {

			_scaledAssetsFolderPrefix = value;
		}
	}
}
