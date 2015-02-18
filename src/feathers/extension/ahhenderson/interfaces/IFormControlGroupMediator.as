package feathers.extension.ahhenderson.interfaces {


	/**
	 *
	 * @author thenderson
	 */
	public interface IFormControlGroupMediator {
		function initByGroup( editGroup:String ):void;

		function updateListenersByGroup( editGroup:String, isAdd:Boolean = true ):void;

		function validateComponentsByGroup( editGroup:String ):Boolean;

		function validateGroup( editGroup:String ):Boolean;
	}
}
