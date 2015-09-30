package feathers.extension.ahhenderson.managers.enums {
	import ahhenderson.core.collections.interfaces.IEnumeration;
 
	/**
	 * 
	 * @author tonyhenderson
	 */
	public final class MenuPosition implements IEnumeration {

		
		/**
		 *
		 * <b>Left Menu</b>
		 *  
		 *  The position a menu will animate and display 
		 */
		public static const LEFT_MENU:MenuPosition = new MenuPosition("LEFT_MENU");
		
		/**
		 *
		 * <b>Right Menu</b>
		 *  
		 *  The position a menu will animate and display  
		 */
		public static const RIGHT_MENU:MenuPosition = new MenuPosition("RIGHT_MENU");
		
		/**
		 *
		 * <b>Bottom Menu</b>
		 *  
		 *  The position a menu will animate and display 
		 */
		public static const BOTTOM_MENU:MenuPosition = new MenuPosition("BOTTOM_MENU");
		
		/**
		 *
		 * <b>Top Menu</b>
		 *  
		 *  The position a menu will animate and display 
		 */
		public static const TOP_MENU:MenuPosition = new MenuPosition("TOP_MENU");
		
		/**
		 *
		 * <b>Custom Menu Position</b>
		 *  
		 *  The position a menu will animate and display 
		 */
		public static const CUSTOM_MENU_POSITION:MenuPosition = new MenuPosition("CUSTOM_MENU_POSITION");
		
	 
		
		private static var locked:Boolean = false;

		{
			locked = true;
		}

		/**
		 * 
		 * @param value
		 * @throws Error
		 */
		public function MenuPosition(value:String):void {
			if (locked) {
				throw new Error("You can't instantiate another instance.");
			}
			_value = value;
		}

		private var _value:String;

		/**
		 * 
		 * @return 
		 */
		public function get value():String {
			return _value;
		}
	}
}
