package feathers.extension.ahhenderson.controls.screens.dateSelector
{
	public class DateSelectorScreenConfig
	{
		public function DateSelectorScreenConfig()
		{
		}
		
		private var _returnScreenId:String;
		
		private var _selectedDate:Date;
		
		private var _screenTitle:String;

		public function get screenTitle():String
		{
			return _screenTitle;
		}

		public function set screenTitle(value:String):void
		{
			_screenTitle = value;
		}

		public function get selectedDate():Date
		{
			return _selectedDate;
		}

		public function set selectedDate(value:Date):void
		{
			_selectedDate = value;
		}

		public function get returnScreenId():String
		{
			return _returnScreenId;
		}

		public function set returnScreenId(value:String):void
		{
			_returnScreenId = value;
		}

	}
}