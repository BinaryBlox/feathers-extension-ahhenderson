package feathers.extension.ahhenderson.constants {

	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	import feathers.utils.math.roundToNearest;


	public class FeathersExtLib_ThemeConstants {
		public function FeathersExtLib_ThemeConstants() {
		}

		private static var _fmgr:FeathersApplicationManager;

		public static const BOTTOM_PICKER_LIST_CLOSE_BUTTON_LABEL:String ="Done";
		
		public static var CONTROL_GUTTER:Number = roundToNearest(10 * fmgr.theme.scaledResolution);

		public static var ITEM_RENDERER_MIN_SIZE:Number = roundToNearest(30 * fmgr.theme.scaledResolution); 

		public static var TOUCH_BOUNDARY_MULTIPLIER:Number = 1.15;
		
		public static var FORM_SECTION_SPACER:Number = roundToNearest(20*fmgr.theme.scaledResolution);

		public static var PANEL_GUTTER:Number = roundToNearest(20 * fmgr.theme.scaledResolution);
		
		public static var PANEL_WIDTH:Number = roundToNearest(300 * fmgr.theme.scaledResolution);
		
		public static var CALLOUT_MAX_SIZE:Number = roundToNearest(250 * fmgr.theme.scaledResolution);

		public static const ASSET_FOLDER_SCALE_1:String = "1";
		
		public static const ASSET_FOLDER_SCALE_2:String = "2";
		
		public static const ASSET_FOLDER_SCALE_3:String = "3";
		
		
		private static function get fmgr():FeathersApplicationManager {

			if ( !_fmgr )
				_fmgr = FeathersApplicationManager.instance;

			return _fmgr;
		}

	}
}
