package feathers.extension.ahhenderson.controls
{
	import ahhenderson.core.util.DateUtil;
	
	import feathers.controls.DateTimeSpinner;
	import feathers.extension.ahhenderson.controls.interfaces.IPickerContent;
	import feathers.extension.ahhenderson.controls.pickerContent.DateTimePickerContent;
	import feathers.extension.ahhenderson.controls.supportClasses.PickerContentBase;
	import feathers.skins.IStyleProvider;
	
	import starling.events.Event;

	 
	public class DateTimePicker extends PickerContentBase
	{ 
		
		/**
		 * Ex: Fri, Aug 1, 2000
		 * @default 
		 */
		public static const DISPLAY_DATE_DDD_MMM_DD_YYYY:String ="display_date_ddd_mmm_dd_yyyy";
		
		/**
		 * Ex: Aug 1, 2000
		 * @default 
		 */
		public static const DISPLAY_DATE_MMM_DD_YYYY:String ="display_date_mmm_dd_yyyy";
		
		/**
		 * Ex: August 1, 2000
		 * @default 
		 */
		public static const DISPLAY_DATE_M_DD_YYYY:String ="display_date_m_dd_yyyy";
		
		/**
		 * Ex: 8/1/2000
		 * @default 
		 */
		public static const DISPLAY_DATE_MM_DD_YYYY:String ="display_date_mm_dd_yyyy";
		
		/**
		 * Ex: 04:45 AM
		 * @default 
		 */
		public static const DISPLAY_TIME_HH_MM_AMPM:String ="display_time_hh_mm_ampm";
		
		/**
		 * Ex: 04:45:05 AM
		 * @default 
		 */
		public static const DISPLAY_TIME_HH_MM_SS_AMPM:String ="display_time_hh_mm_ss_ampm";
		
		/**
		 * Ex: 04:45:05 AM GMT
		 * @default 
		 */
		public static const DISPLAY_TIME_HH_MM_SS_AMPM_TZ:String ="display_time_hh_mm_ss_ampm_tz";
		
		/**
		 * 
		 */
		public function DateTimePicker()
		{
			super();
		}
		
		public function get displayTimeMode():String
		{
			return _displayTimeMode;
		}

		public function set displayTimeMode(value:String):void
		{
			_displayTimeMode = value;
		}

		public function get displayDateMode():String
		{
			return _displayDateMode;
		}

		public function set displayDateMode(value:String):void
		{
			_displayDateMode = value;
		}

		/**
		 * 
		 * @return 
		 */
		public function get selectedDate():Date
		{
			 return (this.selectedItem ) ? this.selectedItem as Date : null;
		}
 

		/**
		 * 
		 * @return 
		 */
		public function get editingMode():String
		{
			return _editingMode;
		}

		/**
		 * 
		 * @param value
		 */
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
		
		/**
		 * 
		 * @return 
		 */
		protected static function defaultDateTimePickerContentFactory():DateTimePickerContent{
			
			return new DateTimePickerContent(); 
		}
		
		override protected function defaultPickerContentFactory():IPickerContent{
			
			return defaultDateTimePickerContentFactory as IPickerContent;
		}
		
		private var _editingMode:String=DateTimeSpinner.EDITING_MODE_DATE;
		
		private var _displayDateMode:String = DateTimePicker.DISPLAY_DATE_DDD_MMM_DD_YYYY;
		
		private var _displayTimeMode:String = DateTimePicker.DISPLAY_TIME_HH_MM_AMPM;
		
		
		override protected function popUpContentManager_closeHandler(event:Event):void{
			
			super.popUpContentManager_closeHandler(event);
			
			refreshButtonLabel();
			
		}
		
		protected function updateDisplayTimeFormat(date:Date):String{
			
			var formattedValue:String;
			
			switch(this.displayDateMode){
				
				case DateTimePicker.DISPLAY_TIME_HH_MM_AMPM:
					formattedValue = DateUtil.getFormattedTime(this.selectedDate, false, false, false);
					break;
				
				case DateTimePicker.DISPLAY_TIME_HH_MM_SS_AMPM:
					formattedValue = DateUtil.getFormattedTime(this.selectedDate, false, true, false);
					break;
				
				case DateTimePicker.DISPLAY_TIME_HH_MM_SS_AMPM_TZ:
					formattedValue = DateUtil.getFormattedTimeWithTimeZone(this.selectedDate);
					break;
				
				default:
					formattedValue = DateUtil.getFormattedTime(this.selectedDate, false, false, false);
					break;
				 
			}
			
			return formattedValue;
		}
		
		protected function updateDisplayFormat(date:Date):String{
			
			var formattedValue:String;
			var formattedTime:String = updateDisplayTimeFormat(date);
			var formattedDate:String = updateDisplayDateFormat(date);
			  
			switch(this.editingMode){
				 
				case DateTimeSpinner.EDITING_MODE_DATE:
					formattedValue = formattedDate;
					break;
				
				case DateTimeSpinner.EDITING_MODE_DATE_AND_TIME:
					formattedValue = formattedDate;
					formattedValue += " " + formattedTime;
					break;
				case DateTimeSpinner.EDITING_MODE_TIME:
					formattedValue = formattedTime;
					break;
				
				default:
					formattedValue = formattedDate;
					break;
			}
			
			return formattedValue;
		}
		
		protected function updateDisplayDateFormat(date:Date):String{
			 
			var formattedValue:String = new String();
			
			switch(this.displayDateMode){
				
				case DateTimePicker.DISPLAY_DATE_DDD_MMM_DD_YYYY:
					formattedValue = DateUtil.getSummaryDateFormat(this.selectedDate);
					break;
				
				case DateTimePicker.DISPLAY_DATE_M_DD_YYYY:
					formattedValue = DateUtil.getFullDateFormat(this.selectedDate, true, false);
					break;
				
				case DateTimePicker.DISPLAY_DATE_MM_DD_YYYY:
					//formattedValue = DateUtil.getSummaryDateFormat2(
					break;
				
				case DateTimePicker.DISPLAY_DATE_MMM_DD_YYYY:
					formattedValue = DateUtil.getSummaryDateFormat(this.selectedDate, true, true, false);
					break; 
				
				default:
					formattedValue = DateUtil.getSummaryDateFormat(this.selectedDate);
					break;
			}
			
			return formattedValue;
		}
		
		override protected function refreshButtonLabel():void{
			 
			if(this.selectedItem)
			{
				if(!this.selectedDate ){
					return;
				}
				
				this.button.label  = updateDisplayFormat(this.selectedDate);
				this.button.validate();
				//this.button.label = this.itemToLabel(this.selectedItem);
			}
			else
			{
				this.button.label = this._prompt;
			}
			
			//super.refreshButtonLabel()
		}
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