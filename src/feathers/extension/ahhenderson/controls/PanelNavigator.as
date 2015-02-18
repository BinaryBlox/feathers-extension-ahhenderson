package feathers.extension.ahhenderson.controls {

	import feathers.controls.IScreen;
	import feathers.controls.Panel;
	import feathers.extension.ahhenderson.themes.helpers.UI_FactoryHelper;
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

		include "../includes/_FeathersAppManager.inc";
		include "../includes/_Navigator.inc";
		include "../includes/_Panel.inc";

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

			// Get navigator from pool
			_navigator = UI_FactoryHelper.screenNavigatorFactory();
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
