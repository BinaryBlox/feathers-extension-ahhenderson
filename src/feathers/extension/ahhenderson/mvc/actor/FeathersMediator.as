package feathers.extension.ahhenderson.mvc.actor {

	import ahhenderson.core.mvc.interfaces.IMediatorActor;
	import ahhenderson.core.mvc.patterns.actor.MediatorActor;
	import ahhenderson.core.mvc.patterns.facade.GlobalFacade;
	
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;


	public class FeathersMediator extends MediatorActor implements IMediatorActor {
		public function FeathersMediator( name:String = null, component:Object = null ) {

			super( name, component );
		} 
		 
		protected function get fmgr():FeathersApplicationManager {
  
			return FeathersApplicationManager.instance;
		}

		override public function onRegister():void {

			super.onRegister();

			this.fmgr.logger.trace( this, "Mediator registered..." );

		}

		override public function beforeRemove():void {

			super.beforeRemove();

			this.fmgr.logger.trace( this, "Mediator removed..." );

		}
		
		override protected function setMessageFilter():void {
			GlobalFacade.instance.registerMediator(this, _messageFilter  );
			
		}
	}
}
