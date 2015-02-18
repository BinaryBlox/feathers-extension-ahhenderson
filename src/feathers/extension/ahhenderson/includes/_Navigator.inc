import feathers.extension.ahhenderson.util.ScreenUtil;
import feathers.controls.ScreenNavigator;

protected var _navigator:ScreenNavigator;
		
		public function get navigator():ScreenNavigator {
  
			return _navigator;
		}

		public function addScreen(id:String, screen:Object, events:Object = null, initializer:Object =
								  null):void{
			
			ScreenUtil.addScreen(this.navigator, id, screen, events, initializer);
			
		}
		
		public function removeScreen(  id:String ):void {
			
			ScreenUtil.removeScreen(this.navigator, id);
		}
		
		public function showScreen(  id:String, delay:int = 0 ):void {
			
			ScreenUtil.showScreen(this.navigator, id, delay);
		}