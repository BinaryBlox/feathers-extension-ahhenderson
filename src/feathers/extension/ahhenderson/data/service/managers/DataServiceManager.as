package feathers.extension.ahhenderson.data.service.managers {
	
	import flash.events.EventDispatcher;
	
	import feathers.extension.ahhenderson.data.service.constants.DataService_NotificationConstants;
	import feathers.extension.ahhenderson.data.service.helpers.DS_FacadeHelper;
	import feathers.extension.ahhenderson.data.service.mvc.controller.DS_AmfServiceCommand;
	import feathers.extension.ahhenderson.data.service.mvc.controller.DS_GroupedAmfServiceCommand;
	
	//import feathers.extension.feathers_extension_internal;
	
	//use namespace feathers_extension_internal;
	
	/**
	 *
	 * @author thenderson
	 */
	/*[Event(name="themeAssetLoadingComplete", type="feathers.extension.managers.dependency.themeManager.events.ThemeManagerEvent")]
	[Event(name="themeAssetLoadingProgress", type="feathers.extension.managers.dependency.themeManager.events.ThemeManagerEvent")]*/
	public class DataServiceManager extends EventDispatcher {
		
		private static const _instance:DataServiceManager = new DataServiceManager( SingletonLock );
		 
		
		public function get isDebuggable():Boolean
		{
			return _isDebuggable;
		}

		public function get isInitialized():Boolean
		{
			return _isInitialized;
		}
		
		 
		/**
		 * 
		 * @return 
		 */
		public static function get instance():DataServiceManager {
			
			return _instance;
		}
		
		 
		
		private var _isInitialized:Boolean;
	 
		private var _isDebuggable:Boolean; 
		
		/**
		 *
		 * @param lock
		 * @throws Error
		 */
		public function DataServiceManager( lock:Class ) {
			
			if ( lock != SingletonLock ) {
				throw new Error( "Invalid Singleton access.  Use Model.instance." );
			}
		}
		 
		
		private function registerMVC_Actors():void{
			
			// Facade service manager
			DS_FacadeHelper.registerCommand(new DS_AmfServiceCommand(DataService_NotificationConstants.N_CMD_SERVICE_AMF_CALL));  
			DS_FacadeHelper.registerCommand(new DS_GroupedAmfServiceCommand(DataService_NotificationConstants.N_CMD_SERVICE_AMF_GROUPED_CALL));
		}
		
		public function initialize(isDebuggable:Boolean = false ):void {
			 
 			_isDebuggable = isDebuggable;
			
			registerMVC_Actors();
			
			// Initialization constraints have been met
			_isInitialized = true; 
			
		}
	
		
		private function validateManager():void {
			
			if ( !_isInitialized )
				throw new Error( "API Manager: You must initialize the manager first" );
		}
		
		 
		
	}
} 


class SingletonLock {
}
