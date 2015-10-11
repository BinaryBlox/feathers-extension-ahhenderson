package feathers.extension.ahhenderson.themes.pool
{
	 
	
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.PickerList;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.SpinnerList;
	import feathers.controls.TextInput;
	import feathers.extension.ahhenderson.controls.DateTimePicker;
	
	import starling.display.Quad;
	import starling.events.Event;

	public class BaseFlatThemePoolFunctions
	{
		public function BaseFlatThemePoolFunctions()
		{
		}
		
		include "_Pool.inc";
		
		 
		 
		
		public static function resetTextInputObject(input:TextInput):void{
			 
			 
			// Remove all listeners from control.
			input.removeEventListeners(Event.CHANGE);
			
			input.text = ""; 
			input.displayAsPassword = false;
			input.maxChars = 0; 
			input.prompt = null;
			input.restrict = null;
			input.alpha = 1;
			
			// reset to minwidth
			input.width = input.height = NaN;
			
			
			removeStyles(input);
			 
		}
		
		public static function resetHeaderObject(input:Header):void{
			 
			input.backgroundSkin = null;
			input.leftItems = input.rightItems = input.centerItems=null;
			input.title = null;
			input.titleAlign = Header.TITLE_ALIGN_CENTER;
			 
			removeStyles(input);
			
		}
		
		public static function resetScreenNavigatorObject(input:ScreenNavigator):void{
			
			// Remove all listeners from control.
			
			//input.removeEventListeners(Event.TRIGGERED);
			 
			input.alpha = 1;
			
			// Assume on is added
			input.removeMediator()
				
			// Remove all screens
			input.removeAllScreens();
			removeStyles(input);
			
		}
		
		public static function resetPickerListObject(input:PickerList):void{
			
			// Remove all listeners from control.
			input.removeEventListeners(Event.CHANGE);
			input.removeEventListeners(Event.TRIGGERED);
			
			input.prompt = null;
			input.dataProvider = null;
			input.alpha = 1;
			
			// reset to minwidth
			input.width = input.height = NaN;
			
			removeStyles(input);
		}
		
		
		
		public static function resetSpinnerListObject(input:SpinnerList):void{
			
			// Remove all listeners from control.
			input.removeEventListeners(Event.CHANGE);
			input.removeEventListeners(Event.TRIGGERED);
			
			//input.prompt = null;
			input.dataProvider = null;
			input.alpha = 1;
			
			// reset to minwidth
			input.width = input.height = NaN;
			
			removeStyles(input);
		}
		
		public static function resetButtonObject(input:Button):void{
			
			trace("Resetting button with label: ", (input.label) ? input.label : "No Label");
			
			// Remove all listeners from control.
			input.removeEventListeners(Event.TRIGGERED);
			
			
			//input.defaultSkin=null;	
			input.layoutData = null;
			input.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER; 
			input.label = ""; 
			input.defaultIcon = input.upIcon = input.downIcon = input.hoverIcon = null;
			input.alpha = 1;
			 
			input.paddingTop =  buttonPaddingTop;
			input.paddingBottom =  buttonPaddingBottom; 
			input.paddingLeft = buttonPaddingLeft;
			input.paddingRight = buttonPaddingRight;
			
			input.gap = smallGutterSize;
			input.minGap = smallGutterSize;
			
			// reset to minwidth
			input.width = input.height = NaN;
			
			input.minWidth = input.minHeight = controlSize;
			input.minTouchWidth =  Math.round(controlSize * controlTouchBoundaryScale);
			input.minTouchHeight =  Math.round(controlSize * controlTouchBoundaryScale);
			  
			removeStyles(input);
		}
		
		public static function resetLabelObject(input:Label):void{
			
			// Remove all listeners from control.
			input.removeEventListeners(Event.TRIGGERED);
			input.alpha = 1;
			input.text = ""; 
			
			// reset to minwidth
			input.width = input.height = NaN;
			
			removeStyles(input);
		}
		 
		public static function resetImageLoaderObject(input:ImageLoader):void{
			
			// Remove all listeners from control.
			//input.removeEventListeners(Event.TRIGGERED);
			
			//input.
			input.alpha = 1;
			
			removeStyles(input);
		}
		
	}
}