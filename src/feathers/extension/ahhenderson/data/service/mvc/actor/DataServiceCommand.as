package feathers.extension.ahhenderson.data.service.mvc.actor {

	import ahhenderson.core.mvc.interfaces.ICommandActor;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
	import feathers.extension.ahhenderson.mvc.actor.FeathersCommand;


	public class DataServiceCommand extends FeathersCommand implements ICommandActor {
		public function DataServiceCommand( name:String = null ) {

			super( name );
		}
		
		include "_BaseDataServiceActor.inc"
		
	}
}
