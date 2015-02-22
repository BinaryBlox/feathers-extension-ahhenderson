package feathers.extension.ahhenderson.mvc.actor {

	import ahhenderson.core.mvc.interfaces.IModelActor;
	import ahhenderson.core.mvc.patterns.actor.ModelActor;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;


	public class FeathersModel extends ModelActor implements IModelActor {
		public function FeathersModel( name:String = null ) {

			super( name );
		}

		include "../../_includes/_FeathersAppManager.inc";

		override public function beforeRemove():void {

			super.beforeRemove();

			this.fmgr.logger.trace( this, "Model removed..." );

		}

		override public function onRegister():void {

			super.onRegister();

			this.fmgr.logger.trace( this, "Model registered..." );

		}

		 
	}
}
