
package feathers.extension.ahhenderson.controls {

	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	
	import ahhenderson.core.util.CustomTimer;
	import ahhenderson.core.util.DateUtil;
	
	import feathers.controls.LayoutGroup;
	import feathers.controls.SpinnerList;
	import feathers.data.ListCollection;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_StyleNameConstants;
	import feathers.extension.ahhenderson.enums.FeathersComponentPoolType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.skins.IStyleProvider;
	
	import starling.events.Event;


	public class DateSelector extends LayoutGroup {

		include "../_includes/_FeathersAppManager.inc";

		public static const BASE_YEAR:int = 1900;

		public static var globalStyleProvider:IStyleProvider;

		//include "../_includes/_DateSelector.inc";

		public function DateSelector() {

			super();
		}

		public var spnDay:SpinnerList;

		public var spnMonth:SpinnerList;

		public var spnYear:SpinnerList;

		private var _gap:Number = 10 * this.scaledResolution;

		private var _padding:Number;

		private var _selectedDate:Date;

		private var picklistsDefinition:ListCollection;

		override public function dispose():void {

			removeHandlers();

			super.dispose();
		}

		public function get gap():Number {

			return _gap;
		}

		public function set gap( value:Number ):void {

			_gap = value;
		}

		public function get padding():Number {

			return _padding;
		}

		public function set padding( value:Number ):void {

			_padding = value;
		}

		public function get selectedDate():Date {

			if ( !_selectedDate )
				_selectedDate = new Date( 1980, 1, 1 );

			return _selectedDate;
		}

		public function set selectedDate( value:Date ):void {

			_selectedDate = value;
		}

		protected function addHandlers():void {

			this.spnMonth.addEventListener( Event.CHANGE, onListChange );
			this.spnDay.addEventListener( Event.CHANGE, onListChange );
			this.spnYear.addEventListener( Event.CHANGE, onListChange );
		}

		override protected function get defaultStyleProvider():IStyleProvider {

			return DateSelector.globalStyleProvider;
		}

		override protected function draw():void {

			super.draw();

			//  Required for include
			layoutDateSelectorControls();

		}

		protected function initDateSelector():void {

			this.layout = new AnchorLayout()

			/*this.backgroundSkin = new Quad( 10, 10, 0xffffff );
			this.backgroundSkin.alpha = 1;
*/
			// Month
			this.spnMonth = this.fmgr.pool.borrowObj( FeathersComponentPoolType.SPINNER_LIST );
			this.spnMonth.typicalItem = "September";
			this.spnMonth.styleNameList.add(FeathersExtLib_StyleNameConstants.SPINNER_LIST__ALTERNATE_OVERLAY);
			this.spnMonth.dataProvider = new ListCollection( DateUtil.monthLabelsList );

			this.addChild( this.spnMonth );

			// Day
			this.spnDay = this.fmgr.pool.borrowObj( FeathersComponentPoolType.SPINNER_LIST );
			this.spnDay.typicalItem = "00";
			this.spnDay.styleNameList.add(FeathersExtLib_StyleNameConstants.SPINNER_LIST__ALTERNATE_OVERLAY);
			this.spnDay.dataProvider = generateData( 1, DateUtil.getDaysInMonth( selectedDate.month, selectedDate.fullYear ) + 1 );

			this.addChild( this.spnDay );

			// Year
			this.spnYear = this.fmgr.pool.borrowObj( FeathersComponentPoolType.SPINNER_LIST );
			this.spnYear.styleNameList.add(FeathersExtLib_StyleNameConstants.SPINNER_LIST__ALTERNATE_OVERLAY);
			this.spnYear.typicalItem = "00";
			this.spnYear.dataProvider = generateData( 1900, 2020 );

			this.addChild( this.spnYear );

			// Set selected values
			this.spnMonth.selectedIndex = ( selectedDate.month );
			this.spnDay.selectedIndex = ( selectedDate.date - 1 );
			this.spnYear.selectedIndex = getIndexForSelectedYear( selectedDate.fullYear );

			addHandlers();
		}

		override protected function initialize():void {

			super.initialize();

			//  Using AnchorLayout from initDateSeletor
			initDateSelector();

			// Custom layout for date selector components
			this.spnMonth.layoutData = new AnchorLayoutData( 4, NaN, 4, 4 );
			this.spnDay.layoutData = new AnchorLayoutData( 4, NaN, 4, 0 );

			this.spnYear.layoutData = new AnchorLayoutData( 4, 4, 4, 0 );

			( this.spnDay.layoutData as AnchorLayoutData ).leftAnchorDisplayObject = spnMonth;
			( this.spnYear.layoutData as AnchorLayoutData ).leftAnchorDisplayObject = spnDay;

		}

		protected function layoutDateSelectorControls():void {

			this.spnMonth.validate();
			this.spnDay.validate();
			this.spnYear.validate();
		}

	 
		
		private var _delayTimer:CustomTimer;

		private function onTimerComplete(e:TimerEvent):void {
			
			var currentTick:int = getTimer(); 
			var delta:int = currentTick-_lastRequestTicks;
			
			if(delta<400){
				_delayTimer.start();
				return;
			}
			
			if (_delayTimer.TimerData ){ 
				trace("Timer is complete... ");
				 var daysInSelectedMonth:int = _delayTimer.TimerData.selectedMoDays;
				 var daysInPreviousMonth:int = _delayTimer.TimerData.previousMoDays;
				 var currentDate:int = selectedDate.date;
				 //DialogHelper.showLoadingDialog("Spinner updating", "Spinnter updating", 1.5);
				 
				 this.fmgr.logger.trace(this, "Current Date: " + currentDate.toString() + " - Days in Sel. Month: " + daysInSelectedMonth.toString());
				 
				 // Validate to determine if change is needed
				 if(daysInSelectedMonth != daysInPreviousMonth){
					 this.spnDay.dataProvider =
						 generateData( 1, daysInSelectedMonth + 1 );
					 
					 // Set to nearest available date. 
					 this.spnDay.selectedIndex = (currentDate > this.spnDay.dataProvider.length) ? ( this.spnDay.dataProvider.length - 1 ) : (currentDate-1); 
				 }
				 else if(currentDate > daysInSelectedMonth){ 
					 this.spnDay.selectedIndex =  daysInSelectedMonth - 1;
				 }
			}
			
			_delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
		}
		
		private var _lastRequestTicks:int;
		
		private var _timerDelay:int=500;
		/**
		 *
		 * @param delay (in milliseconds)
		 * @param message
		 */
		protected function delayDaySpinnerUpdate( properties:Object):void {
			
			if(!_delayTimer)
				_delayTimer = new CustomTimer(_timerDelay, 1);
			  
			_delayTimer.TimerData = properties;
			
			if(_delayTimer.running){ 
				_lastRequestTicks = getTimer();
				 return;
			}
			
			// Start a new timer
			_delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete, false, 0, true);
			_delayTimer.start();
			 
		}
		
		protected function onListChange( e:Event ):void {

			switch ( e.currentTarget ) {

				case spnMonth:
					
					trace("Timer is spinning... ");
					var daysInSelectedMonth:int = DateUtil.getDaysInMonth(this.spnMonth.selectedIndex, selectedDate.fullYear);
					var daysInPreviousMonth:int = DateUtil.getDaysInMonth(selectedDate.month, selectedDate.fullYear); 
					 
					delayDaySpinnerUpdate({selectedMoDays: daysInSelectedMonth, previousMoDays : daysInPreviousMonth});
				 
					// Set selected month
					selectedDate.month = this.spnMonth.selectedIndex;
					  
					break;

				case spnDay:
					selectedDate.date = this.spnDay.selectedIndex + 1;
					
					break;

				case spnYear:
					selectedDate.fullYear = this.spnYear.selectedIndex + BASE_YEAR;
					
					break;
			}
		}

		protected function removeHandlers():void {

			this.spnMonth.removeEventListener( Event.CHANGE, onListChange );
			this.spnDay.removeEventListener( Event.CHANGE, onListChange );
			this.spnYear.removeEventListener( Event.CHANGE, onListChange );
		}

		internal function getIndexForSelectedYear( selectedYear:int ):int {

			return selectedYear - BASE_YEAR
		}

		
		/*private function defaultItemRendererFactory(labelField:String="labelField"):IListItemRenderer {
		var renderer:DefaultListItemRenderer=new DefaultListItemRenderer();
		//renderer.labelField=labelField;
		renderer.isQuickHitAreaEnabled=true;
		return renderer;
		}
		*/

		private function generateData( startValue:int = 0, maxValue:int = 0 ):ListCollection {

			var values:Array = new Array();

			for ( var i:int = startValue; i < maxValue; i++ )
				values.push({ label: i.toString()});

			return new ListCollection( values );

		}
	}
}
