package feathers.extension.ahhenderson.themes.pool
{
	import feathers.extension.ahhenderson.controls.DateSelector;
	import feathers.extension.ahhenderson.controls.IconLabel;
	import feathers.extension.ahhenderson.controls.TitledTextBlock;

	public class CustomFlatThemePoolFunctions
	{
		public function CustomFlatThemePoolFunctions()
		{
		}
		
		include "_Pool.inc";
		
		public static function resetTitledTextBlock(input:TitledTextBlock):void{
			 
			input.title = ""; 
			input.content = "";
			
			removeStyles(input);
		}
		 
		
		public static function resetIconLabel(input:IconLabel):void{
			  
			input.iconId = null;
			input.firstGap = 10;
			input.padding = 0;
			input.iconBounds.width = input.iconBounds.height = 0;
			
			input.text = "";
			
			removeStyles(input);
		}
		
		public static function resetDateSelectorObject(input:DateSelector):void{
			
			// Remove listeners)
			//input.removeEventListeners(Event.CHANGE);
			input.selectedDate = null;
		
			removeStyles(input);
		}
		
	}
}