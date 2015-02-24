//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.controls.supportClasses {

	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_ThemeConstants;
	import feathers.extension.ahhenderson.controls.PanelNavigator;
	import feathers.extension.ahhenderson.controls.interfaces.IPanelNavigatorScreen;
	import feathers.extension.ahhenderson.controls.screens.LayoutGroupScreen;
	import feathers.extension.ahhenderson.enums.FeathersComponentPoolType;
	import feathers.extension.ahhenderson.helpers.AssetHelper;
	import feathers.extension.ahhenderson.themes.constants.FlatThemeCustomTextures;
	import feathers.extension.ahhenderson.themes.helpers.UI_FactoryHelper;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.utils.math.roundToNearest;
	
	import starling.display.DisplayObject;
	import starling.events.Event;


	public class AbstractPanelNavigatorFormScreen extends LayoutGroupScreen implements IPanelNavigatorScreen {

		public function AbstractPanelNavigatorFormScreen() {
		}
		 
 
		public var formControlList:List;
  
		public var btnBack:Button;
		
		public var btnNext:Button; 
		 
		protected var _formControlListDataProvider:ListCollection;
  
		protected var _panelNavigator:PanelNavigator;
		 
		public function set panelNavigator(value:PanelNavigator):void
		{
			_panelNavigator = value;
		}

		public function get panelNavigator():PanelNavigator{
			 
			return _panelNavigator;
		}
		
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
		
		private var _isPanelFormInitialized:Boolean;
		 
		protected function addFormControl(label:String, accessoryObj:DisplayObject):void{
			
			this.formControlListDataProvider.addItem({ labelField: label, accessory: accessoryObj });
		}

		protected function initPanelForm(screenTitle:String, 
											panelTitle:String, 
											footerButtonTitle:String=null,
											showScreenHeader:Boolean=true):void{
			
			 
 
			// Initialize (MUST BE CALLED BEFORE BELOW)
			super.initialize();
			
			// AFTER INIT
			
			// Default layout
			this.layout = new AnchorLayout();
			
			this.btnBack=this.fmgr.pool.borrowObj(FeathersComponentPoolType.BUTTON);
			this.btnBack.styleNameList.add(Button.ALTERNATE_NAME_QUIET_BUTTON); 
			this.btnBack.defaultIcon = AssetHelper.getImage(FlatThemeCustomTextures.ICONS_CONTROL_BUTTON_BACK);
			this.btnBack.label="Back"; 
			this.btnBack.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT; 
			
			this.fmgr.navigation.updateLeftHeaderItems(new <DisplayObject>[ this.btnBack ]); 
			
			//-----------------
			// Header content
			//----------------- 
			this.fmgr.navigation.toggleHeaderVisibility( showScreenHeader ); // by default from base
			this.fmgr.navigation.updateHeaderTitle( screenTitle );
			
			//-----------------
			// Panel  
			//-----------------
		  
			
			// Controls list.
			this.formControlList = UI_FactoryHelper.formControlListFactory();
			this.formControlList.layoutData = new AnchorLayoutData( 0, 0, NaN, 0 );
			
			// Add form controls to list
			initFormControls();
			
			this.addChild( formControlList );
			
			///-----------------
			// Footer content.  
			//-----------------
			this.btnNext = footerButtonFactory(footerButtonTitle);
			
			if(!footerButtonTitle)
				this.btnNext.visible = false;
			
			// Add button to footer.
			this.panelNavigator.footerProperties.centerItems = new <DisplayObject>[this.btnNext];
			
			_isPanelFormInitialized = true;
		}
		
		override protected function initialize():void {
			
			if(!_isPanelFormInitialized)
				throw new Error("Must call initPanelForm() ");
			
			super.initialize();
			 
		}
		
		protected function initFormControls():void{
			
			throw new Error("Must override ");
		}
		
		public function footerButtonFactory(label:String=null, customStyleName:String=null):Button{
			
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

		override protected function onScreenTransitionComplete( event:Event ):void {
 
			super.onScreenTransitionComplete( event ); 
		}
		 
		
		public function showLastScreen(delay:int=0):void
		{
			if(!this.panelNavigator)
				return;
			
			this.panelNavigator.showLastScreen(delay);
			
		}
		
	}
}

