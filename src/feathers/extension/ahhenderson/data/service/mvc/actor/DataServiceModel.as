package feathers.extension.ahhenderson.data.service.mvc.actor {

	import ahhenderson.core.mvc.interfaces.IModelActor;
	
	import feathers.extension.ahhenderson.mvc.actor.FeathersModel;


	public class DataServiceModel extends FeathersModel implements IModelActor {
		public function DataServiceModel( name:String = null ) {

			super( name );
		}

		include "_BaseDataServiceActor.inc"
		 
		 
		public function dispatchModelUpdate():void{
			
			
		}
	}
}
