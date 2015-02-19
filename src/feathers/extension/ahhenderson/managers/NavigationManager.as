package feathers.extension.ahhenderson.managers
{

	import flash.events.EventDispatcher;
	
	import ahhenderson.core.ui.enums.LayoutDirectionType;
	import ahhenderson.core.util.StringUtil;
	
	import feathers.controls.Drawers;
	import feathers.controls.ScreenNavigator;
	import feathers.extension.ahhenderson.ahhenderson_extension_internal;
	import feathers.extension.ahhenderson.controls.core.FeathersRootScreen;
	import feathers.extension.ahhenderson.helpers.DialogHelper;
	import feathers.extension.ahhenderson.util.ScreenUtil;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.display.DisplayObject;

	use namespace ahhenderson_extension_internal;


	internal class NavigationManager extends EventDispatcher
	{

		private static const _instance:NavigationManager=new NavigationManager(SingletonLock);

		private function get fmgr():FeathersApplicationManager
		{
			if(!_fmgr)
				_fmgr = FeathersApplicationManager.instance;
			
			return _fmgr;
		}

		/**
		 *
		 * @return
		 */
		public static function get instance():NavigationManager
		{

			return _instance;
		}

		/**
		 *
		 * @param lock
		 * @throws Error
		 */
		public function NavigationManager(lock:Class)
		{

			if (lock != SingletonLock)
			{
				throw new Error("Invalid Singleton access.  Use Model.instance.");
			}
		}

		private var _isInitialized:Boolean;

		private var _rootScreen:FeathersRootScreen;

		private var _transitionManager:ScreenSlidingStackTransitionManager;

		public function addScreen(id:String, screen:Object, events:Object=null, initializer:Object=null):void
		{

			ScreenUtil.addScreen(this.screenNavigator, id, screen, events, initializer);
		}

		public function changeDrawerDockMode(location:LayoutDirectionType, dockMode:String):void
		{

			validateManager();

			// Use logic below dierectly after testing.
			var drawerDisplayObjectProperty:String=location.value.toLowerCase() + "Drawer";
			var drawerDockModeProperty:String=location.value.toLowerCase() + "DrawerDockMode";

			// Ensure drawer exists
			if (!this._rootScreen.drawers[drawerDisplayObjectProperty])
				throw new Error("No " + location.value + " was created.");

			this._rootScreen.drawers[drawerDockModeProperty]=dockMode;

		}

		public function initialize(rootScreen:FeathersRootScreen):void
		{

			this._rootScreen=rootScreen;

			// Set transition animation
			this._transitionManager=new ScreenSlidingStackTransitionManager(this._rootScreen.screenNavigator);
			this._transitionManager.duration=0.4;

			_isInitialized=true;
		}

		public function initializeDrawer(location:LayoutDirectionType, drawer:DisplayObject, dockMode:String=Drawers.DOCK_MODE_NONE, overwrite:Boolean=false):void
		{

			validateManager();

			// Use logic below dierectly after testing.
			var drawerDisplayObjectProperty:String=location.value.toLowerCase() + "Drawer";
			var drawerDockModeProperty:String=location.value.toLowerCase() + "DrawerDockMode";

			// Ensure drawer exists
			if (!overwrite && this._rootScreen.drawers[drawerDisplayObjectProperty])
				throw new Error("You must overwrite the drawer in the location " + location.value + ".");

			this._rootScreen.drawers[drawerDisplayObjectProperty]=drawer;
			this._rootScreen.drawers[drawerDockModeProperty]=dockMode;

		}

		public function get isInitialized():Boolean
		{

			return _isInitialized;
		}

		public function toggleHeaderVisibility(isVisible:Boolean):void{
			
			this._rootScreen.toggleHeaderVisibility(isVisible);
		}
		
		private var _fmgr:FeathersApplicationManager;
		
		public function showScreen(id:String, resetHeader:Boolean= true):void
		{
			if(!this._rootScreen.screenNavigator.getScreen(id)){
				DialogHelper.showAlert("Screen not Available", "A screen has not been configured for " + id);
				return;
			}

			validateManager();

			if(resetHeader)
				clearHeaderItems();
			
			this.fmgr.logger.trace(this, "Showing screen with id: " + id);
			
			this._rootScreen.screenNavigator.showScreen(id);
		}

		private function clearHeaderItems():void
		{

			if (this._rootScreen.header.rightItems)
				this._rootScreen.header.rightItems=null;

			if (this._rootScreen.header.leftItems)
				this._rootScreen.header.leftItems=null;
		}

		public function toggleDrawer(location:LayoutDirectionType, duration:Number=NaN):void
		{

			validateManager();

			var drawerDisplayObjectProperty:String=location.value.toLowerCase() + "Drawer"

			var toggleDrawerMethod:String="toggle";
			toggleDrawerMethod+=StringUtil.capitalize(location.value.toLowerCase());
			toggleDrawerMethod+="Drawer";

			// Ensure drawer exists
			if (!this._rootScreen.drawers[drawerDisplayObjectProperty])
				throw new Error("No " + location.value + " was created.");

			// Show drawer
			this._rootScreen.drawers[toggleDrawerMethod](duration);

		}

		ahhenderson_extension_internal function get drawers():Drawers
		{

			validateManager();

			return this._rootScreen.drawers;
		}

		ahhenderson_extension_internal function get screenNavigator():ScreenNavigator
		{

			validateManager();

			return this._rootScreen.screenNavigator;
		}

		ahhenderson_extension_internal function validateManager():void
		{

			if (!_isInitialized)
				throw new Error("NavigationManager: You must initialize the manager first");
		}

		public function updateLeftHeaderItems(items:Vector.<DisplayObject>):void
		{

			validateManager();

			if (items)
				this._rootScreen.header.leftItems=items;

		}

		public function updateRightHeaderItems(items:Vector.<DisplayObject>):void
		{

			validateManager();

			if (items)
				this._rootScreen.header.rightItems=items;

		}

		public function updateHeaderTitle(title:String):void
		{

			validateManager();

			if (title)
				this._rootScreen.updateTitle(title);

		}
	}
}


class SingletonLock
{
}
