package feathers.extension.ahhenderson.controls.popUps
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.popups.BottomDrawerPopUpContentManager;
	import feathers.core.IFeathersControl;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class CustomBottomDrawerPopUpManager extends BottomDrawerPopUpContentManager
	{
		public function CustomBottomDrawerPopUpManager()
		{
			super();
		}
		
		
		override protected function layout():void
		{
			super.layout();
			
			content.width = this.panel.width;
			
			if(content is IFeathersControl){
				(content as IFeathersControl).validate();
			}
		}
		
	 
		/**
		 * @private
		 */
		override protected function headerFactory():Header
		{
			var header:Header = new Header();
			var closeButton:Button = new Button();
			closeButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON);
			closeButton.label = this.closeButtonLabel;
			closeButton.addEventListener(Event.TRIGGERED, closeButton_triggeredHandler);
			header.rightItems = new <DisplayObject>[closeButton];
			return header;
		}
	}
}