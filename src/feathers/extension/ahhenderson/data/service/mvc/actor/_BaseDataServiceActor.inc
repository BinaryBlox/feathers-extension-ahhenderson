import feathers.extension.ahhenderson.data.service.helpers.DS_FacadeHelper;
import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
	
override protected function sendFacadeMessage(messageId:String, messageBody:Object=null, messageFilter:FacadeMessageFilter=null, ...args):void{ 
			
	if(!messageFilter)
		messageFilter = this.messageFilter;
	
	DS_FacadeHelper.addDefaultAPI_MessageGroupFilters(messageFilter = (messageFilter) ? messageFilter : new FacadeMessageFilter());
	
	super.sendFacadeMessage.apply(null, [ messageId, messageBody, messageFilter ].concat( args ));
	
}

override protected function sendDelayedFacadeMessage(delay:int, message:FacadeMessage):void{
	
	if(!message)
		return 
	
	if(!message.messageFilter)
		message.messageFilter = this.messageFilter;
	
	DS_FacadeHelper.addDefaultAPI_MessageGroupFilters(message.messageFilter = (message.messageFilter) ? message.messageFilter : new FacadeMessageFilter());
	
	super.sendDelayedFacadeMessage(delay, message);
}

override protected function sendFacadeMessageObject(message:FacadeMessage):void{
	
	if(!message.messageFilter)
		message.messageFilter = this.messageFilter;
	
	DS_FacadeHelper.addDefaultAPI_MessageGroupFilters(message.messageFilter = (message.messageFilter) ? message.messageFilter : new FacadeMessageFilter());
	  
	super.sendFacadeMessageObject(message);
}