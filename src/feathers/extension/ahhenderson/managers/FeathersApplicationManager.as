package feathers.extension.ahhenderson.managers {

	import flash.events.EventDispatcher;
	
	import ahhenderson.core.managers.FacadeServiceManager;
	import ahhenderson.core.managers.LoggingManager;
	import ahhenderson.core.managers.ObjectPoolManager;
	import ahhenderson.core.managers.SessionManager;
	import ahhenderson.core.managers.dependency.facadeService.events.FacadeServiceManagerEvent;
	import ahhenderson.core.mvc.patterns.facade.GlobalFacade;
	
	import feathers.extension.ahhenderson.ahhenderson_extension_internal;
	import feathers.extension.ahhenderson.helpers.DialogHelper;

	use namespace ahhenderson_extension_internal;


	/**
	 *
	 * @author thenderson
	 */
	/*[Event(name="themeAssetLoadingComplete", type="feathers.extension.managers.dependency.themeManager.events.ThemeManagerEvent")]
	[Event(name="themeAssetLoadingProgress", type="feathers.extension.managers.dependency.themeManager.events.ThemeManagerEvent")]*/
	/**
	 * 
	 * @author thenderson
	 */

	public class FeathersApplicationManager extends EventDispatcher {

		private static const _instance:FeathersApplicationManager = new FeathersApplicationManager( SingletonLock );

		public function get isDebuggable():Boolean
		{
			return _isDebuggable;
			 
		}

		/**
		 *
		 * @return
		 */
		public static function get instance():FeathersApplicationManager {

			return _instance;
		}

		/**
		 *
		 * @param lock
		 * @throws Error
		 */
		public function FeathersApplicationManager( lock:Class ) {

			if ( lock != SingletonLock ) {
				throw new Error( "Invalid Singleton access.  Use Model.instance." );
			}
			
			// Add listners
			FacadeServiceManager.instance.addEventListener(FacadeServiceManagerEvent.HIDE_DIALOG,onServiceMgrEvent);
			FacadeServiceManager.instance.addEventListener(FacadeServiceManagerEvent.SHOW_DIALOG,onServiceMgrEvent);
		}

		private var _isDebuggable:Boolean;

		private var _isDesktopDevice:Boolean;

		private var _isInitialized:Boolean;

		private var _scaledResolution:Number = 1;

		/**
		 * 
		 */
		public function initialize(isDebuggable:Boolean=false):void {
			_isDebuggable=isDebuggable
				
			pool.debug = isDebuggable;
		}

		/**
		 * 
		 * @return 
		 */
		public function get isInitialized():Boolean {

			return _isInitialized;
		}

		/**
		 * 
		 * @return 
		 */
		public function get pool():ObjectPoolManager {
			
			return ObjectPoolManager.instance;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get theme():ThemeManager {

			return ThemeManager.instance;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get navigation():NavigationManager {
			
			return NavigationManager.instance;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get session():SessionManager {
			
			return SessionManager.instance;
		}
		 
		/**
		 * 
		 * @return 
		 */
		public function get logger():LoggingManager {
			
			return LoggingManager.instance;
		}
		
		 
		
		private function onServiceMgrEvent(e:FacadeServiceManagerEvent):void{
			
			switch(e.type){
				
				case FacadeServiceManagerEvent.SHOW_DIALOG:
					DialogHelper.showLoadingDialog(e.data.message, e.data.title);
					break;
				
				case FacadeServiceManagerEvent.HIDE_DIALOG:
					DialogHelper.hideLoadingDialog(.2);
					break;
			}
		}
		 
		
		/**
		 * 
		 * @return 
		 */
		public function get service():FacadeServiceManager {
			
			 
			return FacadeServiceManager.instance;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get facade():GlobalFacade {
			
			return GlobalFacade.instance;
		}
		
		
		/*private function validateManager():void {

			if ( !_isInitialized )
				throw new Error( "ThemeManager: You must initialize the manager first" );
		}*/
	}
}


class SingletonLock {
}
