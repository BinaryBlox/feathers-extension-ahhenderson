package feathers.extension.ahhenderson.controls.renderers {

	import flash.geom.Point;
	
	import ahhenderson.core.ui.layout.HorizontalAlign;
	
	import feathers.extension.ahhenderson.controls.renderers.base.BaseTitledTextBlockItemRenderer;
	import feathers.extension.ahhenderson.helpers.LayoutHelper;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.ILayout;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import feathers.skins.IStyleProvider;


	public class VerticalTitledTextBlockItemRenderer extends BaseTitledTextBlockItemRenderer {

		private static const HELPER_POINT:Point = new Point();

		public function VerticalTitledTextBlockItemRenderer() {
		}
		
		/**
		 * The default <code>IStyleProvider</code> for all <code>ToggleButton</code>
		 * components. If <code>null</code>, falls back to using
		 * <code>Button.globalStyleProvider</code> instead.
		 *
		 * @default null
		 * @see feathers.core.FeathersControl#styleProvider
		 * @see feathers.controls.Button#globalStyleProvider
		 */
		public static var globalStyleProvider:IStyleProvider;
		
		
		/**
		 * @private
		 */
		override protected function get defaultStyleProvider():IStyleProvider {
			
			return VerticalTitledTextBlockItemRenderer.globalStyleProvider;
		}
		
		override protected function postLayout():void{
			
			super.postLayout();
			
			if(this.backgroundSkin)
			{
				this.backgroundSkin.width = this.actualWidth;
				this.backgroundSkin.height = this.actualHeight;
			}
			
			//this.width = this.owner.width - Main.GAP;
			this._labelIcon.x = LayoutHelper.getHorizontalAlignX(HorizontalAlign.CENTER, this.actualWidth, this._labelIcon.width);
			
			/*	imageLock.x = this.actualWidth - imageLock.width - Main.GAP * 0.5;
			imageLock.y = this.actualHeight*0.5 - imageLock.height * 0.5;
			sc.x = image.width - Main.GAP * 0.5;*/
			
		}

		override public function setTitledTextBlockLayout():VerticalLayout {

			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.firstGap = 10 * this.scaledResolution;
			verticalLayout.lastGap = 10 * this.scaledResolution;
			verticalLayout.gap = 10 * this.scaledResolution;
			verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;

			// Set Textblock layout type
			this.controlLayoutData = new VerticalLayoutData( 100, 100 );

			return verticalLayout;
		}

		override protected function defaultLayout():ILayout {

			const rendererLayout:VerticalLayout = new VerticalLayout();

			rendererLayout.firstGap = 10 * this.fmgr.theme.scaledResolution;
			rendererLayout.lastGap = 10 * this.fmgr.theme.scaledResolution;
			rendererLayout.gap = 15 * this.fmgr.theme.scaledResolution;
			rendererLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			rendererLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;

			rendererLayout.padding = 10 * this.fmgr.theme.scaledResolution;

			return rendererLayout;
		}
	}
}
