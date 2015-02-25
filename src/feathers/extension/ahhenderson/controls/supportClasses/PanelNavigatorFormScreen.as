package feathers.extension.ahhenderson.controls.supportClasses {

	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_ThemeConstants;
	import feathers.extension.ahhenderson.controls.interfaces.IPanelNavigatorScreen;
	import feathers.extension.ahhenderson.themes.helpers.UI_FactoryHelper;
	import feathers.layout.AnchorLayoutData;
	import feathers.utils.math.roundToNearest;
	
	import starling.display.DisplayObject;


	public class PanelNavigatorFormScreen extends PanelNavigatorScreen implements IPanelNavigatorScreen {

		public function PanelNavigatorFormScreen() {
		}
		 
 
		public var formControlList:List;
    
		protected var _formControlListDataProvider:ListCollection;
  
		 
		
		public function get formControlListDataProvider():ListCollection {

			if ( !_formControlListDataProvider )
				_formControlListDataProvider = new ListCollection();

			return _formControlListDataProvider;
		}

		override protected function draw():void {

			super.draw();

 
			var panelWidth:Number = roundToNearest(this.actualWidth * .55 );
			var buttonMinWidth:Number = roundToNearest(panelWidth * .5);
			
			/*if(this.btnContinue.minWidth !== buttonMinWidth)
				this.btnContinue.minWidth = buttonMinWidth;*/
  
			this.formControlList.validate();

		}
	 
		protected function addFormControl(label:String, accessoryObj:DisplayObject):void{
			
			this.formControlListDataProvider.addItem({ labelField: label, accessory: accessoryObj });
		}

		override protected function footerButtonFactory(label:String=null, customStyleName:String=null):Button{
			
			var footerButton:Button = UI_FactoryHelper.buttonFactory(label, customStyleName);
			
			// Postion button from top
			footerButton.layoutData = new AnchorLayoutData(roundToNearest(FeathersExtLib_ThemeConstants.PANEL_GUTTER), 
				NaN,
				FeathersExtLib_ThemeConstants.CONTROL_GUTTER,
				NaN, 0);
			
			// Anchor to formcontrol list.
			(footerButton.layoutData as AnchorLayoutData).topAnchorDisplayObject = this.formControlList;
			
			return footerButton;
		}
		
		 
		override protected function initPanelContent():void{
			 
			// Controls list.
			this.formControlList = UI_FactoryHelper.formControlListFactory();
			this.formControlList.layoutData = new AnchorLayoutData( 0, 0, NaN, 0 );
			
			// Add form controls to list
			initPanelControls();
			
			// Add child after
			this.addChild( formControlList );
		}
		
		
		 
	}
}

