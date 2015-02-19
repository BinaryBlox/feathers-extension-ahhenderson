package feathers.extension.ahhenderson.data.service.mvc.actor {

	import ahhenderson.core.mvc.interfaces.IMediatorActor;
	import feathers.extension.ahhenderson.data.service.helpers.DataServiceFacadeHelper;
	import feathers.extension.ahhenderson.mvc.actor.FeathersMediator;


	public class DataServiceMediator extends FeathersMediator implements IMediatorActor {

		include "_BaseDataServiceActor.inc"

		public function DataServiceMediator( name:String = null, component:Object = null ) {

			super( name, component );
		}

		override protected function setMessageFilter():void {

			DataServiceFacadeHelper.registerMediator( this, _messageFilter );

		}
	}
}
