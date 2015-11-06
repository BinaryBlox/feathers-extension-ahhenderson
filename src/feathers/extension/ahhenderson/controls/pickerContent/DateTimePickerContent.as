package feathers.extension.ahhenderson.controls.pickerContent
{
	import feathers.controls.DateTimeSpinner;
	import feathers.extension.ahhenderson.controls.interfaces.IPickerContent;
	
	public class DateTimePickerContent extends DateTimeSpinner implements IPickerContent
	{
		
		/*this.pickerContent.addEventListener( Event.CHANGE, content_changeHandler );
		this.pickerContent.addEventListener( Event.TRIGGERED, content_triggeredHandler );
		this.pickerContent.addEventListener( Event.REMOVED_FROM_STAGE, content_removedFromStageHandler );*/
		public function DateTimePickerContent()
		{
			super();
		}
		
		public function get selectedItem():Object
		{ 
			return this.value;
		}
		
		public function set selectedItem(value:Object):void
		{
			if(!value){ 
				return;
			}
			
			if(!(value is Date)){
				throw new Error("DateTimePickerContent.selectedItem - Values must be date"); 
			}
			
			this.value = value as Date;
			
		}
		
		 
	}
}