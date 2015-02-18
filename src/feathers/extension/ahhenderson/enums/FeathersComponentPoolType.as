package feathers.extension.ahhenderson.enums{
	import ahhenderson.core.managers.dependency.objectPool.interfaces.IPoolType;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.PickerList;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.SpinnerList;
	import feathers.controls.TextInput;

	 
	public final class FeathersComponentPoolType implements IPoolType {

		 
		public static var list:Array = [];
		 
		public static const BUTTON:FeathersComponentPoolType = new FeathersComponentPoolType("BUTTON", Button);
		
		public static const TEXT_INPUT:FeathersComponentPoolType = new FeathersComponentPoolType("TEXT_INPUT", TextInput);
		
		public static const LABEL:FeathersComponentPoolType = new FeathersComponentPoolType("LABEL", Label);
		
		public static const IMAGE_LOADER:FeathersComponentPoolType = new FeathersComponentPoolType("IMAGE_LOADER", ImageLoader);
		
		public static const PICKER_LIST:FeathersComponentPoolType = new FeathersComponentPoolType("PICKER_LIST", PickerList);
		
		public static const SPINNER_LIST:FeathersComponentPoolType = new FeathersComponentPoolType("SPINNER_LIST", SpinnerList);
		
		public static const SCREEN_NAVIGATOR:FeathersComponentPoolType = new FeathersComponentPoolType("SCREEN_NAVIGATOR", ScreenNavigator);
		
		public static const HEADER:FeathersComponentPoolType = new FeathersComponentPoolType("HEADER", Header);
		
		
		public function FeathersComponentPoolType(type:String, objClass:Class):void {
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
