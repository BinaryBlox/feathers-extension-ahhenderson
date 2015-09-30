package feathers.extension.ahhenderson.managers.enums {
	import ahhenderson.core.collections.interfaces.IEnumeration;
 
	/**
	 * 
	 * @author tonyhenderson
	 */
	public final class MenuDirection implements IEnumeration {

		
		/**
		 *
		 * <b>Left Menu</b>
		 *  
		 *  The position a menu will animate and display 
		 */
		public static const TO_TOP:MenuDirection = new MenuDirection("TO_TOP");
		
		/**
		 *
		 * <b>Right Menu</b>
		 *  
		 *  The position a menu will animate and display  
		 */
		public static const TO_RIGHT:MenuDirection = new MenuDirection("TO_RIGHT");
		
		/**
		 *
		 * <b>Bottom Menu</b>
		 *  
		 *  The position a menu will animate and display 
		 */
		public static const TO_LEFT:MenuDirection = new MenuDirection("TO_LEFT");
		
		/**
		 *
		 * <b>Top Menu</b>
		 *  
		 *  The position a menu will animate and display 
		 */
		public static const TO_BOTTOM:MenuDirection = new MenuDirection("TO_BOTTOM");
		
	 
		
		private static var locked:Boolean = false;

		{
			locked = true;
		}

		/**
		 * 
		 * @param value
		 * @throws Error
		 */
		public function MenuDirection(value:String):void {
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
