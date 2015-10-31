package feathers.extension.ahhenderson.controls.screens.drawers {

	import feathers.controls.LayoutGroup;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_StyleNameConstants;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.skins.IStyleProvider;
	
	import starling.animation.Transitions;
	import starling.core.Starling;


	public class TopDrawer extends LayoutGroup {

		protected static const INVALIDATION_FLAG_HEADER_FACTORY:String = "headerFactory";

		public function TopDrawer() {

			super();
		}
		
		public static var globalStyleProvider:IStyleProvider;
		
		/**
		 * @private
		 */
		override protected function get defaultStyleProvider():IStyleProvider {
			
			return TopDrawer.globalStyleProvider;
		}

		protected var _customHeaderStyleName:String;

		private var _header:TopDrawerHeader;

		public function get customHeaderStyleName():String {

			return this._customHeaderStyleName;
		}

		public function set customHeaderStyleName( value:String ):void {

			if ( this._customHeaderStyleName == value ) {
				return;
			}
			this._customHeaderStyleName = value;

			if ( this._header && _header.styleNameList.contains( this._customHeaderStyleName )) {
				this._header.styleNameList.add( this._customHeaderStyleName );
			}

			//this.invalidate(INVALIDATION_FLAG_HEADER_FACTORY);
			//hack because the super class doesn't know anything about the
			//header factory
			this.invalidate( INVALIDATION_FLAG_SIZE );
		}

		public function get header():TopDrawerHeader {

			return _header;
		}

		override protected function initialize():void {

			super.initialize();

			this.layout = new AnchorLayout();
			this.layoutData = new AnchorLayoutData( 0, 0, 0, 0 );

			this._header = new TopDrawerHeader();
			
			// Custom Header Style
			if ( this._customHeaderStyleName && !_header.styleNameList.contains( this._customHeaderStyleName )) {
				_header.styleNameList.add( this._customHeaderStyleName );
			} else {
				_header.styleNameList.add( FeathersExtLib_StyleNameConstants.DRAWER__TOP_HEADER_SEMI_DARK );
			}

			this._header.layoutData = new AnchorLayoutData( 0, 0, 0, 0 );

			this.addChild( this._header );

		}

		protected function toggleVisibility( show:Boolean ):void {

			if ( show ) {

				// Already visible
				if ( header.visible && ( header.alpha == 1 ))
					return;

				header.touchable = false;
				header.alpha = 0;
				header.visible = true;
				Starling.juggler.tween( header,
										.20,
										{ transition: Transitions.EASE_IN_OUT, alpha: 1, onComplete: onHeaderFadeInTweenComplete });
			} else {

				// Already hidden
				if ( !header.visible )
					return;

				header.touchable = false;
				Starling.juggler.tween( header,
										.25,
										{ transition: Transitions.EASE_IN_OUT, alpha: 0, onComplete: onHeaderFadeInTweenComplete });
			}

		}

		private function onHeaderFadeInTweenComplete():void {

			header.touchable = true;

		}

		private function onHeaderFadeOutTweenComplete():void {

			header.touchable = false;
			header.visible = false;

		}
	}
}
