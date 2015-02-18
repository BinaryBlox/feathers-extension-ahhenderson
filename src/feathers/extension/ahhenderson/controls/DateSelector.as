
package feathers.extension.ahhenderson.controls {

	import feathers.controls.LayoutGroup;
	import feathers.skins.IStyleProvider;


	public class DateSelector extends LayoutGroup {

		include "../includes/_FeathersAppManager.inc";
		include "../includes/_DateSelector.inc";

		public function DateSelector() {

			super();
		}

		override protected function get defaultStyleProvider():IStyleProvider {

			return DateSelector.globalStyleProvider;
		}

		override protected function draw():void {

			super.draw();

			//  Required for include
			layoutDateSelectorControls();
			
			

		}

		override protected function initialize():void {

			
			super.initialize();

			//  Using AnchorLayout from initDateSeletor
			initDateSelector();
			 
			// Custom layout for date selector components
			this.spnMonth.layoutData = new AnchorLayoutData( 4, NaN, 4, 4 );
			this.spnDay.layoutData = new AnchorLayoutData( 4, NaN, 4, 2 );
			
			this.spnYear.layoutData = new AnchorLayoutData( 4, 4, 4, 2 );
			
			( this.spnDay.layoutData as AnchorLayoutData ).leftAnchorDisplayObject = spnMonth;
			( this.spnYear.layoutData as AnchorLayoutData ).leftAnchorDisplayObject = spnDay;

		}
	}
}
