package feathers.extension.ahhenderson.data.service.managers {
	
	import flash.events.EventDispatcher;
	
	import feathers.extension.ahhenderson.data.service.constants.DataService_NotificationConstants;
	import feathers.extension.ahhenderson.data.service.helpers.DataServiceFacadeHelper;
	import feathers.extension.ahhenderson.data.service.mvc.controller.DataService_AmfServiceCommand;
	import feathers.extension.ahhenderson.data.service.mvc.controller.DataService_GroupedAmfServiceCommand;
	
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
			DataServiceFacadeHelper.registerCommand(new DataService_AmfServiceCommand(DataService_NotificationConstants.N_CMD_SERVICE_AMF_CALL));  
			DataServiceFacadeHelper.registerCommand(new DataService_GroupedAmfServiceCommand(DataService_NotificationConstants.N_CMD_SERVICE_AMF_GROUPED_CALL));
		
			// Data access
			//API_FacadeHelper.registerCommand(new API_GetReferenceDataCommand(API_NotificationConstants.N_CMD_GET_REFERENCE_DATA)); 
		}
		
		public function initialize(isDebuggable:Boolean = false ):void {
			 
 			_isDebuggable = isDebuggable;
			
			registerMVC_Actors();
			updateServiceDefinitionDefaults();
			
			// Initialization constraints have been met
			_isInitialized = true; 
			
		}
		
		private function updateServiceDefinitionDefaults():void{
			
			// Update the default wait messages that are automatically generated.
			//ActivityFacadeServiceDefinition.GET_ACTIVITY_CONFIGURATION_DATA.modalWaitMessage ="Loading configuration...";
			/*ActivityFacadeServiceDefinition.GET_ALL_ACTIVITIES.modalWaitMessage ="Loading activities...";
			ActivityFacadeServiceDefinition.GET_ALL_ACTIVITY_ITEMS.modalWaitMessage ="Loading...";
			ActivityFacadeServiceDefinition.GET_ALL_ACTIVITY_SCHEDULES.modalWaitMessage ="Loading...";
			ActivityFacadeServiceDefinition.GET_ALL_PROGRAM_ACTIVITIES.modalWaitMessage ="Loading...";
			ActivityFacadeServiceDefinition.GET_ALL_PROGRAMS.modalWaitMessage ="Loading...";*/
			/*UserFacadeServiceDefinition.GET_APP_CONFIGURATION_DATA.modalWaitMessage ="Loading configuration...";
			UserFacadeServiceDefinition.CREATE_USER_BY_EMAIL.modalWaitMessage="Creating profile...";
			UserFacadeServiceDefinition.GET_USER_BY_EMAIL.modalWaitMessage="Loading profile...";
			UserFacadeServiceDefinition.LOGIN_BY_EMAIL.modalWaitMessage="Signing in...";
			UserFacadeServiceDefinition.USER_EXISTS.modalWaitMessage ="Loading...";*/
			
		}
		
		private function validateManager():void {
			
			if ( !_isInitialized )
				throw new Error( "API Manager: You must initialize the manager first" );
		}
		
		 
		
	}
} 


class SingletonLock {
}
