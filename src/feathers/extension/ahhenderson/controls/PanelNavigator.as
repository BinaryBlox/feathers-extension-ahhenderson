package feathers.extension.ahhenderson.controls {

	import feathers.controls.IScreen;
	import feathers.controls.Panel;
	import feathers.controls.ScreenNavigator;
	import feathers.extension.ahhenderson.helpers.UiFactoryHelper;
	import feathers.extension.ahhenderson.util.ScreenUtil;
	import feathers.layout.AnchorLayoutData;
	import feathers.skins.IStyleProvider;


	/**
	 * 
	 * @author thenderson
	 */
	public class PanelNavigator extends Panel {
		/**
		 * 
		 */
		public function PanelNavigator() {

			super();
		}

		include "../_includes/_FeathersAppManager.inc";
		//include "../_includes/_Navigator.inc";
		include "../_includes/_Panel.inc";

		protected var _navigator:ScreenNavigator;
		
		private var _lastScreenId:String;
		
		
		public function get lastScreenId():String
		{
			return _lastScreenId;
		}

		public function get navigator():ScreenNavigator {
			
			return _navigator;
		}
		
		public function addScreen(id:String, screen:Object, events:Object = null, initializer:Object =
								  null):void{
			 
			if(!initializer) 
				initializer = {};
			
			// add reference to PanelNavigator
			updateInitializer(initializer);
			
			ScreenUtil.addScreen(this.navigator, id, screen, events, initializer);
			
		}
		
		protected function updateInitializer(initializer:Object):void{
			
			initializer["panelNavigator"] = this;
			
		}
		
		public function removeScreen(  id:String ):void {
			
			ScreenUtil.removeScreen(this.navigator, id);
		}
		
		public function showLastScreen(delay:int=0):void{
			
			if(!this.lastScreenId)
				return;
			
			ScreenUtil.showScreen(this.navigator, this.lastScreenId, delay);
			
		}
		
		public function showScreen(  id:String, delay:int = 0, transition:Function=null ):void {
			_lastScreenId = this.navigator.activeScreenID;
			
			ScreenUtil.showScreen(this.navigator, id, delay, transition);
		}
		
		/**
		 * 
		 * @default 
		 */
		public static var globalStyleProvider:IStyleProvider;

		override protected function get defaultStyleProvider():IStyleProvider {

			return PanelNavigator.globalStyleProvider;
		}

		override protected function initialize():void {

			super.initialize();

			//var bottomPadding:Number = 20 * this.scaledResolution;
			
			// Get navigator from pool
			_navigator = UiFactoryHelper.screenNavigatorFactory();
			_navigator.layoutData = new AnchorLayoutData( 0, 0, 0, 0 );
			 
			this.addChild( _navigator );
		}

	
		/**
		 * Returns a PanelNavigator from a screen (easy for transitions)
		 * @param screen
		 * @return 
		 */
		public static function utilGetPanelNavigatorFromScreen(screen:IScreen):PanelNavigator{
			
			if(screen.parent && screen.parent.parent){
				
				var panNav:PanelNavigator = (screen.parent.parent.parent as PanelNavigator);
				
				if(!panNav) 
					FeathersApplicationManager.instance.logger.trace("Panel Navigator", "Panel navigator not found from screen");
					
				return panNav;
				 
			}
			
			return null;
		}
 
		 
		override protected function layoutChildren():void {

			super.layoutChildren();
		}

	}

}
