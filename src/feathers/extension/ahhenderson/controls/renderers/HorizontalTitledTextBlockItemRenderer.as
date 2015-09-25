package feathers.extension.ahhenderson.controls.renderers {

	import flash.geom.Point;
	import feathers.extension.ahhenderson.controls.renderers.base.BaseTitledTextBlockItemRenderer;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.ILayout;
	import feathers.layout.VerticalLayout;


	public class HorizontalTitledTextBlockItemRenderer extends BaseTitledTextBlockItemRenderer {

		private static const HELPER_POINT:Point = new Point();

		public function HorizontalTitledTextBlockItemRenderer() {
		}

		override public function setTitledTextBlockLayout():VerticalLayout {

			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.firstGap = 10 * this.scaledResolution;
			verticalLayout.lastGap = 10 * this.scaledResolution;
			verticalLayout.gap = 10 * this.scaledResolution;
			verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;

			// Set Textblock layout type
			this.controlLayoutData = new HorizontalLayoutData( 100, 100 );

			return verticalLayout;
		}

		override protected function defaultLayout():ILayout {

			const rendererLayout:HorizontalLayout = new HorizontalLayout();

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
