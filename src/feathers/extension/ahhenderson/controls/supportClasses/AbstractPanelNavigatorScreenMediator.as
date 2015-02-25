package feathers.extension.ahhenderson.controls.supportClasses {

	import ahhenderson.core.mvc.interfaces.IMediatorActor;
	import feathers.extension.ahhenderson.data.service.mvc.actor.DataServiceMediator;
	import starling.events.Event;


	public class AbstractPanelNavigatorScreenMediator extends DataServiceMediator implements IMediatorActor {

		public function AbstractPanelNavigatorScreenMediator( mediatorName:String, component:* = null ) {

			super( mediatorName, component );
		}

		override public function beforeRemove():void {

			super.beforeRemove();

			removeListeners();
		}

		override public function onRegister():void {

			// Events 
			addListeners();

			// Init
			initScreen()

			super.onRegister();
		}

		public function showScreen( id:String, delay:int = 0 ):void {

			if ( !view.panelNavigator )
				return;

			view.panelNavigator.showScreen( id, delay );
		}

		protected function addListeners():void {

			view.btnNext.addEventListener( Event.TRIGGERED, onButtonTriggered );
			view.btnBack.addEventListener( Event.TRIGGERED, onButtonTriggered );

		}

		protected function initScreen():void {

			//view.touchable = false;

		/*
					Starling.juggler.tween( view.formControlList,
											.25,
											{ transition: Transitions.EASE_OUT, alpha: 1, onComplete: onFadeInTweenComplete });
		*/
		}

		protected function onButtonBackTriggered():void {

			view.showLastScreen();
		}

		protected function onButtonContinueTriggered():void {

		}

		protected function onButtonTriggered( e:starling.events.Event ):void {

			switch ( e.target ) {

				case view.btnBack:

					onButtonBackTriggered();

					break;

				case view.btnNext:

					if ( !validateForm())
						return;

					onButtonContinueTriggered();

					return;
			}

		}

		protected function onFadeInTweenComplete():void {

			view.touchable = true;
		}

		protected function removeListeners():void {

			view.btnNext.removeEventListener( Event.TRIGGERED, onButtonTriggered );
			view.btnBack.removeEventListener( Event.TRIGGERED, onButtonTriggered );

		}

		protected function validateForm():Boolean {

			throw new Error( "Method validateForm must be overriden.." );
		}

		private function get view():AbstractPanelNavigatorScreen {

			return component as AbstractPanelNavigatorScreen;
		}
	}
}
