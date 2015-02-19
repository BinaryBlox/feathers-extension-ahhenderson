package feathers.extension.ahhenderson.data.service.helpers {

	import ahhenderson.core.managers.dependency.facadeService.FacadeServiceConfiguration;
	import ahhenderson.core.managers.dependency.facadeService.constants.FacadeErrorConstants;
	
	import feathers.extension.ahhenderson.data.service.constants.DataService_SessionPropertyKeys;
	
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;



	/**
	 *
	 * @author thenderson
	 */
	public class DataServiceHelper {

		private static var _fmgr:FeathersApplicationManager;
		
		private static function get fmgr():FeathersApplicationManager
		{
			if(!_fmgr)
				_fmgr = FeathersApplicationManager.instance;
			
			return _fmgr;
		}
		
		public static function getDefaultServiceConfiguration():FacadeServiceConfiguration{
		 
			return fmgr.service.getServiceConfiguration(getDefaultServiceConfigurationKey());
			
		}
		
		public static function getDefaultServiceConfigurationKey():String{
			
			var defServiceConfigKey:String = fmgr.session.getProperty(DataService_SessionPropertyKeys.DEF_SERVICE_CONFIGURATION_KEY);
			
			if(!defServiceConfigKey)
				throw new Error(FacadeErrorConstants.FACADE_SERVICE_CONFIG_KEY_ERROR_MSG);
			
			return defServiceConfigKey;
			
		}

		public static function registerDefaultServiceConfiguration(key:String, endpoint:String, destination:String="fluorine", timeout:int=15000, modalWait:Boolean=true):void{
			
			// Register service configuration 
			fmgr.session.addProperty(DataService_SessionPropertyKeys.DEF_SERVICE_CONFIGURATION_KEY, key);
			fmgr.session.addProperty(DataService_SessionPropertyKeys.DEF_SERVICE_DESTINATION, destination);
			fmgr.session.addProperty(DataService_SessionPropertyKeys.DEF_SERVICE_ENDPOINT, endpoint);
			fmgr.session.addProperty(DataService_SessionPropertyKeys.DEF_SERVICE_TIMEOUT, timeout);
			fmgr.session.addProperty(DataService_SessionPropertyKeys.DEF_SERVICE_MODAL_WAIT_DEFAULT, modalWait);
			
			var fscfg:FacadeServiceConfiguration = new FacadeServiceConfiguration(key, destination, endpoint, null, null, timeout, modalWait);
		 
			//TODO: Throw error if some values are not present.
			// Register configuration
			fmgr.service.registerServiceConfiguration(fscfg);
		}
		
		 /**
		 *
		 * @param serviceObject
		 * @param alertCloseFunction
		 * @param alertTitle
		 * @param alertMessage
		 * @param buttons (Ok is default);
		 *
		 * <p>Note: to add buttons and listen for events on them, add  { label: "OK", triggered: okButton_triggeredHandler }</p>
		 * @return
		 */
		/*public static function isServiceError( serviceObject:*, alertCloseFunction:Function = null, alertTitle:String = null,
											   alertMessage:String = null, buttons:ListCollection = null ):Boolean {

			// If buttons don't exist, use defauilt OK button
			if ( !buttons || buttons.length == 0 )
				buttons = new ListCollection([{ label: "OK" }])

			if ( !serviceObject || !( serviceObject is IVzServiceError )) {
				DialogHelper.showAlert( "Not IVzServiceError",
									"This object is not permitted by this function(isServiceError).",
									alertCloseFunction,
									buttons );

				return true;
			}

			const exception:VzServiceError = ( serviceObject as IVzServiceError ).Exception;

			// No service error exception found.
			if ( !exception )
				return false;

			if ( !alertTitle )
				alertTitle = ( exception.Name ) ? exception.Name : API_DefaultValues.EXCEPTION_ALERT_TITLE;

			if ( !alertMessage )
				alertMessage = ( exception.Description ) ? exception.Description : API_DefaultValues.EXCEPTION_ALERT_MESSAGE;

			DialogHelper.showAlert( alertTitle, alertMessage, alertCloseFunction, buttons );

			return true;
		}*/

	}
}
