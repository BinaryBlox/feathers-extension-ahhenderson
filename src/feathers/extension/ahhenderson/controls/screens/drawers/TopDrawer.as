package feathers.extension.ahhenderson.controls.screens.drawers
{
	import feathers.controls.Header;
	import feathers.skins.IStyleProvider;
	
	public class TopDrawer extends Header
	{
		
		public static var globalStyleProvider:IStyleProvider;
		
		/**
		 * @private
		 */
		override protected function get defaultStyleProvider():IStyleProvider {
			
			return TopDrawer.globalStyleProvider;
		}
		
		public function TopDrawer()
		{
			super();
			
			this.title = "Bad adss";
		}
		
		override protected function initialize():void{
			
			super.initialize();
			 
			
		}
	}
}