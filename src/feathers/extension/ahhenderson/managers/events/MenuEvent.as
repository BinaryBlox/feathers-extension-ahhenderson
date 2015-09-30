//------------------------------------------------------------------------------
//
//   ViziFit, Inc. 2013. All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.managers.events {

	/**
	 * Event <code>type</code> constants for ViziFit menu controls. This class is
	 * not a subclass of <code>starling.events.Event</code> because these
	 * constants are meant to be used with <code>dispatchEventWith()</code> and
	 * take advantage of the Starling's event object pooling. The object passed
	 * to an event listener will be of type <code>starling.events.Event</code>.
	 */
	public class MenuEvent {

		/**
		* The <code>MenuEvent.MENU_ITEM_CHANGE</code> event type is Dispatched when an <code>IMenuItem</code> is selected or unselected. A menu items's
		* selection may be changed by the user when <code>isToggle</code> is set to
		* <code>true</code>. The selection may be changed programmatically at any
		* time.
		*
		*/
		public static const MENU_ITEM_CHANGE:String="menuItemChange";


		/**
		 * The <code>MenuEvent.MENU_ITEM_TRIGGERED</code> event type is dispatched when an <code>IMenuItem</code> is released while the touch is still
		 * within the button's bounds (a tap or click that should trigger the
		 * button).
		 *
		 */
		public static const MENU_ITEM_TRIGGERED:String="menuItemTriggered";
		
		/**
		 * The <code>MenuEvent.MENU_CLOSED</code> event type is dispatched when an <code>IMenu</code> item is closed.
		 *
		 */
		public static const MENU_CLOSED:String="menuClosed";
	}
}
