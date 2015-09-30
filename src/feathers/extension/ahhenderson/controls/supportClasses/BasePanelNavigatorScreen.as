package feathers.extension.ahhenderson.controls.supportClasses {

	import feathers.controls.Button;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_ThemeConstants;
	import feathers.extension.ahhenderson.controls.PanelNavigator;
	import feathers.extension.ahhenderson.controls.interfaces.IPanelNavigatorScreen;
	import feathers.extension.ahhenderson.controls.screens.LayoutGroupScreen;
	import feathers.extension.ahhenderson.enums.FeathersComponentPoolType;
	import feathers.extension.ahhenderson.helpers.AssetHelper;
	import feathers.extension.ahhenderson.themes.constants.FlatThemeCustomTextures;
	import feathers.extension.ahhenderson.helpers.UiFactoryHelper;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.utils.math.roundToNearest;
	import starling.display.DisplayObject;


	public class BasePanelNavigatorScreen extends LayoutGroupScreen implements IPanelNavigatorScreen {

		public function BasePanelNavigatorScreen() {
		}

		public var btnBack:Button;

		public var btnNext:Button;

		protected var _panelNavigator:PanelNavigator;

		private var _isPanelNavigatorScreenInitialized:Boolean;

		public function get panelNavigator():PanelNavigator {

			return _panelNavigator;
		}

		public function set panelNavigator( value:PanelNavigator ):void {

			_panelNavigator = value;
		}

		public function showLastScreen( delay:int = 0 ):void {

			if ( !this.panelNavigator )
				return;

			this.panelNavigator.showLastScreen( delay );

		}

		protected function footerButtonFactory( label:String = null, customStyleName:String = null ):Button {

			var footerButton:Button = UiFactoryHelper.buttonFactory( label, customStyleName );

			// Postion button from top
			footerButton.layoutData =
				new AnchorLayoutData( roundToNearest( FeathersExtLib_ThemeConstants.PANEL_GUTTER ),
													  NaN,
													  FeathersExtLib_ThemeConstants.CONTROL_GUTTER,
													  NaN,
													  0 );

			// Anchor to formcontrol list.
			//(footerButton.layoutData as AnchorLayoutData).topAnchorDisplayObject = this.formControlList;

			return footerButton;
		}

		protected function initPanel( screenTitle:String, panelTitle:String, footerButtonTitle:String = null, showScreenHeader:Boolean =
			true ):void {

			// Initialize (MUST BE CALLED BEFORE BELOW)
			super.initialize();

			// AFTER INIT

			// Default layout
			this.layout = new AnchorLayout();

			this.btnBack = this.fmgr.pool.borrowObj( FeathersComponentPoolType.BUTTON );
			this.btnBack.styleNameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
			this.btnBack.defaultIcon = AssetHelper.getImage( FlatThemeCustomTextures.ICONS_CONTROL_BUTTON_BACK );
			this.btnBack.label = "Back";
			this.btnBack.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;

			
			this.fmgr.navigation.updateLeftHeaderItems( new <DisplayObject>[ this.btnBack ]);

			//-----------------
			// Header content
			//----------------- 
			this.fmgr.navigation.toggleHeaderVisibility( showScreenHeader ); // by default from base
			this.fmgr.navigation.updateHeaderTitle( screenTitle );

			//-----------------
			// Panel  
			//-----------------
			this.panelNavigator.title = panelTitle;
			initPanelContent();

			///-----------------
			// Footer content.  
			//-----------------
			this.btnNext = footerButtonFactory( footerButtonTitle );

			if ( !footerButtonTitle )
				this.btnNext.visible = false;

			// Add button to footer.
			this.panelNavigator.footerProperties.centerItems = new <DisplayObject>[ this.btnNext ];

			_isPanelNavigatorScreenInitialized = true;
		}

		protected function initPanelContent():void {

			//-----------------
			// Panel  
			//-----------------
			initPanelControls();
		}

		protected function initPanelControls():void {

			throw new Error( "Must override initPanelControls()" );
		}

		override protected function initialize():void {

			if ( !_isPanelNavigatorScreenInitialized )
				throw new Error( "Must call initPanel() " );

			super.initialize();

		}
	}
}

