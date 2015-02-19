package feathers.extension.ahhenderson.controls.screens {
	
	import feathers.extension.ahhenderson.constants.FeathersExtLib_ThemeConstants;
	import feathers.extension.ahhenderson.controls.screens.dateSelector.DateSelectorScreenConfig;
	import feathers.layout.AnchorLayoutData;
 
	public class DateSelectorScreen extends LayoutGroupScreen {

		include "../../_includes/_DateSelector.inc";
		include "../../_includes/_Header.inc";
		public function DateSelectorScreen() {

			super();
		}

		public function get dateSelectorScreenConfig():DateSelectorScreenConfig
		{
			return _dateSelectorScreenConfig;
		}

		public function set dateSelectorScreenConfig(value:DateSelectorScreenConfig):void
		{
			if(this._dateSelectorScreenConfig === value)
			{
				return;
			}
			
			_dateSelectorScreenConfig = value;
			this.invalidate( INVALIDATION_FLAG_DATA );
		}

		override protected function get defaultStyleProvider():IStyleProvider {

			return DateSelectorScreen.globalStyleProvider;
		}
		 

		private var _dateSelectorScreenConfig:DateSelectorScreenConfig;
		
		override protected function draw():void {

			super.draw(); 
			
			//  Required for include
			layoutDateSelectorControls(); 
			
		}
 
		override protected function initialize():void {
			
			super.initialize();
 
			// From inc
			this.initHeader();
			 
			// From inc
			this.initDateSelector();
			
			// Custom layout for date selector components
			this.spnMonth.layoutData = new AnchorLayoutData( FeathersExtLib_ThemeConstants.PANEL_GUTTER, NaN, 4, 4 );
			this.spnDay.layoutData = new AnchorLayoutData( FeathersExtLib_ThemeConstants.PANEL_GUTTER, NaN, 4, 2 ); 
			this.spnYear.layoutData = new AnchorLayoutData( FeathersExtLib_ThemeConstants.PANEL_GUTTER, 4, 4, 2 );
			
			( this.spnDay.layoutData as AnchorLayoutData ).leftAnchorDisplayObject = spnMonth;
			( this.spnYear.layoutData as AnchorLayoutData ).leftAnchorDisplayObject = spnDay;
			 
			// Relate to header to position
			( this.spnMonth.layoutData as AnchorLayoutData ).topAnchorDisplayObject = this.header;
			( this.spnDay.layoutData as AnchorLayoutData ).topAnchorDisplayObject = this.header;
			( this.spnYear.layoutData as AnchorLayoutData ).topAnchorDisplayObject = this.header;

		}
	}
}
