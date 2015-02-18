package feathers.extension.ahhenderson.interfaces {

	import feathers.data.ListCollection;


	public interface IFormControlGroup extends IFormControlGroupView, IFormControlGroupMediator {

		function addSubGroup( headerProperties:Object, controlList:ListCollection, editGroup:String, sectionHeader:String = null ):void;

		function drawSubGroup( editGroup:String, typicalControlWidth:Number, enabled:Boolean = false ):void;
	}
}
