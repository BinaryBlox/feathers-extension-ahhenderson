package feathers.extension.ahhenderson.controls.core {

	import flash.events.Event;
	
	import ahhenderson.core.ui.controls.SpriteMVC;
	
	import feathers.controls.Drawers;
	import feathers.controls.Header;
	import feathers.controls.ScreenNavigator;
	import feathers.extension.ahhenderson.ahhenderson_extension_internal;
	import feathers.extension.ahhenderson.controls.screens.TitledNavigatorScreen;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	import feathers.extension.ahhenderson.managers.dependency.themeManager.events.ThemeManagerEvent;

	use namespace ahhenderson_extension_internal


	public class FeathersRootContainer extends SpriteMVC  {
		
		include "../../_includes/_FeathersAppManager.inc";
		
		public function FeathersRootContainer() {

			super();

			registerClassAliases();

		}
 
		protected var _titledNavigatorScreen:TitledNavigatorScreen;

		ahhenderson_extension_internal var _drawers:Drawers;

		ahhenderson_extension_internal var _screenNavigator:ScreenNavigator;
 

		public function loadTheme():void {

			if ( !fmgr.theme.isInitialized ) {
				throw new Error( "FeathersRootScreen - loadTheme(): ThemeManager must be initialized!" );
			}

			fmgr.theme.addEventListener( ThemeManagerEvent.THEME_ASSET_LOADING_COMPLETE, onThemeLoaded );

			fmgr.theme.loadAssets();

		}

		public function preInitialize():void {

			loadTheme();
		}

		public function updateTitle( title:String ):void {

			if ( title && _titledNavigatorScreen.header )
				_titledNavigatorScreen.header.title = title;

		}

		public function get header():Header {

			return _titledNavigatorScreen.header;

		}

		public function get headerDockingMode( ):Boolean {
			
			return _titledNavigatorScreen.headerDockingMode;
		}
		
		public function set headerDockingMode(value:Boolean ):void {
			
			  _titledNavigatorScreen.headerDockingMode = value;
		}
		
		public function toggleHeaderVisibility( isVisible:Boolean ):void {

			_titledNavigatorScreen.toggleHeaderVisiblity( isVisible );
		}

		protected function initialize():void {

			this._drawers = new Drawers();

			_titledNavigatorScreen = new TitledNavigatorScreen();
 

			//a drawer may be opened by dragging from the edge of the content
			//you can also set it to drag from anywhere inside the content
			//or you can disable gestures entirely and only open a drawer when
			//an event is dispatched by the content or by calling a function
			//on the drawer component to open a drawer programmatically.
			this._drawers.openGesture = Drawers.OPEN_GESTURE_DRAG_CONTENT_EDGE;

			// Set Navigator to Screen content.
			this._drawers.content = this._titledNavigatorScreen;

			this.addChild( this._drawers );

			// NOTE: Only to happen after adding (Drawers to display list)
			initializeNavigationManager();

			// Init Drawers
			initializeDrawers( this._drawers );
			
			// All applicaiton views
			registerScreenViews();
 
			// Root MVC
			registerRootCommand(); 
			registerRootMediator();
  
		}

		protected function registerClassAliases():void {

			throw new Error( "Override FeathersRootScreen registerClassAliases() method." );
		}

		protected function initializeDrawers( drawers:Drawers ):void {

			throw new Error( "FeathersRootScreen - initializeDrawers(drawers:Drawers): method must be overriden!" );
		}

		protected function initializeNavigationManager():void {

			fmgr.navigation.initialize( this );
		}

		protected function onThemeLoaded( e:flash.events.Event ):void {

			fmgr.theme.removeEventListener( ThemeManagerEvent.THEME_ASSET_LOADING_COMPLETE, onThemeLoaded );

			this.initialize();

		}

		protected function registerRootMediator():void {

			throw new Error( "FeathersRootScreen - registerRootMediator(): method must be overriden!" );
		}

		protected function registerRootCommand():void {

			throw new Error( "FeathersRootScreen - registerStartupCommand(): method must be overriden!" );
		}

		protected function registerScreenViews():void {

			throw new Error( "FeathersRootScreen - registerScreenViews(): method must be overriden!" );
		}
 
		ahhenderson_extension_internal function get drawers():Drawers {

			return _drawers;
		}

		ahhenderson_extension_internal function get screenNavigator():ScreenNavigator {

			return _titledNavigatorScreen.navigator;
		}
	}
}
