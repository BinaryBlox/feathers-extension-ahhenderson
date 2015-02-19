package feathers.extension.ahhenderson.data.service.mvc.controller
{
	import ahhenderson.core.managers.dependency.facadeService.AmfServiceRequest;
	import ahhenderson.core.managers.dependency.facadeService.constants.FacadeErrorConstants;
	import ahhenderson.core.mvc.interfaces.IFacadeMessage;
	
	import avmplus.getQualifiedClassName;
	
	import feathers.extension.ahhenderson.data.service.constants.DataService_SessionPropertyKeys;
	import feathers.extension.ahhenderson.data.service.mvc.actor.DataServiceCommand;
	
	public class DS_AmfServiceCommand extends DataServiceCommand
	{
		
		public static const NAME:String = getQualifiedClassName(DS_AmfServiceCommand);
	 
		
		public function DS_AmfServiceCommand(name:String=null)
		{
			if(!name)
				name = NAME;
			
			super(name);
		}
		
		override public function executeCommand(message:IFacadeMessage):void{
			
			const serviceRequest:AmfServiceRequest = (message.messageBody as AmfServiceRequest); 
			// TODO: add option to pass in arg for different service config key.
			const serviceConfigKey:String = this.fmgr.session.getProperty(DataService_SessionPropertyKeys.DEF_SERVICE_CONFIGURATION_KEY);
			
			if(!serviceRequest)
				throw new Error(FacadeErrorConstants.SERVICE_REQUEST_GROUP_REQUEST_DOES_NOT_EXIST);
			
			if(!serviceConfigKey)
				throw new Error(FacadeErrorConstants.SERVICE_CONFIGURATION_IS_EMPTY);
			   
			// Execute single service call.
			this.fmgr.service.invokeAMFServiceCall.apply(null, 
				[serviceConfigKey, 
					serviceRequest.serviceDefinition].concat(serviceRequest.args));
			 
			this.fmgr.logger.trace(this, "Invoking service call.."); 
			
		} 
		 
		
		override public function onRegister():void{
			 
			
			try {
				super.onRegister();
				
				
			} catch ( error:Error ) {
				throw( error );
			}
		}
		 
	}
}