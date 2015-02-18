package feathers.extension.ahhenderson.managers.dependency.themeManager.events
{
	import flash.events.Event;
	
	public class ThemeManagerEvent extends Event
	{
		public function ThemeManagerEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_data = data;
			 
		}
		
		private var _data:*;
		
		public static const THEME_ASSET_LOADING_COMPLETE:String="themeAssetLoadingComplete";
		
		public static const THEME_ASSET_LOADING_PROGRESS:String="themeAssetLoadingProgress";
		
		 

		public function get data():*
		{
			return _data;
		}

	}
}