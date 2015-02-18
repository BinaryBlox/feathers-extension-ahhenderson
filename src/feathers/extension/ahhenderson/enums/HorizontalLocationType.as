package feathers.extension.ahhenderson.enums{
	import ahhenderson.core.collections.interfaces.IEnumeration;

	 
	public final class HorizontalLocationType implements IEnumeration {

		 
		public static var list:Array = [];
		 
		public static const CENTER:HorizontalLocationType = new HorizontalLocationType("CENTER");
		
		public static const LEFT:HorizontalLocationType = new HorizontalLocationType("LEFT");
		
		public static const RIGHT:HorizontalLocationType = new HorizontalLocationType("RIGHT");
		
		
		public function HorizontalLocationType(type:String):void {
			if (locked) {
				throw new Error("You can't instantiate this class.");
			}
			 
			
			_value = type; 
		}
		
		// NOTE: IMPORTANT that this happens after defitions or lock will fail instantiation of oject right away.
		private static var locked:Boolean = false;
		
		{
			locked = true;
		}
		
	 
		
		
		private var _value:String;
		
		public function get value():String {
			return _value;
		}
	}
}
