package feathers.extension.ahhenderson.managers.enums {
	import ahhenderson.core.collections.interfaces.IEnumeration;
	
	import avmplus.getQualifiedClassName;
 
	/**
	 * 
	 * @author tonyhenderson
	 */
	public final class ContentPositionType implements IEnumeration {

		
		/**
		 *
		 * <b>Left Content</b>
		 *  
		 *  The position the content will animate and display 
		 */
		public static const LEFT:ContentPositionType = new ContentPositionType("LEFT");
		
		/**
		 *
		 * <b>Right Content</b>
		 *  
		 *  The position the content will animate and display  
		 */
		public static const RIGHT:ContentPositionType = new ContentPositionType("RIGHT");
		
		/**
		 *
		 * <b>Bottom Content</b>
		 *  
		 *  The position the content will animate and display 
		 */
		public static const BOTTOM:ContentPositionType = new ContentPositionType("BOTTOM");
		
		/**
		 *
		 * <b>Top Content</b>
		 *  
		 *  The position the content will animate and display 
		 */
		public static const TOP:ContentPositionType = new ContentPositionType("TOP");
		
		/**
		 *
		 * <b>Custom Content Position</b>
		 *  
		 *  The position the content will animate and display 
		 */
		public static const CUSTOM_POSITION:ContentPositionType = new ContentPositionType("CUSTOM_POSITION");
		
	 
		
		private static var locked:Boolean = false;

		{
			locked = true;
		}

		private const PREFIX:String = "_" + getQualifiedClassName(ContentPositionType);
		/**
		 * 
		 * @param value
		 * @throws Error
		 */
		public function ContentPositionType(value:String):void {
			if (locked) {
				throw new Error("You can't instantiate another instance.");
			}
			_value = value + PREFIX ;
			
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
