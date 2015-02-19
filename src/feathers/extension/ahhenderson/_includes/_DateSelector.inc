 
import starling.events.Event;
import ahhenderson.core.util.DateUtil;
	
	
	import feathers.controls.SpinnerList;
	import feathers.data.ListCollection;
	import feathers.extension.ahhenderson.enums.FeathersComponentPoolType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.skins.IStyleProvider;
	
	import starling.display.Quad;
	import starling.events.Event;


public static const BASE_YEAR:int = 1900;

		public static var globalStyleProvider:IStyleProvider;
		
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
		
		protected function layoutDateSelectorControls():void{
			
			this.spnMonth.validate();
			this.spnDay.validate();
			this.spnYear.validate();
		}
		
		protected function initDateSelector():void{
			
			this.layout = new AnchorLayout()
			
			this.backgroundSkin = new Quad(10,10, 0xffffff);
			this.backgroundSkin.alpha = 1;
			
			// Month
			this.spnMonth = this.fmgr.pool.borrowObj( FeathersComponentPoolType.SPINNER_LIST );
			this.spnMonth.typicalItem = "September";
			this.spnMonth.dataProvider = new ListCollection(DateUtil.monthLabelsList);
			
			
			this.addChild( this.spnMonth );
			
			// Day
			this.spnDay = this.fmgr.pool.borrowObj( FeathersComponentPoolType.SPINNER_LIST );
			this.spnDay.typicalItem = "00";
			this.spnDay.dataProvider = generateData( 1, DateUtil.getDaysInMonth( selectedDate.month, selectedDate.fullYear ) + 1 );
			
			this.addChild( this.spnDay );
			
			// Year
			this.spnYear = this.fmgr.pool.borrowObj( FeathersComponentPoolType.SPINNER_LIST );
			this.spnYear.typicalItem = "00"; 
			this.spnYear.dataProvider = generateData( 1900, 2020 );
			
			this.addChild( this.spnYear );
			
			// Set selected values
			this.spnMonth.selectedIndex = ( selectedDate.month );
			this.spnDay.selectedIndex = ( selectedDate.date - 1 );
			this.spnYear.selectedIndex = getIndexForSelectedYear( selectedDate.fullYear );
			
			
			addHandlers();
		}
		
		protected function onListChange( e:Event ):void {

			switch ( e.currentTarget ) {

				case spnMonth:
					this.spnDay.dataProvider =
						generateData( 1, DateUtil.getDaysInMonth( spnMonth.selectedIndex, selectedDate.fullYear ) + 1 );

					selectedDate.date = 1;
					selectedDate.month = this.spnMonth.selectedIndex;
					this.spnDay.selectedIndex = ( selectedDate.date - 1 );
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