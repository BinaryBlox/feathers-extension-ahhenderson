package feathers.extension.ahhenderson.controls.core {

	import flash.events.Event;
	
	import ahhenderson.core.ui.controls.SpriteMVC;
	import feathers.extension.ahhenderson.feathers_extension_internal;
	import feathers.extension.ahhenderson.controls.screens.TitledNavigatorScreen;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	import feathers.extension.ahhenderson.managers.dependency.themeManager.events.ThemeManagerEvent;
	
	import feathers.controls.Drawers;
	import feathers.controls.Header;
	import feathers.controls.ScreenNavigator;
	
	import starling.display.DisplayObject;

	use namespace feathers_extension_internal


	public class FeathersRootScreen extends SpriteMVC {
		public function FeathersRootScreen() {

			super();
			
			registerClassAliases();

		}
		
		private var _fmgr:FeathersApplicationManager;
		
		

		protected var _titledNavigatorScreen:TitledNavigatorScreen;

		feathers_extension_internal var _drawers:Drawers;

		feathers_extension_internal var _screenNavigator:ScreenNavigator;

		public function get fmgr():FeathersApplicationManager
		{
			
			if(!_fmgr)
				_fmgr = FeathersApplicationManager.instance;
			
			return _fmgr;
		}

		public function loadTheme():void {

			if ( !FeathersApplicationManager.instance.theme.isInitialized ) {
				throw new Error( "BaseRootView - loadTheme(): ThemeManager must be initialized!" );
			}

			FeathersApplicationManager.instance.theme.addEventListener( ThemeManagerEvent.THEME_ASSET_LOADING_COMPLETE, onThemeLoaded );

			FeathersApplicationManager.instance.theme.loadAssets();

		}

		public function preInitialize():void {

			loadTheme();
		}


		public function updateTitle( title:String ):void {

			if ( title && _titledNavigatorScreen.header )
				_titledNavigatorScreen.header.title = title;

		}
		
		public function get header( ):Header {
			 
			 return _titledNavigatorScreen.header;
			
		}
		
		public function toggleHeaderVisibility(isVisible:Boolean):void{
			
			_titledNavigatorScreen.toggleHeaderVisiblity(isVisible);
		}

		protected function initialize():void {

			this._drawers = new Drawers();

			_titledNavigatorScreen = new TitledNavigatorScreen();

			/*_titledNavigatorScreen.width = this.width;
			_titledNavigatorScreen.height = this.height;*/

			//a drawer may be opened by dragging from the edge of the content
			//you can also set it to drag from anywhere inside the content
			//or you can disable gestures entirely and only open a drawer when
			//an event is dispatched by the content or by calling a function
			//on the drawer component to open a drawer programmatically.
			this._drawers.openGesture = Drawers.OPEN_GESTURE_DRAG_CONTENT_EDGE;

			// Set Navigator to Screen content.
			this._drawers.content = this._titledNavigatorScreen;

			this.addChild( this._drawers );
			 
			
			   
			// Only to happen after adding 
			initializeNavigationManager();
			
			registerScreenViews();
			
			initializeDrawers( this._drawers );
			
			// MVC
			registerStartupCommand();
			
			registerRootMediator();
			 
			// Defaults
			showDefaultScreen();
 
		}
		 
		 
		protected function registerClassAliases():void{
			
			throw new Error( "Override FeathersRootScreen registerClassAliases() method." );
		}
		
		protected function initializeDrawers( drawers:Drawers ):void {

			throw new Error( "BaseRootView - initializeDrawers(drawers:Drawers): method must be overriden!" );
		}

		protected function initializeNavigationManager():void {

			FeathersApplicationManager.instance.navigation.initialize( this );
		}

		protected function onThemeLoaded( e:flash.events.Event ):void {
 
			FeathersApplicationManager.instance.theme.removeEventListener( ThemeManagerEvent.THEME_ASSET_LOADING_COMPLETE, onThemeLoaded );

			this.initialize();

		}
		
		protected function registerRootMediator():void{
			
			throw new Error( "BaseRootView - registerRootMediator(): method must be overriden!" );
		}
		
		protected function registerStartupCommand():void{
			
			throw new Error( "BaseRootView - registerStartupCommand(): method must be overriden!" );
		}

		protected function registerScreenViews():void {

			throw new Error( "BaseRootView - registerScreenViews(): method must be overriden!" );
		}

		protected function showDefaultScreen():void {

			throw new Error( "BaseRootView - showDefaultScreen(): method must be overriden!" );
		}

		feathers_extension_internal function get drawers():Drawers {

			return _drawers;
		}

		feathers_extension_internal function get screenNavigator():ScreenNavigator {

			return _titledNavigatorScreen.navigator;
		}
	}
}
