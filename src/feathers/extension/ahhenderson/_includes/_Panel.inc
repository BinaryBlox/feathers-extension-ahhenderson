import feathers.extension.ahhenderson.enums.HorizontalLocationType;
import feathers.controls.Header;
import feathers.core.IFeathersControl;
import starling.animation.Transitions;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	// Logic to show/hide header
	private var _inTransition:Boolean;
		 
		
		public function get isHeaderVisible():Boolean
		{
			return (this["header"]) ? this["header"].visible : false;
		}

		public function showHeader():void{
			  
			toggleHeaderVisiblity(true);
		}
		
		public function hideHeader():void{
			
			
			toggleHeaderVisiblity(false);
		}
		
		protected function toggleHeaderVisiblity( isVisible:Boolean ):void {
			 
			if(_inTransition) 
				return; 
			
			// Show
			if(isVisible){
			
				if(!this["header"] || (this["header"].visible && this["header"].alpha==1))
					return;
				 
				this["header"].visible = true;
				this["header"].alpha = 0;
				
				this.touchable = false;  
				_inTransition = true;
				Starling.juggler.tween(this["header"], .25, {transition: Transitions.EASE_IN_OUT, alpha: 1, onComplete: onHeaderFadeInTweenComplete});
				return;
			}
			
			// Hide
			if(!this["header"].visible)
				return;
			_inTransition = true;
			this.touchable = false;
			Starling.juggler.tween(this["header"], .25, {transition: Transitions.EASE_IN_OUT, alpha: 0, onComplete: onHeaderFadeOutTweenComplete});
			 
		}
		
		private function onHeaderFadeOutTweenComplete():void
		{
			_inTransition = false;
			this.touchable = true;
			this["header"].visible = false;
			 
		}
		
		private function onHeaderFadeInTweenComplete():void
		{
			_inTransition = false;
			this.touchable = true;
		}
		
			public function removeHeaderItems( location:HorizontalLocationType = null ):void {

			internalRemoveHeaderItems( this.header as Header, location );
		}

		public function removeFooterItems( location:HorizontalLocationType = null ):void {

			internalRemoveHeaderItems( this.footer as Header, location );
		}

		public function addHeaderItems( items:Vector.<DisplayObject>, location:HorizontalLocationType ):void {

			internalAddHeaderOrFooterItems( this.header as Header, items, location );

		}

		public function addFooterItems( items:Vector.<DisplayObject>, location:HorizontalLocationType ):void {

			internalAddHeaderOrFooterItems( this.footer as Header, items, location );
		}

		private function internalAddHeaderOrFooterItems( headerOrFooter:IFeathersControl, items:Vector.<DisplayObject>,
												 location:HorizontalLocationType ):void {

			if ( !( headerOrFooter as Header ))
				return;

			switch ( location ) {

				case HorizontalLocationType.CENTER:
					(headerOrFooter as Header).centerItems = items;
					break;

				case HorizontalLocationType.LEFT:
					(headerOrFooter as Header).leftItems = items;
					break;

				case HorizontalLocationType.RIGHT:
					(headerOrFooter as Header).rightItems = items;
					break;

			}
		}

		private function internalRemoveHeaderItems( headerOrFooter:Header, location:HorizontalLocationType = null ):void {

			if ( !( headerOrFooter as Header ))
				return;

			switch ( location ) {

				case HorizontalLocationType.CENTER:
					headerOrFooter.centerItems = null;
					break;

				case HorizontalLocationType.LEFT:
					headerOrFooter.leftItems = null;
					break;

				case HorizontalLocationType.RIGHT:
					headerOrFooter.rightItems = null;
					break;

				default:
					headerOrFooter.centerItems = null;
					headerOrFooter.leftItems = null;
					headerOrFooter.rightItems = null;
					break;

			}
		}
	 