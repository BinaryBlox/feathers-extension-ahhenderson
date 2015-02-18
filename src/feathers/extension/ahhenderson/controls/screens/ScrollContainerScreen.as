package feathers.extension.ahhenderson.controls.screens
{
	import feathers.events.FeathersEventType;
	
	import starling.events.Event;
	import feathers.controls.IScreen;
	import feathers.controls.ScrollContainer;

	public class ScrollContainerScreen extends ScrollContainer implements IScreen
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
		
		/**
		 * @private
		 */
		protected var _screenID:String;
		
		/**
		 * @inheritDoc
		 */
		public function get screenID():String
		{
			return this._screenID;
		}
		
		/**
		 * @private
		 */
		public function set screenID(value:String):void
		{
			this._screenID = value;
		}
		
		/**
		 * @private
		 */
		protected var _owner:Object;
		
		/**
		 * @inheritDoc
		 */
		public function get owner():Object
		{
			return this._owner;
		}
		
		/**
		 * @private
		 */
		public function set owner(value:Object):void
		{
			this._owner = value;
		}
	}
}