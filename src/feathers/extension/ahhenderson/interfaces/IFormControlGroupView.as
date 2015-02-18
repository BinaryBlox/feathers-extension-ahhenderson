package feathers.extension.ahhenderson.interfaces {

	import feathers.data.ListCollection;


	public interface IFormControlGroupView {

		function addComponentsByGroup( headerProperties:Object, controlList:ListCollection, editGroup:String ):void;

		function drawComponentsByGroup( editGroup:String, width:Number = 0, height:Number = 0 ):void;

	}
}
