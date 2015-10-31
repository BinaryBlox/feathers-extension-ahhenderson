package feathers.extension.ahhenderson.controls.screens.drawers
{
	import feathers.controls.Header;
	import feathers.skins.IStyleProvider;
	
	public class TopDrawerHeader extends Header
	{
		
		public static var globalStyleProvider:IStyleProvider;
		
		/**
		 * @private
		 */
		override protected function get defaultStyleProvider():IStyleProvider {
			
			return TopDrawerHeader.globalStyleProvider;
		}
		
		public function TopDrawerHeader()
		{
			super();
			 
		}
		
		override protected function initialize():void{
			
			super.initialize();
			
			
		}
	}
}