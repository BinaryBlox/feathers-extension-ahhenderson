package feathers.extension.ahhenderson.util {

	import flash.ui.Keyboard;
	
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_StyleNameConstants;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_ThemeConstants;
	import feathers.utils.math.roundToNearest;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;


	/**
	 *
	 * @author thenderson
	 */
	public class FeathersUtil {
		/**
		 *
		 */
		public function FeathersUtil() {
		}

		internal static var _calloutLabel:Label;

		internal static var _callout:Callout;

		internal static var _overlay:Quad;
		/**
		 * The default factory that creates callouts when <code>Callout.show()</code>
		 * is called. To use a different factory, you need to set
		 * <code>Callout.calloutFactory</code> to a <code>Function</code>
		 * instance.
		 */
		private static function constrainedCalloutFactory():Callout {

			var callout:Callout = new Callout();
			callout.topArrowGap=callout.bottomArrowGap=callout.rightArrowGap=callout.leftArrowGap=-2;
			callout.closeOnTouchBeganOutside = true;
			callout.closeOnTouchEndedOutside = true;
			callout.closeOnKeys = new <uint>[ Keyboard.BACK, Keyboard.ESCAPE ];
			callout.maxWidth = callout.maxHeight =  FeathersExtLib_ThemeConstants.CALLOUT_MAX_SIZE;
			
			return callout;
		}

		/**
		 * @copy PopUpManager#defaultOverlayFactory()
		 */
		public static function darkOverlayFactory():DisplayObject
		{
			if(!_overlay){
				_overlay = new Quad(100, 100, 0x000000);
				_overlay.alpha = .5;
			} 
			return _overlay;
		}
		
		public static function showCallout( message:String, origin:DisplayObject, supportedDirections:String = Callout.DIRECTION_ANY,
											isModal:Boolean = true, customCalloutFactory:Function = null, customOverlayFactory:Function =
			null ):void {

			if ( !_calloutLabel ) {
				_calloutLabel = new Label();
				_calloutLabel.textRendererProperties.wordWrap = true;
				_calloutLabel.styleNameList.add( FeathersExtLib_StyleNameConstants.LABEL_ALTERNATE_DARK_STYLE_NAME_NORMAL );
				_calloutLabel.maxWidth = roundToNearest(FeathersExtLib_ThemeConstants.CALLOUT_MAX_SIZE - (FeathersExtLib_ThemeConstants.CONTROL_GUTTER*2));
			}

			_calloutLabel.text = message;
			_calloutLabel.validate();

			_callout =
				Callout.show( DisplayObject( _calloutLabel ),
											 origin,
											 supportedDirections,
											 isModal,
											 (customCalloutFactory) ? customCalloutFactory : constrainedCalloutFactory,
											 (customOverlayFactory) ? customOverlayFactory : darkOverlayFactory );

			//we're reusing the message every time that this screen shows a
			//callout, so we don't want the message to be disposed. we'll
			//dispose of it manually later when the screen is disposed.
			_callout.disposeContent = false;
		}
	}
}
