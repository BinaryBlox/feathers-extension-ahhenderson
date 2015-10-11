package feathers.extension.ahhenderson.controls.popUps {

	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
	import ahhenderson.core.mvc.patterns.facade.GlobalFacade;
	import ahhenderson.core.ui.constants.MenuConstants;
	
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.core.IFeathersControl;
	import feathers.core.IValidating;
	import feathers.extension.ahhenderson.helpers.DialogHelper;
	import feathers.extension.ahhenderson.interfaces.IPopUpExtendedContent;
	import feathers.extension.ahhenderson.managers.constants.ManagerNotificationConstants;
	import feathers.extension.ahhenderson.managers.enums.ContentPositionType;
	import feathers.extension.ahhenderson.managers.events.PopUpContentEvent;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.TouchEvent;


	[Exclude( name = "open", kind = "method" )]
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

		private var _contentPosition:ContentPositionType;

		private var _duration:Number;

		private var _isAnimating:Boolean;

		private var _isContentVisible:Boolean;

		private var _messageFilter:FacadeMessageFilter;

		private var _popUpCloseMessage:FacadeMessage

		override public function close():void {

			this.isContentVisible = false;
			this.isAnimating = false;

			if ( this.content && ( this.content is IPopUpExtendedContent )) {
				IPopUpExtendedContent( this.content ).removeEventListener( PopUpContentEvent.CONTENT_ITEM_TRIGGERED, onContentItemTriggered );
			}

			super.close();
		}

		public function get contentPosition():ContentPositionType {

			return _contentPosition;
		}

		public function set contentPosition( value:ContentPositionType ):void {

			_contentPosition = value;
		}

		public function get duration():Number {

			return _duration;
		}

		public function set duration( value:Number ):void {

			_duration = value;
		}

		public function get isAnimating():Boolean {

			return _isAnimating;
		}

		public function set isAnimating( value:Boolean ):void {

			_isAnimating = value;
		}

		public function get isContentVisible():Boolean {

			return _isContentVisible;
		}

		public function set isContentVisible( value:Boolean ):void {

			_isContentVisible = value;
		}

		public function get messageFilter():FacadeMessageFilter {

			if ( !_messageFilter )
				_messageFilter = new FacadeMessageFilter([ MenuConstants.MESSAGE_TOP_LEVEL_MENU ]);

			return _messageFilter;
		}

		public function set messageFilter( value:FacadeMessageFilter ):void {

			_messageFilter = value;
		}

		/**
		 * Displays the pop-up content.
		 *
		 * @param content		The content for the pop-up content manager to display.
		 * @param source		The source of the pop-up. May be used to position and/or size the pop-up. May be completely ignored instead.
		 */
		override public function open( content:DisplayObject, source:DisplayObject ):void {

			if ( !this.defaultOverlayFunction )
				this.defaultOverlayFunction = defaultOverlayFactory;

			super.open( content, source );

		}
		
		protected function initializeContentArgs():void{
			
		}
		
		protected function initializeContent():void{
			// Prep popUp Manager for new content.
			//resetPopUpManager();
		}
		
		protected function initializeContentPosition():void{
			// Prep popUp Manager for new content.
			//resetPopUpManager();
		}
		/*
		protected function resetPopUpManager():void {
			
			// Remove existing listeners.Ø
			if (_menu)
				_menu.removeEventListener(MenuEvent.MENU_CLOSED, onMenuClose);
			
			// Reinit popup
			_popUpManager.disableAutoClose=false;
			
			// Clear out existing content.
			_popUpManager.close();
		}*/

		public function openContent( position:ContentPositionType, content:DisplayObject, source:DisplayObject, duration:Number = .15, ...args ):void {

			if ( !( content is IPopUpExtendedContent ))
				return;

			// Set content position
			this.duration = duration;
			this.contentPosition = position;

			// Open
			open( content, source );

		}

		public function get popUpCloseMessage():FacadeMessage {

			return _popUpCloseMessage;
		}

		public function set popUpCloseMessage( value:FacadeMessage ):void {

			_popUpCloseMessage = value;
		}

		protected function hideContent( type:ContentPositionType, message:FacadeMessage = null ):void {

			DialogHelper.showAlert( "Most Override...", "PopUpManagerBase.hideContent" );

		}

		override protected function layout():void {

			if ( !( this.content is IFeathersControl )) {
				throw new TypeError( "The menu content is not valid" );
			}

			this.content.y = 1;

			//------ Prep screen for layout  
			layoutContentInternal( this.contentPosition );

			//------ Prep screen for display  
			showContentInternal( this.contentPosition );
		}

		protected function layoutContent( type:ContentPositionType ):void {

			DialogHelper.showAlert( "Most Override...", "PopUpManagerBase.layoutContent" );

		}

		protected function onContentItemTriggered( e:Event ):void {

			if ( e.data is FacadeMessage ) {
				hideContentLocal( this.contentPosition, e.data as FacadeMessage );

				return;
			}

			hideContentLocal( this.contentPosition, null );
		}

		protected function showContent( type:ContentPositionType ):void {

			DialogHelper.showAlert( "Most Override...", "PopUpManagerBase.showContent" );

		}

		override protected function stage_touchHandler( event:TouchEvent ):void {

			if ( event.interactsWith( this.content ) || this.isAnimating ) {
				return;
			}

			super.onStageTouchHandler( event );
		}

		protected function updateContentProperties():void {

			DialogHelper.showAlert( "Most Override...", "PopUpManagerBase.updateContentProperties" );
		}

		protected function updateContentTransparency( alpha:Number = 0 ):void {

			DialogHelper.showAlert( "Most Override...", "PopUpManagerBase.updateContentTransparency" );

		}

		protected function updateContentVisibility( visible:Boolean ):void {

			DialogHelper.showAlert( "Most Override...", "PopUpManagerBase.updateContentVisibility" );

		}

		private function hideContentLocal( type:ContentPositionType, message:FacadeMessage = null ):void {

			if ( !this.isContentVisible )
				return;

			// Remove touch during transition.  
			this.content.touchable = false;

			updateContentTransparency( 0 );

			this.isAnimating = true;

			// Close actions
			this.popUpCloseMessage = message;

			// Send close events when no items is returned.
			if ( !this.popUpCloseMessage ) {
				GlobalFacade.instance.sendMessage( ManagerNotificationConstants.POPUP_CONTENT_CLOSE_START, null, messageFilter );
			}

			hideContent( type, message );
		}

		private function layoutContentInternal( type:ContentPositionType ):void {

			//------ Prep screen for layout 
			if ( this.content is IValidating )
				IValidating( this.content ).validate();

			this.layoutContent( type );
		}

		private function showContentInternal( type:ContentPositionType ):void {

			if ( this.isContentVisible )
				return;

			showContent( type );

		}
		//TODO: Possibly use later??
	/*override protected function onCloseTouchOutOfBounds():void {
		this.hideContentLocal( this.contentPosition );
	}*/
	}
}
