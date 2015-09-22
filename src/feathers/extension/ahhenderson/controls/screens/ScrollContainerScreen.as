package feathers.extension.ahhenderson.controls.screens
{
	import feathers.controls.ScrollScreen;
	import feathers.events.FeathersEventType;
	
	import starling.events.Event;

	public class ScrollContainerScreen extends ScrollScreen
	{
		public function ScrollContainerScreen()
		{
			super();
		}
		
		override protected function initialize():void{
			
			super.initialize();
			
			this.owner.addEventListener(FeathersEventType.TRANSITION_COMPLETE, onScreenTransitionComplete);
		}
		
		protected function onScreenTransitionComplete(event:Event):void
		{
			this.owner.removeEventListener(FeathersEventType.TRANSITION_COMPLETE, onScreenTransitionComplete);
			
			
		}
	 
	}
}