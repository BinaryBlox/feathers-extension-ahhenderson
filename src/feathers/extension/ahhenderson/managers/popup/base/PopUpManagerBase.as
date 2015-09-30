package feathers.extension.ahhenderson.managers.popup.base {
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
	import ahhenderson.core.ui.constants.MenuConstants;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.extension.ahhenderson.interfaces._deprecate.IMenu;
	import feathers.extension.ahhenderson.managers.enums.MenuPosition;
	import feathers.extension.ahhenderson.managers.events.MenuEvent;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	/**
	 *
	 * @author thenderson
	 */
	public class PopUpManagerBase extends VerticalCenteredPopUpContentManager {
		
		/**
		 * The default factory that creates overlays for modal pop-ups.
		 */
		private static function defaultOverlayFactory():DisplayObject {
			
			const quad:Quad = new Quad( 1, 1, 0x000000 );
			quad.alpha = 0;
			return quad;
		}

		/**
		 *
		 */
		public function PopUpManagerBase() {
		}
		
		private var _duration:Number;
		
		private var _isAnimating:Boolean;

		private var _messageFilter:FacadeMessageFilter;

		private var _popUpCloseMessage:FacadeMessage

		public function get duration():Number
		{
			return _duration;
		}

		public function set duration(value:Number):void
		{
			_duration = value;
		}

		public function get isAnimating():Boolean {

			return _isAnimating;
		}

		public function set isAnimating( value:Boolean ):void {

			_isAnimating = value;
		}

		public function get messageFilter():FacadeMessageFilter {

			if ( !_messageFilter )
				_messageFilter = new FacadeMessageFilter([ MenuConstants.MESSAGE_TOP_LEVEL_MENU ]);

			return _messageFilter;
		}

		public function set messageFilter( value:FacadeMessageFilter ):void {

			_messageFilter = value;
		}
		
		override public function open( content:DisplayObject, source:DisplayObject ):void {
			
			if ( !this.defaultOverlayFunction )
				this.defaultOverlayFunction = defaultOverlayFactory;
			
			super.open(content, source);
			
		}

		public function get popUpCloseMessage():FacadeMessage
		{
			return _popUpCloseMessage;
		}

		public function set popUpCloseMessage(value:FacadeMessage):void
		{
			_popUpCloseMessage = value;
		}
	}
}
