package feathers.extension.ahhenderson.controls
{
	import feathers.controls.DateTimeSpinner;
	import feathers.extension.ahhenderson.controls.interfaces.IPickerContent;
	import feathers.extension.ahhenderson.controls.pickerContent.DateTimePickerContent;
	import feathers.extension.ahhenderson.controls.supportClasses.PickerContentBase;
	import feathers.skins.IStyleProvider;

	public class DateTimePicker extends PickerContentBase
	{
		public function DateTimePicker()
		{
			super();
		}
		
		public function get editingMode():String
		{
			return _editingMode;
		}

		public function set editingMode(value:String):void
		{
			if(this.pickerContent && this.pickerContent is DateTimePickerContent){
				(this.pickerContent as DateTimePickerContent).editingMode = value;
			}
			
			_editingMode = value;
		}
		
	 

		override protected function createContent():void{
			
			super.createContent(); 
			
			if(this.pickerContent && this.pickerContent is DateTimePickerContent){
				
				// Set default editing mode
				(this.pickerContent as DateTimePickerContent).editingMode = this.editingMode;
			}
		}
		
		protected static function defaultDateTimePickerContentFactory():DateTimePickerContent{
			
			return new DateTimePickerContent(); 
		}
		
		override protected function defaultPickerContentFactory():IPickerContent{
			
			return defaultDateTimePickerContentFactory as IPickerContent;
		}
		
		private var _editingMode:String=DateTimeSpinner.EDITING_MODE_DATE;
		
		/**
		 * @private
		 */
		override protected function get defaultStyleProvider():IStyleProvider {
			
			return DateTimePicker.globalStyleProvider;
		}
		
		/**
		 * The default <code>IStyleProvider</code> for all <code>PickerList</code>
		 * components.
		 *
		 * @default null
		 * @see feathers.core.FeathersControl#styleProvider
		 */
		public static var globalStyleProvider:IStyleProvider;
		
	}
}