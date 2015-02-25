 
package feathers.extension.ahhenderson.controls.supportClasses {

	import ahhenderson.core.mvc.interfaces.IMediatorActor;
	
	import starling.animation.Transitions;
	import starling.core.Starling;


	public class AbstractPanelNavigatorFormScreenMediator extends AbstractPanelNavigatorScreenMediator implements IMediatorActor {

		public function AbstractPanelNavigatorFormScreenMediator( mediatorName:String, component:* = null ) {

			super( mediatorName, component );
		}
 
		override public function onRegister():void {
 

			super.onRegister();
			
			initFormControlData();
		}

	  
		override protected function initScreen():void{
			
			super.initScreen();
			
			view.touchable = false;
			
			// Make children visible 
			view.formControlList.dataProvider = view.formControlListDataProvider;
			
			view.formControlList.alpha = 0;
			view.formControlList.visible = true;
			
			Starling.juggler.tween( view.formControlList,
				.25,
				{ transition: Transitions.EASE_OUT, alpha: 1, onComplete: onFadeInTweenComplete });

			
		}
 
		protected function initFormControlData():void{
			
			throw new Error("Must override initFormControlData()");
		}
 
		
		private function get view():AbstractPanelNavigatorFormScreen {
			
			return component as AbstractPanelNavigatorFormScreen;
		} 
		
	}
}
