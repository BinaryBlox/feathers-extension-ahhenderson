//------------------------------------------------------------------------------
//
//   Copyright ViziFit, Inc. 2014 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.helpers{

	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.display.TiledImage;
	import feathers.layout.TiledRowsLayout;
	
	import starling.display.DisplayObject;


	public class ListHelper {

		/*public static function borderSkinFunction( strokeAlpha:Number = NaN, strokeColor:uint = 0xffffff, strokeThickness = 2 ):Function {

			return function():DisplayObject {

				var borderSkin:CustomBackgroundSkin = new CustomBackgroundSkin();
				borderSkin.fillAlpha = 0;
				borderSkin.strokeAlpha = strokeAlpha;
				borderSkin.strokeColor = strokeColor;
				borderSkin.strokeThickness = strokeThickness;

				return borderSkin;
			}
		}*/

		public static function controlGroupListFactory( itemRenderFactory:Function, 
														selectable:Boolean = false, 
														hasElasticEdges:Boolean = false,
														visible:Boolean = false):List {

			var list:List = new List();
			list.visible = visible;
			list.isSelectable = selectable;
			list.hasElasticEdges = hasElasticEdges
			list.itemRendererFactory = itemRenderFactory;
			
			//TODO: Add default item renderer here later.
			//list.itemRendererFactory = ( itemRenderFactory ) ? itemRenderFactory : ComponentHelper.formLabelItemRendererFactory;

			return list;
		}

		public static function defaultItemRendererFactory( labelField:String = "labelField" ):IListItemRenderer {

			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = labelField;
			renderer.isQuickHitAreaEnabled = true;
			return renderer;
		}
 
		public static function tileListItemRendererFactory():IListItemRenderer {

			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = "label";
			renderer.iconSourceField = "texture";
			renderer.iconPosition = Button.ICON_POSITION_TOP;
			renderer.isQuickHitAreaEnabled = true;
			//renderer.defaultLabelProperties.textFormat = new BitmapFontTextFormat(this._font, NaN, 0x000000);
			return renderer;
		}

		public static function tiledBackgroundFactory( imageId:String, alpha:Number = 1,
													   defaultVisibility:Boolean = true ):TiledImage {
			//imageId:String = ThemeConstants.PATTERN_BACKGROUND_TILE
			const tiledImage:TiledImage = new TiledImage( AssetHelper.getImage( imageId ).texture );

			tiledImage.alpha = alpha;
			tiledImage.visible = defaultVisibility;

			return tiledImage;

		}

		public static function tiledBackgroundSkinFunction( imageId:String, alpha:Number = 1,
															defaultVisibility:Boolean = true ):Function {
			//imageId:String = ThemeConstants.PATTERN_BACKGROUND_TILE
			return function():DisplayObject {

				var tiledImage:TiledImage = new TiledImage( AssetHelper.getImage( imageId ).texture );

				tiledImage.alpha = alpha;
				tiledImage.visible = defaultVisibility;
				 
				return tiledImage;
			}
		}
		 

		public static function tiledListFactory( snapToPages:Boolean = true, visible:Boolean = false, selectable:Boolean = false,
												 hasElasticEdges:Boolean = false, itemRenderFactory:Function = null ):List {

			const listLayout:TiledRowsLayout = new TiledRowsLayout();
			listLayout.paging = TiledRowsLayout.PAGING_HORIZONTAL;
			listLayout.useSquareTiles = false;
			listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			listLayout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			//listLayout.manageVisibility = true;
			listLayout.gap = 0;
			listLayout.padding = 0;

			var list:List = new List();
			list.snapToPages = snapToPages;
			list.visible = visible;
			list.isSelectable = selectable;
			list.hasElasticEdges = hasElasticEdges
			list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_NONE;
			list.horizontalScrollPolicy = List.SCROLL_POLICY_ON;
			list.verticalScrollPolicy = List.SCROLL_POLICY_OFF;

			list.itemRendererFactory = ListHelper.tileListItemRendererFactory;

			//list.itemRendererFactory = ( itemRenderFactory ) ? itemRenderFactory : UIHpr.formLabelItemRendererFactory;
			list.layout = listLayout;

			return list;
		}

		
	}
}
