//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.controls.popUps {

	import flash.geom.Point;
	
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	import ahhenderson.core.mvc.patterns.facade.GlobalFacade;
	import ahhenderson.core.ui.constants.MenuConstants;
	
	import feathers.controls.popups.IPopUpContentManager;
	import feathers.core.IFeathersControl;
	import feathers.core.IValidating;
	import feathers.extension.ahhenderson.helpers.DialogHelper;
	import feathers.extension.ahhenderson.interfaces._deprecate.IMenu;
	import feathers.extension.ahhenderson.interfaces.IPopUpExtendedContent;
	import feathers.extension.ahhenderson.managers.enums.MenuPosition;
	import feathers.extension.ahhenderson.managers.events.MenuEvent;
	import feathers.extension.ahhenderson.managers.events.PopUpContentEvent;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.events.TouchEvent;


	public class MenuPopUpManagerBase extends PopUpManagerBase implements IPopUpContentManager {

		 

		public function MenuPopUpManagerBase() {

			super();
		}
 
  
  
		

		override public function close():void {

			this.isContentVisible = false; 

			if ( this.content && ( this.content is IPopUpExtendedContent )) {
				IMenu( this.content ).removeEventListener( PopUpContentEvent.CONTENT_ITEM_TRIGGERED, onContentItemTriggered );
			}

			super.close();
		}

		 
		 

		/*override public function open( content:DisplayObject, source:DisplayObject ):void {
 
			if ( !this.contentPosition ) {
				this.contentPosition = MenuPosition.BOTTOM_MENU;
			}
 
			super.open( content, source );
			
			// Initialize menu funcs (if any)
			IMenu( content ).initializeMenu();
			
			IMenu( content ).addEventListener( MenuEvent.MENU_ITEM_TRIGGERED, onContentItemTriggered );

		}*/

		/*public function openMenu( position:MenuPosition, content:DisplayObject, source:DisplayObject, duration:Number = .15 ):void {

			if ( !( content is IMenu ))
				return;

			// Set menu position
			this.duration = duration;
			this.contentPosition = position;

			// Open
			open( content, source );

		}*/

		 

		/*override protected function layout():void {

			if ( !( this.content is IFeathersControl )) {
				throw new TypeError("The menu content is not valid");
			}
			 
			this.content.y = 1;
			
			//------ Prep screen for layout  
			layoutContentInternal( this.contentPosition );

			//------ Prep screen for display  
			showContentInternal( this.contentPosition );
		}*/

		 
	 
	 
 
		override protected function content_resizeHandler(event:Event):void 
		{

			this.close();
		}

		protected function onMenuCloseComplete():void {

			resetContent();
			
			//trace("Done hiding"); 
			// Add touch back
			//DisplayObject(PopUpManager.defaultOverlayFactory).touchable =true;

			// Dispatch close message
			if ( this.popUpCloseMessage )
				GlobalFacade.instance.sendDelayedMessage( 100, this.popUpCloseMessage  );
			else {
				// Only send close menu event if no item was selected in menue
				GlobalFacade.instance.sendDelayedMessage( 100,
																new FacadeMessage( MenuConstants.MESSAGE__MENU_CLOSE_END,
																				   null,
																				   messageFilter ));
			}

			// Reset 
			this.isContentVisible = false;
			this.isAnimating = false;
			this.popUpCloseMessage  = null;
 
			// Dispatch close event.
			this.close();
		}

		/*protected function onContentItemTriggered( e:Event ):void {

			if ( e.data is FacadeMessage ) {
				hideContentLocal( this.contentPosition, e.data as FacadeMessage );

				return;
			}

			hideContentLocal( this.contentPosition, null );
		}*/

		protected function onMenuOpenComplete():void {

			//trace("Done tweening");

			// TODO: Not sure if we need this 
			//GlobalFacade.def_I.sendDelayedFacadeMessage(100, new FacadeMessage(MenuConstants.MESSAGE__MENU_OPEN, null, messageFilter));

			// Add touch back
			//DisplayObject(PopUpManager.defaultOverlayFactory).touchable =true;
			this.content.touchable = true;

			updateContentVisibility( true );

			updateContentProperties();

			//GTweener.to(IMenu(this.content).defaultContent, .10, {alpha: 1});
			//IMenu(this.content).defaultContent.visible = true; 

			// Set visible state.
			this.isContentVisible = true;
			this.isAnimating = false;
		}

		override protected function stage_resizeHandler(event:ResizeEvent):void{
			this.close();
		}
		 
		
	 

		protected function resetContent():void {

		}

	 

		/*private function hideContentLocal( type:MenuPosition, message:FacadeMessage = null ):void {

			if ( !this.isContentVisible )
				return;

			// Remove touch during transition.  
			this.content.touchable = false;

			updateContentTransparency( 0 );

			//IMenu( this.content ).defaultContent.alpha = 0;
			this.isAnimating = true;

			// Close actions
			this.popUpCloseMessage  = message;

			// Send close events when no items is returned.
			if ( !this.popUpCloseMessage  ){
				GlobalFacade.instance.sendMessage( MenuConstants.MESSAGE__MENU_CLOSE_START, null, messageFilter );
			}
			
			hideContent( type, message );
		}*/

		/*private function layoutContentInternal( type:MenuPosition ):void {

			//------ Prep screen for layout 
			if ( this.content is IValidating )
				IValidating( this.content ).validate();
 
			this.layoutContent( type );
		}

		private function showContentInternal( type:MenuPosition ):void {

			if ( this.isContentVisible )
				return;

			showContent( type );

		}*/

		
	}
}


