package feathers.extension.ahhenderson.controls.screens.drawers
{
	import feathers.controls.Header;
	import feathers.controls.LayoutGroup;
	import feathers.extension.ahhenderson.helpers.UiFactoryHelper;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.events.Event;
	
	public class TopHeaderDrawerOld extends LayoutGroup
	{
		public function TopHeaderDrawerOld()
		{
			super();
 		}
		
		public var header:Header;
		
		protected function onRemovedFromStage(e:Event):void{
			
			this.header.visible=false;
		}
		
		protected function onAddedFromStage(e:Event):void{
			
			toggleVisibility(true);
		}
		
		private function onFadeOutTweenComplete():void {
			
			this.touchable = true;
			header.visible = false;
			
			// Docked header
			
			// Do not remove for now
			/*if(_dockHeader){
			( _navigator.layoutData as AnchorLayoutData ).topAnchorDisplayObject = null;
			draw();
			} */
		}
		
		private function onFadeInTweenComplete():void {
			
			this.touchable = true;
		}
		
		
		
		protected function toggleVisibility(show:Boolean):void{
			
			this.touchable = false;
			
			if(show){
				header.alpha = 0;
				header.visible = true;
				this.touchable = false;
				
				
				Starling.juggler.tween( header, .25, { transition: Transitions.EASE_IN_OUT, alpha: 1, onComplete: onFadeInTweenComplete });
			}
			else{
				Starling.juggler.tween( header, .75, { transition: Transitions.EASE_IN_OUT, alpha: 0, onComplete: onFadeOutTweenComplete });
				
				
			}
			 
			
		}
		
		override protected function initialize():void{
			
			super.initialize();
			/*
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedFromStage);*/
			
			this.layout = new AnchorLayout();
			
			// Create background
			this.backgroundSkin = new Quad(10, 10, 0x000000);
			this.backgroundSkin.alpha = .5;
			
			// Create header
			
			this.header = UiFactoryHelper.headerFactory("Test");
			
			this.header.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			
			this.height = 60;
			
			//-----------------
			// Layout
			//-----------------
			/*		 
			var vertLayout:VerticalLayout = new VerticalLayout();
			vertLayout.firstGap= 15 * this.scaledResolution;
			vertLayout.lastGap = 20 * this.scaledResolution;
			vertLayout.gap=10 * this.scaledResolution;
			vertLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			vertLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			vertLayout.typicalItemWidth = 300;
			
			this.layout = vertLayout;*/
			
			this.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			
			this.addChild(this.header);
		}
		
	}
}