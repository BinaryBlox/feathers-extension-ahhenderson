package feathers.extension.ahhenderson.data.service.mvc.controller
{
	import ahhenderson.core.managers.dependency.facadeService.AmfServiceRequestGroup;
	import ahhenderson.core.managers.dependency.facadeService.constants.FacadeErrorConstants;
	import ahhenderson.core.mvc.interfaces.IFacadeMessage;
	
	import avmplus.getQualifiedClassName;
	
	import feathers.extension.ahhenderson.data.service.constants.DataService_SessionPropertyKeys;
	import feathers.extension.ahhenderson.data.service.mvc.actor.DataServiceCommand;
	
	public class DS_GroupedAmfServiceCommand extends DataServiceCommand
	{
		
		public static const NAME:String = getQualifiedClassName(DS_GroupedAmfServiceCommand);
		
	 
		
		public function DS_GroupedAmfServiceCommand(name:String=null)
		{
			if(!name)
				name = NAME;
			
			super(name);
		}
		
		override public function executeCommand(message:IFacadeMessage):void{
			
			const serviceRequestGroup:AmfServiceRequestGroup = (message.messageBody as AmfServiceRequestGroup); 
			// TODO: add option to pass in arg for different service config key.
			const serviceConfigKey:String = this.fmgr.session.getProperty(DataService_SessionPropertyKeys.DEF_SERVICE_CONFIGURATION_KEY);
			
			if(!serviceRequestGroup)
				throw new Error(FacadeErrorConstants.SERVICE_REQUEST_GROUP_DOES_NOT_EXIST);
			
			if(!serviceConfigKey)
				throw new Error(FacadeErrorConstants.SERVICE_CONFIGURATION_IS_EMPTY);
			
			this.fmgr.service.invokeAMFGroupedServicesCall(serviceConfigKey, 
				serviceRequestGroup.groupKey, 
				serviceRequestGroup.amfServiceRequests,
				serviceRequestGroup.resultNotificationId,
				serviceRequestGroup.faultNotificationId,
				serviceRequestGroup.modalWait,
				serviceRequestGroup.modalWaitMessage)
			
			this.fmgr.logger.trace(this, "Invoking grouped service call.."); 
			
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