 
package feathers.extension.ahhenderson.data.service.helpers {

	import ahhenderson.core.mvc.interfaces.ICommandActor;
	import ahhenderson.core.mvc.interfaces.IMediatorActor;
	import ahhenderson.core.mvc.interfaces.IModelActor;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
	import ahhenderson.core.mvc.patterns.facade.GlobalFacade;
	
	import feathers.extension.ahhenderson.data.service.constants.DataService_NotificationConstants;


	/**
	 *
	 * @author thenderson
	 */
	public class DS_FacadeHelper {
 
		
		private static var _facade:GlobalFacade;
		
		private static function get facade():GlobalFacade
		{
			if(!_facade)
				_facade = GlobalFacade.instance;
			
			return _facade;
		}
		
		 
		
		/**
		 * Adds new filter group to Message Filter object
		 * @param filterName
		 * @param filter
		 */
		public static function addMessageGroupFilter(filterName:String, filter:FacadeMessageFilter):void{
			if(!filter)
				return;
			
			if(!filter.messageGroups){
				filter.messageGroups = [filterName];
			}
			else{ 
				if(filter.messageGroups.indexOf(filterName) < 0)
					filter.messageGroups.push(filterName);
			} 
		}
		
		/**
		 * Adds new filter type to Message Filter object
		 * @param filterName
		 * @param filter
		 */
		public static function addMessageTypeFilter(filterName:String, filter:FacadeMessageFilter):void{
			if(!filter)
				return;
			
			if(!filter.messageTypes){
				filter.messageTypes = [filterName];
			}
			else{
				if(filter.messageTypes.indexOf(filterName) < 0)
					filter.messageTypes.push(filterName);
			} 
		}
		
		public static function addDefaultAPI_MessageGroupFilters(filter:FacadeMessageFilter):void{
			
			var defaultMessageGroupFilter:String = DS_Helper.getDefaultServiceConfigurationKey();
			
			// Add default API Groups
			addMessageGroupFilter(defaultMessageGroupFilter, filter = (filter) ? filter : new FacadeMessageFilter());
			addMessageGroupFilter(DataService_NotificationConstants.NF_GRP__SERVICES_API_SUBSCRIBER, filter);
			
		}
		
		  
		/**
		 * Registers model with default message group to receive API notifications
		 * @param actor
		 * @param filter
		 */
		public static function registerModel(actor:IModelActor, filter:FacadeMessageFilter=null):void{
			
			addDefaultAPI_MessageGroupFilters(filter = (filter) ? filter : new FacadeMessageFilter());
			
			facade.registerModel(actor, filter); 
		}
		
		
		/**
		 * Registers mediator with default message group to receive API notifications
		 * @param actor
		 * @param filter
		 */
		public static function registerMediator(actor:IMediatorActor, filter:FacadeMessageFilter=null):void{
			
			addDefaultAPI_MessageGroupFilters(filter = (filter) ? filter : new FacadeMessageFilter());
		  
			facade.registerMediator(actor, filter);
		}
		
		/**
		 * Registers mediator with default message group to receive API notifications
		 * @param actor
		 * @param filter
		 */
		public static function registerCommand(actor:ICommandActor, filter:FacadeMessageFilter=null):void{
			
			addDefaultAPI_MessageGroupFilters(filter = (filter) ? filter : new FacadeMessageFilter());
			
			facade.registerCommand(actor, filter);
		}
	}
}
