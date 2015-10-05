package feathers.extension.ahhenderson.managers.enums {
	import ahhenderson.core.collections.interfaces.IEnumeration;
	
	import avmplus.getQualifiedClassName;
 
	/**
	 * 
	 * @author tonyhenderson
	 */
	public final class ContentDirectionType implements IEnumeration {

		
		/**
		 *
		 * <b>Left content</b>
		 *  
		 *  The direction content will animate and display 
		 */
		public static const TO_TOP:ContentDirectionType = new ContentDirectionType("TO_TOP");
		
		/**
		 *
		 * <b>Right content</b>
		 *  
		 *  The direction content will animate and display  
		 */
		public static const TO_RIGHT:ContentDirectionType = new ContentDirectionType("TO_RIGHT");
		
		/**
		 *
		 * <b>Bottom ontent</b>
		 *  
		 *  The direction content will animate and display 
		 */
		public static const TO_LEFT:ContentDirectionType = new ContentDirectionType("TO_LEFT");
		
		/**
		 *
		 * <b>Top content</b>
		 *  
		 *  The direction content will animate and display 
		 */
		public static const TO_BOTTOM:ContentDirectionType = new ContentDirectionType("TO_BOTTOM");
		
	 
		
		private static var locked:Boolean = false;

		{
			locked = true;
		}

		private const PREFIX:String = "_" + getQualifiedClassName(ContentDirectionType);
		
		/**
		 * 
		 * @param value
		 * @throws Error
		 */
		public function ContentDirectionType(value:String):void {
			if (locked) {
				throw new Error("You can't instantiate another instance.");
			}
			
			_value = value + PREFIX; 
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
