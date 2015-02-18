package feathers.extension.ahhenderson.controls.screens {

	import feathers.controls.Header;
	import feathers.controls.LayoutGroup;
	import feathers.controls.ScreenNavigator;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_StyleNameConstants;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	import feathers.skins.IStyleProvider;
	import feathers.utils.math.roundToNearest;
	
	import starling.animation.Transitions;
	import starling.core.Starling;


	public class TitledNavigatorScreen extends LayoutGroup {

		public static var globalStyleProvider:IStyleProvider;

		public function TitledNavigatorScreen() {

			super();
		}

		protected var _header:Header;

		protected var _navigator:ScreenNavigator;

		private var _verticalLayout:VerticalLayout;

		protected var _title:String;

		public function get title():String {

			if ( _header )
				return _header.title;

			return null;
		}

		public function set title( value:String ):void {

			if ( _header && value )
				_header.title = value;

		}

		public function get header():Header {

			return _header;
		}

		public function get navigator():ScreenNavigator {

			return _navigator;
		}

		public function get customHeaderStyleName():String
		{
			return this._customHeaderStyleName;
		}
		
		/**
		 * @private
		 */
		protected static const INVALIDATION_FLAG_HEADER_FACTORY:String = "headerFactory";
		
		/**
		 * @private
		 */
		protected var _customHeaderStyleName:String;
		
		/**
		 * @private
		 */
		public function set customHeaderStyleName(value:String):void
		{
			if(this._customHeaderStyleName == value)
			{
				return;
			}
			this._customHeaderStyleName = value;
			
			if(this._header && _header.styleNameList.contains(this._customHeaderStyleName)){
				this._header.styleNameList.add(this._customHeaderStyleName);
			}
			
			//this.invalidate(INVALIDATION_FLAG_HEADER_FACTORY);
			//hack because the super class doesn't know anything about the
			//header factory
			this.invalidate(INVALIDATION_FLAG_SIZE);
		}
		
		override protected function draw():void {

			super.draw();

			if ( !_navigator.visible ) {
				_navigator.visible = true;
			}

			// Maybe use later if we care about excluding header from being overwritten by content.
			/*if ( !_header.visible ) {
				if (( _navigator.layoutData as AnchorLayoutData ).topAnchorDisplayObject ) {
					( _navigator.layoutData as AnchorLayoutData ).topAnchorDisplayObject = null;
				}

			} else {
				if (( _navigator.layoutData as AnchorLayoutData ).topAnchorDisplayObject != _header ) {
					( _navigator.layoutData as AnchorLayoutData ).topAnchorDisplayObject = _header;
				}
			}*/

			_header.width = this.actualWidth;
			_navigator.width = this.actualWidth;
		}

		public function toggleHeaderVisiblity( showHeader:Boolean ):void {
  
			// Show
			if(showHeader){
				
				if(_header.visible && _header.alpha==1)
					return;
				
				_header.visible = true;
				_header.alpha = 0;
				
				this.touchable = false;  
				Starling.juggler.tween(_header, .25, {transition: Transitions.EASE_IN_OUT, alpha: 1, onComplete: onFadeInTweenComplete});
				return;
			}
			 
			// Hide
			if(!_header.visible)
				return;
			
			this.touchable = false;
			Starling.juggler.tween(_header, .25, {transition: Transitions.EASE_IN_OUT, alpha: 0, onComplete: onFadeOutTweenComplete});
			
			// Keep around for possible use later.
			/*if ( !isVisible && ( _navigator.layoutData as AnchorLayoutData ).topAnchorDisplayObject ) {

				if(!( _navigator.layoutData as AnchorLayoutData ).topAnchorDisplayObject)
					return;
				
				this.touchable = false;
				Starling.juggler.tween(_header, .75, {transition: Transitions.EASE_IN_OUT, alpha: 0, onComplete: onFadeOutTweenComplete});
				 
			} else if (( _navigator.layoutData as AnchorLayoutData ).topAnchorDisplayObject != _header ) {
				 
				_header.visible = true;
				this.touchable = false;
				( _navigator.layoutData as AnchorLayoutData ).topAnchorDisplayObject = _header;
				 
				_header.alpha = 0;
				Starling.juggler.tween(_header, .25, {transition: Transitions.EASE_IN_OUT, alpha: 1, onComplete: onFadeInTweenComplete});
			 
			} 
*/
		}
		
		private function onFadeOutTweenComplete():void
		{

			this.touchable = true;
			_header.visible = false;
			//draw();
			// Possbile save for later
			/*( _navigator.layoutData as AnchorLayoutData ).topAnchorDisplayObject = null;
			draw(); */
		}
		
		private function onFadeInTweenComplete():void
		{
			this.touchable = true;
		}

		override protected function initialize():void {

			this.layout = new AnchorLayout();

			var headerLayoutData:AnchorLayoutData = new AnchorLayoutData();
			headerLayoutData.left = 0;
			headerLayoutData.right = 0;
			headerLayoutData.top = 0;

			_header = new Header();
			_header.visible = false;
			_header.height = roundToNearest(60 * this.scaledResolution);
			
			this.addChild( _header );
			 
			if(this._customHeaderStyleName && !_header.styleNameList.contains(this._customHeaderStyleName)){
				_header.styleNameList.add(this._customHeaderStyleName);
			}
			else{
				_header.styleNameList.add(FeathersExtLib_StyleNameConstants.HEADER_TITLED_NAVIGATOR_SCREEN);
			}

			var navigatorLayoutData:AnchorLayoutData = new AnchorLayoutData();
			navigatorLayoutData.left = 0;
			navigatorLayoutData.right = 0;
			navigatorLayoutData.bottom = 0;
			navigatorLayoutData.top = 0;

			_navigator = new ScreenNavigator();
			_navigator.layoutData = navigatorLayoutData;
			_navigator.visible = false;

			this.addChild( _navigator );
		}
	}
}
