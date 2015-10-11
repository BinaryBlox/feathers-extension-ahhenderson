package feathers.extension.ahhenderson.enums{
	import ahhenderson.core.managers.dependency.objectPool.interfaces.IPoolType;
	
	import feathers.extension.ahhenderson.controls.DateTimePicker;
	import feathers.extension.ahhenderson.controls.IconLabel;
	import feathers.extension.ahhenderson.controls.TitledTextBlock;

	 
	public final class CustomComponentPoolType implements IPoolType {

		 
		public static var list:Array = [];
		 
		public static const TITLED_TEXT_BLOCK:CustomComponentPoolType = new CustomComponentPoolType("TITLED_TEXT_BLOCK", TitledTextBlock);
		
		public static const ICON_LABEL:CustomComponentPoolType = new CustomComponentPoolType("ICON_LABEL", IconLabel);
		
		public static const DATE_TIME_PICKER:CustomComponentPoolType = new CustomComponentPoolType("DATE_TIME_PICKER", DateTimePicker);
		
		public function CustomComponentPoolType(type:String, objClass:Class):void {
			if (locked) {
				throw new Error("You can't instantiate this class.");
			}
			
			if (!type || !objClass)
				return;
			
			_value = type;
			_objClass = objClass;
		}
		
		// NOTE: IMPORTANT that this happens after defitions or lock will fail instantiation of oject right away.
		private static var locked:Boolean = false;
		
		{
			locked = true;
		}
		
		
		private var _objClass:Class;
		
		public function get objClass():Class {
			return _objClass;
		}
		
		
		private var _value:String;
		
		public function get value():String {
			return _value;
		}
	}
}
