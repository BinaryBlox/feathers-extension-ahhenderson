package feathers.extension.ahhenderson.controls.interfaces {

	import ahhenderson.core.interfaces.IDisposable;
	import ahhenderson.core.interfaces.IStarlingEventDispatcher;
	
	import feathers.core.IFeathersControl;
	import feathers.core.IFeathersEventDispatcher;
	import feathers.core.IFocusDisplayObject;


	/**
	 * 
	 * @author thenderson
	 */
	public interface IPickerContent extends IFeathersControl, 
		IStarlingEventDispatcher, 
		IFeathersEventDispatcher, 
		IFocusDisplayObject, 
		IDisposable {
		
		function get selectedItem():Object;
		function set selectedItem(value:Object):void;
	}
}
