package feathers.extension.ahhenderson.data.service.mvc.actor {

	import mx.rpc.Fault;
	
	import ahhenderson.core.mvc.events.GlobalFacadeMessageEvent;
	import ahhenderson.core.mvc.interfaces.IFacadeMessage;
	
	import feathers.extension.ahhenderson.helpers.DialogHelper;
	import feathers.extension.ahhenderson.interfaces.IDataServiceCommand;
	import feathers.extension.ahhenderson.mvc.actor.FeathersCommand;


	public class DataServiceCommand extends FeathersCommand implements IDataServiceCommand {

		include "_BaseDataServiceActor.inc"

		public function DataServiceCommand( name:String = null ) {

			super( name );

		}

		public function endServiceCommand():void {
 
			// Remove facade listener 
			this.fmgr.facade.removeEventListener( GlobalFacadeMessageEvent.GLOBAL_MESSAGE_MANAGER_EVENT, onFacadeMessageEvent );
			
		}

		override public function executeCommand( message:IFacadeMessage ):void {
 
			startServiceCommand( message );
		}

		public function handleServiceCommandResult( message:IFacadeMessage ):void {

			
			endServiceCommand();

		}

		public function startServiceCommand( message:IFacadeMessage ):void {

			// Add facade listener
			this.fmgr.facade.addEventListener( GlobalFacadeMessageEvent.GLOBAL_MESSAGE_MANAGER_EVENT, onFacadeMessageEvent );
			

		}

		private function onFacadeMessageEvent( e:GlobalFacadeMessageEvent ):void {

			handleFacadeMessage( e.message );

		}
		
		protected function displayFaultMessage( facadeMessage:IFacadeMessage, title:String="Service Error", alertCloseFunction:Function=null):void{
			
			DialogHelper.hideLoadingDialog();
			
			if(!facadeMessage.messageBody as Fault ){
				DialogHelper.showAlert( "Error",
					"Item is not a Fault",
					alertCloseFunction );
				return;
			}
			
			DialogHelper.showAlert( title,
				DialogHelper.getFaultString( facadeMessage.messageBody as Fault ),
				alertCloseFunction );
		}
	}
}
