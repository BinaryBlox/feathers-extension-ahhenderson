package feathers.extension.ahhenderson.managers {
	
	import com.kurst.cfwrk.system.DeviceCapabilities;
	import com.kurst.cfwrk.system.constants.DeviceList;
	import com.kurst.cfwrk.system.constants.DeviceOrientation;
	import com.kurst.cfwrk.system.data.DeviceInfo;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import mx.utils.StringUtil;
	
	import ahhenderson.core.starling.controls.ProgressBar;
	
	import feathers.extension.ahhenderson.ahhenderson_extension_internal;
	import feathers.extension.ahhenderson.controls.core.FeathersRootContainer;
	import feathers.extension.ahhenderson.managers.dependency.themeManager.events.ThemeManagerEvent;
	import feathers.extension.ahhenderson.managers.dependency.themeManager.interfaces.IManagedTheme;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.ResizeEvent;
	import starling.utils.AssetManager;
	
	use namespace ahhenderson_extension_internal;
	
	/**
	 *
	 * @author thenderson
	 */
	[Event(name="themeAssetLoadingComplete", type="feathers.extension.ahhenderson.extension.managers.dependency.themeManager.events.ThemeManagerEvent")]
	[Event(name="themeAssetLoadingProgress", type="feathers.extension.ahhenderson.extension.managers.dependency.themeManager.events.ThemeManagerEvent")]
	internal class ThemeManager extends EventDispatcher {
		
		private static const _instance:ThemeManager = new ThemeManager( SingletonLock );
		
		private  const ASSET_FOLDER_SCALE_1:String = "1";
		
		private  const ASSET_FOLDER_SCALE_2:String = "2";
		
		private  const ASSET_FOLDER_SCALE_3:String = "3";
		
		public function get root():FeathersRootContainer
		{
			validateManager();
			
			return _root;
		}

		public function get isLoaded():Boolean
		{
			return _isLoaded;
		}

		public function get isInitialized():Boolean
		{
			return _isInitialized;
		}

		public function get scaledResolution():Number
		{
			return _scaledResolution;
		}
		
		public function get atlasScaleSuffix():String{
			
			return "_" + _scaledResolution.toString() + "x";
		}

		public function get currentBackground():Image
		{
			return _currentBackground;
		}

		public function get currentTheme():IManagedTheme
		{
			return _currentTheme;
		}

		/**
		 * 
		 * @return 
		 */
		public function get nativeStage():Stage {
			
			return _nativeStage;
		}
		
		/**
		 * 
		 * @return 
		 */
		public static function get instance():ThemeManager {
			
			return _instance;
		}
		
		private var _assetManager:AssetManager;
		
		private var _scaleFactor:Number;
		
		private var _isInitialized:Boolean;
		
		private var _isLoaded:Boolean;
		
		private var _debugger:Boolean;
		
		private var _scaledResolution:Number=1;
		
		private const DEVICE_SCALE_1:int=1;
		private const DEVICE_SCALE_2:int=2;
		private const DEVICE_SCALE_3:int=3;
		
		/**
		 *
		 * @param lock
		 * @throws Error
		 */
		public function ThemeManager( lock:Class ) {
			
			if ( lock != SingletonLock ) {
				throw new Error( "Invalid Singleton access.  Use Model.instance." );
			}
		}
		
		/**
		 * 
		 * @return 
		 * @throws Error
		 */
		public function get assetManager():AssetManager {
			
			if ( !_isInitialized )
				throw new Error( "You must initialize the ThemeManager first" );
			
			return _assetManager;
		}
		
		private var _nativeStage:Stage;
		
		private var _currentTheme:IManagedTheme;
		
		private var _root:FeathersRootContainer;
		
		public function initialize(parent:FeathersRootContainer, theme:IManagedTheme, nativeStage:Stage, scaleFactor:Number = 1, debugger:Boolean = false ):void {
			
			if ( !_assetManager )
				_assetManager = new AssetManager( _scaleFactor );
			
			_root = parent;
			_currentTheme = theme;
			_nativeStage = nativeStage;
			_scaleFactor = scaleFactor;
			_debugger = debugger;
			 
			// Initialization constraints have been met
			_isInitialized = true;
			
			assetManager.verbose = (_debugger) ? Capabilities.isDebugger : false;
			 
			enqueueAssets();
			
		}
		
		private function validateManager():void {
			
			if ( !_isInitialized )
				throw new Error( "ThemeManager: You must initialize the manager first" );
		}
		
		/**
		 *
		 * @param stage
		 * @param multitouch
		 * @param orientation
		 * @return
		 */
		public function deviceInformation( multitouch:Boolean = true, orientation:String = DeviceOrientation.LANDSCAPE ):DeviceInfo {
			
			validateManager();
			
			// Init device cababilities
			DeviceCapabilities.init( this.nativeStage, orientation );
			var fmgr:FeathersApplicationManager = FeathersApplicationManager.instance;
			
			fmgr.logger.trace(this, 'DeviceCapabilities.dpi: ' + DeviceCapabilities.dpi );
			fmgr.logger.trace(this, 'DeviceCapabilities.screenInchesY: ' + DeviceCapabilities.screenInchesY() );
			fmgr.logger.trace(this, 'DeviceCapabilities.screenInchesX: ' + DeviceCapabilities.screenInchesX() );
			fmgr.logger.trace(this, 'DeviceCapabilities.isPhone: ' + DeviceCapabilities.isPhone() );
			fmgr.logger.trace(this, 'DeviceCapabilities.isDesktop: ' + DeviceCapabilities.isDesktop() );
			fmgr.logger.trace(this, 'DeviceCapabilities.isTablet: ' + DeviceCapabilities.isTablet() );
			fmgr.logger.trace(this, 'DeviceCapabilities.isLandscape: ' + DeviceCapabilities.isLandscape() );
			fmgr.logger.trace(this, 'DeviceCapabilities.deviceInformation: ' + DeviceCapabilities.deviceInformation.toString() );
			
			if ( this._debugger ) {
				
				/*trace( 'DeviceCapabilities.dpi: ', DeviceCapabilities.dpi );
				trace( 'DeviceCapabilities.screenInchesY: ', DeviceCapabilities.screenInchesY());
				trace( 'DeviceCapabilities.screenInchesX: ', DeviceCapabilities.screenInchesX());
				trace( 'DeviceCapabilities.isPhone: ', DeviceCapabilities.isPhone());
				trace( 'DeviceCapabilities.isDesktop: ' 		, DeviceCapabilities.isDesktop());
				trace( 'DeviceCapabilities.isTablet: ' 			, DeviceCapabilities.isTablet());
				trace( 'DeviceCapabilities.isLandscape: ', DeviceCapabilities.isLandscape());
				trace( 'DeviceCapabilities.deviceInformation: ', DeviceCapabilities.deviceInformation().toString());*/
				
				//Starling.handleLostContext = DeviceCapabilities.handleLostContextOnDevice();
			}
			
			return DeviceCapabilities.deviceInformation();
		}
		
		private var _isDesktopDevice:Boolean;
		
		private function deduceScaledAssetsFolderPath(scaledAssetsFolderPrefix:String,
													  orientation:String, 
													  multitouch:Boolean):String{
			
			// Determine device capabilities
			const deviceInfo:DeviceInfo = deviceInformation( multitouch, orientation );
			
			var fmgr:FeathersApplicationManager = FeathersApplicationManager.instance;
			fmgr.logger.trace(this, 'Device Info: ' + deviceInfo.device );
			
			if ( !deviceInfo )  
				throw new Error("ThemeManager: deduceScaledAssetsFolderPath() - No Device info");
			
			scaledAssetsFolderPrefix += "{0}"; // for substitution
			var scaledAssetsFolder:String; // default folder for desktop
			
			trace("DEVICE: ", deviceInfo.device);
			
			if ( deviceInfo.device == DeviceList.DESKTOP ) {
				_isDesktopDevice = true;
				scaledAssetsFolder = StringUtil.substitute( scaledAssetsFolderPrefix, ASSET_FOLDER_SCALE_1 );
				_scaledResolution = 1;
				//SystemModel.appDpiScale = 1;
			} else {
				
				// Mobile devices
				switch ( deviceInfo.scale ) {
					
					case DEVICE_SCALE_1:
						scaledAssetsFolder = StringUtil.substitute( scaledAssetsFolderPrefix, ASSET_FOLDER_SCALE_1 );
						_scaledResolution = DEVICE_SCALE_1;
						//SystemModel.appDpiScale = 1;
						break;
					
					case DEVICE_SCALE_2:
						_scaledResolution = DEVICE_SCALE_2;
						//SystemModel.appDpiScale = 2;
						scaledAssetsFolder = StringUtil.substitute( scaledAssetsFolderPrefix, ASSET_FOLDER_SCALE_2 );
						break;
					
					case DEVICE_SCALE_3:
						_scaledResolution = DEVICE_SCALE_3;
						//SystemModel.appDpiScale = 2;
						scaledAssetsFolder = StringUtil.substitute( scaledAssetsFolderPrefix, ASSET_FOLDER_SCALE_3 );
						break;
					
					default:
						scaledAssetsFolder = StringUtil.substitute( scaledAssetsFolderPrefix, ASSET_FOLDER_SCALE_2 );
						_scaledResolution = DEVICE_SCALE_2;
						//SystemModel.appDpiScale = 2;
						break;
				}
			}
			
			return scaledAssetsFolder;
		}
		 
		private var _currentBackground:Image;
		
		ahhenderson_extension_internal function enqueueAssets( ):void {
			
			validateManager();
			
			var validationErrors:String = _currentTheme.validateThemeConfiguration();
			
			if(validationErrors && validationErrors.length>0){
				throw new Error("ThemeManager theme validation failed:\n" + validationErrors);
			}
			
			
				
			try{
				// Determine device capabilities
				const deviceInfo:DeviceInfo = deviceInformation( this.currentTheme.isMultitouch, DeviceOrientation.LANDSCAPE );
				
				if ( !deviceInfo )  
					throw new Error("No supported device was found.");
				
				
				var scaledAssetsFolder:String = deduceScaledAssetsFolderPath(_currentTheme.scaledAssetsFolderPrefix, 
					this.currentTheme.deviceOrientation, 
					this.currentTheme.isMultitouch);
				
				// No specified directories were found.
				if ( !scaledAssetsFolder )  
					throw new Error("No assets folder was located.");
				
				// Update scale factor if necessary
				if(assetManager.scaleFactor != this.currentTheme.contentScaleFactor)
					assetManager.scaleFactor = this.currentTheme.contentScaleFactor;
				
				/////////////////////////////////////////////
				// NOT Required until we use bitmap fonts: Determine if embedding bitmap font definitions 
				/////////////////////////////////////////////
				/*var bitmapFontClass:Class;
				const bitmapFontClassName:String=getBitmapFontClassName(theme, deviceInfo);
				
				//trace("Embedded font class: ", embeddedFontClass);
				if (bitmapFontClassName){
				bitmapFontClass=getDefinitionByName(bitmapFontClassName) as Class;
				
				if ( bitmapFontClass )
				AppMgr.instance.assetManager.enqueue( bitmapFontClass );
				}*/
				
				
				
				const appDir:File = File.applicationDirectory;  
				const audioAssetsPath:String =  StringUtil.substitute("{0}/{1}", this.currentTheme.baseAssetsPath, this.currentTheme.audioAssetsFolder);
				const fontsAssetsPath:String =  StringUtil.substitute( "{0}/{1}/{2}", this.currentTheme.baseAssetsPath, this.currentTheme.fontAssetsFolder, scaledAssetsFolder );
				const texturesAssetsPath:String =  StringUtil.substitute( "{0}/{1}/{2}", this.currentTheme.baseAssetsPath, this.currentTheme.imageAssetsFolder, scaledAssetsFolder )
				
				if ( this._debugger ) {
					
					trace( "SCALE: ", _scaledResolution );
					trace( "Base assets path:", scaledAssetsFolder );
					trace( "Audio assets path:", audioAssetsPath );
					trace( "Font assets path:", fontsAssetsPath );
					trace( "Images assets path:", texturesAssetsPath );
				}
				
				// Enqueue assets automatically
				assetManager.enqueue( appDir.resolvePath(audioAssetsPath), 
					appDir.resolvePath(fontsAssetsPath), 
					appDir.resolvePath(texturesAssetsPath) );
				
				if(this.currentTheme.backgroundImage){
					
					// Add default background
					_currentBackground=Image.fromBitmap(this.currentTheme.backgroundImage);
					_currentBackground.width=Starling.current.stage.stageWidth;
					_currentBackground.height=Starling.current.stage.stageHeight;
					
					//_currentBackground.alpha=.6;
					//_defaultBackground.alpha=0;
					if(_root.contains(_currentBackground))
						_root.removeChild(_currentBackground);
					
					_root.addChild(_currentBackground);
					 
				}
				
				
			}catch(e:Error){
				
				throw new Error("ThemeManager: enqueuAssets() Error:\n" + e.message);
				
			} 
		}
		
		private var _assetProgressBar:ahhenderson.core.starling.controls.ProgressBar;
		 
		protected function initializeProgressBar():void{
			 
			const progBarHeight:Number = 20 * this.scaledResolution;
			const progBarWidth:Number = 175 * this.scaledResolution;
			 
			_assetProgressBar=new ProgressBar(progBarWidth, progBarHeight);
			_assetProgressBar.x=(Starling.current.stage.stageWidth - _assetProgressBar.width) / 2;
			_assetProgressBar.y=(Starling.current.stage.stageWidth - _assetProgressBar.height) / 2;
			//_assetProgressBar.y=_parent.stage.stageHeight * 0.85;
			  
			_root.addChild(_assetProgressBar);
			
		}
		
		public function loadAssets():void{
			
			_isLoaded = false;
			
			initializeProgressBar();
			  
			this.assetManager.loadQueue(onAssetManagerProgress);
			
		}
		
		protected function onAssetManagerLoaded(event:ThemeManagerEvent):void{
			this.dispatchEvent(event);
		}
		
		/**
		 * @private
		 */
		protected function onAssetManagerProgress(progressRatio:Number):void
		{
			if(progressRatio < 1)
			{
				if(_assetProgressBar)
					_assetProgressBar.ratio=progressRatio;
				
				this.dispatchEvent(new ThemeManagerEvent(ThemeManagerEvent.THEME_ASSET_LOADING_PROGRESS, progressRatio));
				return;
			}
			
			 
			// Initialize current theme
			Starling.juggler.delayCall(function():void{
				
				_isLoaded=true;
				
				// Remove progress bar & dispose
				_assetProgressBar.removeFromParent(true);
				
				if(_isDesktopDevice) 
					_root.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
				 
				// Initialize theme
				_currentTheme.initialize()
				
				// Dispatch complete event
				onAssetManagerLoaded(new ThemeManagerEvent(ThemeManagerEvent.THEME_ASSET_LOADING_COMPLETE)); 
			
			}, 
			.25);
			
			
			/*_currentTheme.initialize()
			this.dispatchEvent(new ThemeManagerEvent(ThemeManagerEvent.THEME_ASSET_LOADING_COMPLETE));*/
		}
		
		private function stage_resizeHandler(event:ResizeEvent):void
		{
			// liquid layout
			Starling.current.viewPort=new Rectangle(0, 0, event.width, event.height);
			_root.stage.stageWidth=event.width;
			_root.stage.stageHeight=event.height;
			
			// bg 
			if(this.currentBackground){
				this.currentBackground.width=event.width;
				this.currentBackground.height=event.height;
			}
		
			
			// particle position
			/*_particles.emitterX=stage.stageWidth / 2 >> 0;
			_particles.emitterY=(-50 *SystemModel.appDpiScale) + (stage.stageHeight * 3 / 4 >> 0);*/
		}
		
	}
}


class SingletonLock {
}
