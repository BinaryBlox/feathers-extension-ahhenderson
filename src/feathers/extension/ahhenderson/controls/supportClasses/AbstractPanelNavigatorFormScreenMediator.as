//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.controls.supportClasses {

	import ahhenderson.core.mvc.interfaces.IFacadeMessage;
	import ahhenderson.core.mvc.interfaces.IMediatorActor;
	
	import feathers.extension.ahhenderson.controls.PanelNavigator;
	import feathers.extension.ahhenderson.data.service.mvc.actor.DataServiceMediator;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.events.Event;


	public class AbstractPanelNavigatorFormScreenMediator extends DataServiceMediator implements IMediatorActor {

		public function AbstractPanelNavigatorFormScreenMediator( mediatorName:String, component:* = null ) {

			super( mediatorName, component );
		}

		

		public function showScreen(id:String, delay:int=0):void{
			
			if(!view.panelNavigator)
				return;
			
			view.panelNavigator.showScreen(id, delay);
		}
		
		override public function beforeRemove():void {

			super.beforeRemove();

			removeListeners();
		}

		override public function handleFacadeMessage( message:IFacadeMessage ):void {

		}

		 

		protected function onButtonBackTriggered():void {
			view.showLastScreen(); 
		}

		protected function onButtonContinueTriggered():void {

		}

		override public function onRegister():void {

			//_mbrModel = this.fmgr.facade.getModel( MembershipModel.NAME ) as MembershipModel;

			// Events 
			addListeners();

			// Init
			initView()
			 
			initFormControlData();

			super.onRegister();
		}

	 
 

		protected function validateForm(  ):Boolean {

			throw new Error("Method validateForm must be overriden..");

		}

		protected function initView():void {

			view.touchable = false;

			
			// Make children visible 
			view.formControlList.dataProvider = view.formControlListDataProvider;

			view.formControlList.alpha = 0;
			view.formControlList.visible = true;

			Starling.juggler.tween( view.formControlList,
									.25,
									{ transition: Transitions.EASE_OUT, alpha: 1, onComplete: onFadeInTweenComplete });

		}

		protected function onFadeInTweenComplete():void {

			view.touchable = true;
		}

		protected function addListeners():void {

			view.btnNext.addEventListener( Event.TRIGGERED, onButtonTriggered );
			view.btnBack.addEventListener( Event.TRIGGERED, onButtonTriggered );
 
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
		
		protected function initFormControlData():void{
			
			
		}

		protected function removeListeners():void {

			view.btnNext.removeEventListener( Event.TRIGGERED, onButtonTriggered );
			view.btnBack.removeEventListener( Event.TRIGGERED, onButtonTriggered );
  
		}
		
		private function get view():AbstractPanelNavigatorFormScreen {
			
			return component as AbstractPanelNavigatorFormScreen;
		}
		
		

		
	}
}
