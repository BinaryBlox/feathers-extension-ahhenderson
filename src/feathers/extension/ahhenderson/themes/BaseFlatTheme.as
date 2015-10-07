
/*
Copyright (c) 2014 Josh Tynjala

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
package feathers.extension.ahhenderson.themes {

	 
	
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import ahhenderson.core.managers.ObjectPoolManager;
	
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Callout;
	import feathers.controls.Check;
	import feathers.controls.Drawers;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.NumericStepper;
	import feathers.controls.PageIndicator;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.controls.PickerList;
	import feathers.controls.ProgressBar;
	import feathers.controls.Radio;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.controls.Scroller;
	import feathers.controls.SimpleScrollBar;
	import feathers.controls.Slider;
	import feathers.controls.SpinnerList;
	import feathers.controls.TabBar;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleButton;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.popups.BottomDrawerPopUpContentManager;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextBlockTextEditor;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.PopUpManager;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.extension.ahhenderson.ahhenderson_extension_internal;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_StyleNameConstants;
	import feathers.extension.ahhenderson.controls.popUps.CustomBottomDrawerPopUpManager;
	import feathers.extension.ahhenderson.enums.FeathersComponentPoolType;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	import feathers.extension.ahhenderson.managers.dependency.themeManager.supportClasses.BaseManagedTheme;
	import feathers.extension.ahhenderson.themes.constants.FlatThemeCustomTextures;
	import feathers.extension.ahhenderson.themes.pool.BaseFlatThemePoolFunctions;
	import feathers.extension.ahhenderson.util.DrawingUtils;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.skins.StandardIcons;
	import feathers.system.DeviceCapabilities;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import feathers.utils.math.roundToNearest;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;

	use namespace ahhenderson_extension_internal;


	/**
	 * The base class for the "Metal Works" theme for mobile Feathers apps.
	 * Handles everything except asset loading, which is left to subclasses.
	 *
	 * @see MetalWorksMobileTheme
	 * @see MetalWorksMobileThemeWithAssetManager
	 */
	/**
	 * 
	 * @author thenderson
	 */
	public class BaseFlatTheme extends BaseManagedTheme  {
		 
		/**
		 * @private
		 * The theme's custom style name for the thumb of a horizontal SimpleScrollBar.
		 */
		protected static const THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB:String = "metal-works-mobile-horizontal-simple-scroll-bar-thumb";
		
		/**
		 * @private
		 * The theme's custom style name for the thumb of a vertical SimpleScrollBar.
		 */
		protected static const THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB:String = "metal-works-mobile-vertical-simple-scroll-bar-thumb";
		
	 
		
		protected static var ITEM_RENDERER_BACKGROUND_COLOR:uint = 0xFFFFFF;
		
		/**
		 * 
		 * @default 
		 */
		protected static var PRIMARY_BACKGROUND_COLOR:uint = 0x4a4137;

		/**
		 * 
		 * @default 
		 */
		protected static var LIGHT_TEXT_COLOR:uint = 0xe5e5e5;
		
		/**
		 * 
		 * @default 
		 */
		protected static var ITEM_RENDERER_LABEL_COLOR_DARK:uint = 0x404040;
		
		/**
		 * 
		 * @default 
		 */
		protected static var ITEM_RENDERER_LABEL_COLOR_LIGHT:uint = 0xFFFFFF;

		/**
		 * 
		 * @default 
		 */
		protected static var DARK_TEXT_COLOR:uint = 0x1a1816;

		/**
		 * 
		 * @default 
		 */
		protected static var SELECTED_TEXT_COLOR:uint = 0xff9900;

		/**
		 * 
		 * @default 
		 */
		protected static var DISABLED_TEXT_COLOR:uint = 0x8a8a8a;

		/**
		 * 
		 * @default 
		 */
		protected static var DARK_DISABLED_TEXT_COLOR:uint = 0x383430;

		/**
		 * 
		 * @default 
		 */
		protected static var LIST_BACKGROUND_COLOR:uint = 0x383430;

		/**
		 * 
		 * @default 
		 */
		protected static var TAB_BACKGROUND_COLOR:uint = 0x1a1816;

		/**
		 * 
		 * @default 
		 */
		protected static var TAB_DISABLED_BACKGROUND_COLOR:uint = 0x292624;

		/**
		 * 
		 * @default 
		 */
		protected static var GROUPED_LIST_HEADER_BACKGROUND_COLOR:uint = 0x2e2a26;

		/**
		 * 
		 * @default 
		 */
		protected static var GROUPED_LIST_FOOTER_BACKGROUND_COLOR:uint = 0x2e2a26;

		/**
		 * 
		 * @default 
		 */
		protected static var MODAL_OVERLAY_COLOR:uint = 0x29241e;

		/**
		 * 
		 * @default 
		 */
		protected static var MODAL_OVERLAY_ALPHA:Number = 0.8;

		/**
		 * 
		 * @default 
		 */
		protected static var DRAWER_OVERLAY_COLOR:uint = 0x29241e;

		/**
		 * 
		 * @default 
		 */
		protected static var DRAWER_OVERLAY_ALPHA:Number = 0.4;

		/**
		 * 
		 * @default 
		 */
		protected static var ACTION_COLOR:uint = 0xFF8000;

		
		
		
		/**
		 * @private
		 * The theme's custom style name for the minimum track of a horizontal slider.
		 */
		protected static const THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK:String = "metal-works-mobile-horizontal-slider-minimum-track";
		
		/**
		 * @private
		 * The theme's custom style name for the maximum track of a horizontal slider.
		 */
		protected static const THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK:String = "metal-works-mobile-horizontal-slider-maximum-track";
		
		/**
		 * @private
		 * The theme's custom style name for the minimum track of a vertical slider.
		 */
		protected static const THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK:String = "metal-works-mobile-vertical-slider-minimum-track";
		
		/**
		 * @private
		 * The theme's custom style name for the maximum track of a vertical slider.
		 */
		protected static const THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK:String = "metal-works-mobile-vertical-slider-maximum-track";
		
		/**
		 * The screen density of an iPhone with Retina display. The textures
		 * used by this theme are designed for this density and scale for other
		 * densities.
		 */
		protected static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;

		/**
		 * The screen density of an iPad with Retina display. The textures used
		 * by this theme are designed for this density and scale for other
		 * densities.
		 */
		protected static const ORIGINAL_DPI_IPAD_RETINA:int = 264;

		//// SCALING GRIDS
		//////////////////////
		
		
	
		
		protected static var SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID:Rectangle = new Rectangle(8, 8, 184, 84);//new Rectangle(11, 11, 2, 2);
		
		/**
		 * 
		 * @default 
		 */
		protected static var DEFAULT_SCALE9_GRID:Rectangle = new Rectangle( 5, 5, 22, 22 );

		/**
		 * 
		 * @default 
		 */
		protected static var POPUP_SCALE9_GRID:Rectangle = new Rectangle( 24, 24, 150, 150 );

		/**
		 * 
		 * @default 
		 */
		protected static var BUTTON_SCALE9_GRID:Rectangle = new Rectangle( 8, 8, 184, 84 ); //184, 84 );
		  
		/**
		 * 
		 * @default 
		 */
		protected static var BUTTON_SELECTED_SCALE9_GRID:Rectangle = BUTTON_SCALE9_GRID;

		/**
		 * 
		 * @default 
		 */
		protected static var BACK_BUTTON_SCALE3_REGION1:Number = 64;

		/**
		 * 
		 * @default 
		 */
		protected static var BACK_BUTTON_SCALE3_REGION2:Number = 94;

		/**
		 * 
		 * @default 
		 */
		protected static var FORWARD_BUTTON_SCALE3_REGION1:Number = 8;

		/**
		 * 
		 * @default 
		 */
		protected static var FORWARD_BUTTON_SCALE3_REGION2:Number = 102;

		/**
		 * 
		 * @default 
		 */
		protected static var ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle( 24, 24, 546, 38 );

		/**
		 * 
		 * @default 
		 */
		protected static var INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle = new Rectangle( 13, 13, 3, 70 );

		/**
		 * 
		 * @default 
		 */
		protected static var INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle = new Rectangle( 13, 0, 3, 75 );

		/**
		 * 
		 * @default 
		 */
		protected static var INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle( 13, 13, 3, 62 );

		/**
		 * 
		 * @default 
		 */
		protected static var TAB_SCALE9_GRID:Rectangle = new Rectangle( 16, 16, 56, 30 );

		/**
		 * 
		 * @default 
		 */
		protected static var SCROLL_BAR_THUMB_REGION1:int = 10;

		/**
		 * 
		 * @default 
		 */
		protected static var SCROLL_BAR_THUMB_REGION2:int = 28;

		//// FONTS
		//////////////////////
		/**
		 * The name of the embedded font used by controls in this theme. Comes
		 * in normal and bold weights.
		 */
		internal var FONT_NAME:String; // = "Avenir";

		internal var FONT_NAME_BOLD:String;

		internal var FONT_NAME_REGULAR:String;

		internal var FONT_SIZE_SMALL:Number;

		internal var FONT_SIZE_NORMAL:Number;

		internal var FONT_SIZE_MEDIUM:Number;

		internal var FONT_SIZE_LARGE:Number;

		internal var FONT_SIZE_XLARGE:Number;

		 

		internal var baseAtlasName:String;
		
		internal var customAtlasName:String;

		// THEME PADDING
		private var buttonPaddingTop:Number;

		private var buttonPaddingBottom:Number;
		
		private var buttonPaddingLeft:Number;
		
		private var buttonPaddingRight:Number;

		private var itemPaddingTop:Number;

		private var itemPaddingBottom:Number;
		
		
		
		/**
		 * @private
		 * The theme's custom style name for item renderers in a PickerList.
		 */
		protected static var THEME_NAME_PICKER_LIST_ITEM_RENDERER:String;
		;

		/**
		 * @private
		 * The theme's custom style name for buttons in an Alert's button group.
		 */
		protected static var THEME_NAME_ALERT_BUTTON_GROUP_BUTTON:String;

		/**
		 * @private
		 * The theme's custom style name for the thumb of a horizontal SimpleScrollBar.
		 */
		protected static var THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB:String;

		/**
		 * @private
		 * The theme's custom style name for the thumb of a vertical SimpleScrollBar.
		 */
		protected static var THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB:String;

		/**
		 * @private
		 * The theme's custom style name for the minimum track of a horizontal slider.
		 */
		protected static var THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK:String;

		/**
		 * @private
		 * The theme's custom style name for the maximum track of a horizontal slider.
		 */
		protected static var THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK:String;

		/**
		 * @private
		 * The theme's custom style name for the minimum track of a vertical slider.
		 */
		protected static var THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK:String;
		
		/**
		 * @private
		 * The theme's custom style name for the maximum track of a vertical slider.
		 */
		protected static var THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK:String;

		// NEW CODE
		protected var spinnerListSelectionOverlaySkinTextures:Scale9Textures;
		/**
		 * @private
		 * The theme's custom style name for item renderers in a SpinnerList.
		 */
		protected static const THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER:String = "flat-theme-mobile-spinner-list-item-renderer";
		
		
		
		protected function get itemRendererBackground():Quad
		{
			
			if(!_itemRendererBackground){
				_itemRendererBackground =new Quad(this.itemRendererMinSize, this.itemRendererMinSize, ITEM_RENDERER_BACKGROUND_COLOR);
			}
			
			return _itemRendererBackground;
		}

		protected function set itemRendererBackground(value:Quad):void
		{
			_itemRendererBackground = value;
		}

		override public function validateThemeConfiguration():String {

			return super.validateThemeConfiguration();
			
			 
		}
  
		/**
		 * The default global text renderer factory for this theme creates a
		 * TextBlockTextRenderer.
		 */
		protected static function textRendererFactory():TextBlockTextRenderer {

			return new TextBlockTextRenderer();
		}

		/**
		 * The default global text editor factory for this theme creates a
		 * StageTextTextEditor.
		 */
		protected static function textEditorFactory():StageTextTextEditor {

			return new StageTextTextEditor();
		}

		/**
		 * The text editor factory for a NumericStepper creates a
		 * TextBlockTextEditor.
		 */
		protected static function stepperTextEditorFactory():TextBlockTextEditor {

			//we're only using this text editor in the NumericStepper because
			//isEditable is false on the TextInput. this text editor is not
			//suitable for mobile use if the TextInput needs to be editable
			//because it can't use the soft keyboard or other mobile-friendly UI
			return new TextBlockTextEditor();
		}
		
		/**
		 * The pop-up factory for a PickerList creates a SpinnerList.
		 */
		protected static function pickerListSpinnerListFactory():SpinnerList
		{
			return new SpinnerList();
		}

		/**
		 * This theme's scroll bar type is SimpleScrollBar.
		 */
		protected static function scrollBarFactory():SimpleScrollBar {

			return new SimpleScrollBar();
		}

		/**
		 * 
		 * @return 
		 */
		protected static function popUpOverlayFactory():DisplayObject {

			var quad:Quad = new Quad( 100, 100, MODAL_OVERLAY_COLOR );
			quad.alpha = MODAL_OVERLAY_ALPHA;
			return quad;
		}

		/**
		 * SmartDisplayObjectValueSelectors will use ImageLoader instead of
		 * Image so that we can use extra features like pixel snapping.
		 */
		protected static function textureValueTypeHandler( value:Texture, oldDisplayObject:DisplayObject = null ):DisplayObject {

			var displayObject:ImageLoader = oldDisplayObject as ImageLoader;

			if ( !displayObject ) {
				displayObject = new ImageLoader();
			}
			displayObject.source = value;
			return displayObject;
		}
 
		 
		private var _fmgr:FeathersApplicationManager;
		
		protected function get fmgr():FeathersApplicationManager
		{
			if(!_fmgr)
				_fmgr = FeathersApplicationManager.instance;
			
			return _fmgr;
		}

		/**
		 * 
		 * @param themeProperties
		 * @param scaleToDPI
		 */
		public function BaseFlatTheme( properties:Object = null, scaleToDPI:Boolean = true ) {

				super(properties, scaleToDPI); 
		}
 
		

		/**
		 * A smaller font size for details.
		 */
		protected var smallFontSize:int;

		/**
		 * A smaller font size for details.
		 */
		protected var mediumFontSize:int;

		/**
		 * A normal font size.
		 */
		protected var regularFontSize:int;

		/**
		 * A larger font size for headers.
		 */
		protected var largeFontSize:int;

		/**
		 * An extra large font size.
		 */
		protected var extraLargeFontSize:int;

		/**
		 * The size, in pixels, of major regions in the grid. Used for sizing
		 * containers and larger UI controls.
		 */
		protected var gridSize:int;

		/**
		 * The size, in pixels, of minor regions in the grid. Used for larger
		 * padding and gaps.
		 */
		protected var gutterSize:int;

		/**
		 * The size, in pixels, of smaller padding and gaps within the major
		 * regions in the grid.
		 */
		protected var smallGutterSize:int;

		/**
		 * The size, in pixels, of smaller padding and gaps within the major
		 * regions in the grid.
		 */
		protected var largeGutterSize:int;

		/**
		 * The size, in pixels, of smaller padding and gaps within the major
		 * regions in the grid.
		 */
		protected var xSmallGutterSize:int;

		/**
		 * The width, in pixels, of UI controls that span across multiple grid regions.
		 */
		protected var wideControlSize:int;

		/**
		 * The size, in pixels, of a typical UI control.
		 */
		protected var controlSize:int;
		
		
		/**
		 * The size, in pixels, of the header. Used for sizing
		 * the header UI controls.
		 */
		protected var headerSize:int;
		
		/**
		 * The size, in pixels, of a typical UI control.
		 */
		protected var toggleControlSize:int;
		 
		/**
		 * The size, in pixels, of smaller UI controls.
		 */
		protected var smallControlSize:int;

		/**
		 * 
		 * @default 
		 */
		protected var popUpFillSize:int;

		/**
		 * 
		 * @default 
		 */
		protected var calloutBackgroundMinSize:int;

		/**
		 * 
		 * @default 
		 */
		protected var scrollBarGutterSize:int;

		/**
		 * 
		 * @default 
		 */
		protected var actionElementFormat:ElementFormat;

		/**
		 * 
		 * @default 
		 */
		protected var actionUIElementFormat:ElementFormat;

		/**
		 * 
		 * @default 
		 */
		protected var adHocScaleReduction:Number;
		
		/**
		 * 
		 * @default 
		 */
		protected var controlTouchBoundaryScale:Number;

		/**
		 * 
		 * @default 
		 */
		protected var itemRendererMinSize:Number;
 
		protected var scale9ButtonInset:Number
		
		/**
		 * The FTE FontDescription used for text of a normal weight.
		 */
		protected var regularFontDescription:FontDescription;

		/**
		 * The FTE FontDescription used for text of a bold weight.
		 */
		protected var boldFontDescription:FontDescription;

		/**
		 * ScrollText uses TextField instead of FTE, so it has a separate TextFormat.
		 */
		protected var scrollTextTextFormat:TextFormat;

		/**
		 * ScrollText uses TextField instead of FTE, so it has a separate disabled TextFormat.
		 */
		protected var scrollTextDisabledTextFormat:TextFormat;

		
		
		/**
		 * An ElementFormat used for Header components.
		 */
		protected var headerElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat used for Header components.
		 */
		protected var headerElementFormatBold:ElementFormat;
		
		/**
		 * An ElementFormat used for Header components.
		 */
		protected var itemRendererLabelFormatDark:ElementFormat;
		
		/**
		 * An ElementFormat used for Header components.
		 */
		protected var itemRendererLabelFormatLight:ElementFormat;

		/**
		 * 
		 * @default 
		 */
		protected var headerElementFormatDark:ElementFormat;

		/**
		 * An ElementFormat with a dark tint meant for UI controls.
		 */
		protected var darkUIElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a light tint meant for UI controls.
		 */
		protected var lightUIElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a highlighted tint meant for selected UI controls.
		 */
		protected var selectedUIElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a light tint meant for disabled UI controls.
		 */
		protected var lightUIDisabledElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a dark tint meant for disabled UI controls.
		 */
		protected var darkUIDisabledElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a dark tint meant for larger UI controls.
		 */
		protected var largeUIDarkElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a light tint meant for larger UI controls.
		 */
		protected var largeUILightElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a highlighted tint meant for larger UI controls.
		 */
		protected var largeUISelectedElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a dark tint meant for larger disabled UI controls.
		 */
		protected var largeUIDarkDisabledElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a light tint meant for larger disabled UI controls.
		 */
		protected var largeUILightDisabledElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a dark tint meant for larger text.
		 */
		protected var largeDarkElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a light tint meant for larger text.
		 */
		protected var largeLightElementFormat:ElementFormat;

		/**
		 * An ElementFormat meant for larger disabled text.
		 */
		protected var largeDisabledElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a dark tint meant for regular text.
		 */
		protected var darkElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a light tint meant for regular text.
		 */
		protected var lightElementFormat:ElementFormat;

		/**
		 * An ElementFormat meant for regular, disabled text.
		 */
		protected var disabledElementFormat:ElementFormat;

		/**
		 * An ElementFormat with a light tint meant for smaller text.
		 */
		protected var smallLightElementFormat:ElementFormat;

		/**
		 * An ElementFormat meant for smaller, disabled text.
		 */
		protected var smallDisabledElementFormat:ElementFormat;

		/**
		 * 
		 * @default 
		 */
		protected var smallDarkElementFormat:ElementFormat;

		/**
		 * The texture atlas that contains skins for this theme. This base class
		 * does not initialize this member variable. Subclasses are expected to
		 * load the assets somehow and set the <code>atlas</code> member
		 * variable before calling <code>initialize()</code>.
		 */
		protected var themeAtlas:TextureAtlas;
		
		
		/**
		 * The texture atlas that contains icons for this theme. This base class
		 * does not initialize this member variable. Subclasses are expected to
		 * load the assets somehow and set the <code>atlas</code> member
		 * variable before calling <code>initialize()</code>.
		 */
		protected var themeIconAtlas:TextureAtlas;

		// FROM NEW THEME
		/**
		 * 
		 * @default 
		 */
		protected var buttonRedLightUpSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonRedLightDownSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var tabDownDisabledSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var bg_null:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var bg_popup:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var btn_blue_second:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var skin_text_input:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var skin_text_input_focus:Scale9Textures;
		
		/**
		 * 
		 * @default 
		 */
		protected var skin_text_input_semi:Scale9Textures;
		
		/**
		 * 
		 * @default 
		 */
		protected var skin_text_input_focus_semi:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var btn_check_off:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var btn_check_on:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var btn_check_dis_on:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var btn_check_dis_off:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var btn_radio_off:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var btn_radio_on:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var btn_radio_dis:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var btn_radio_off_dis:Scale9Textures;

		// ORIGINAL MOBILE WORKS
		/**
		 * 
		 * @default 
		 */
		protected var headerBackgroundSkinTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var backgroundSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var backgroundInsetSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var backgroundDisabledSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var backgroundFocusedSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonUpSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonDownSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonDisabledSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonSelectedUpSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonSelectedDisabledSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonCallToActionUpSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonCallToActionDownSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonDangerUpSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonDangerDownSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonBackUpSkinTextures:Scale3Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonBackDownSkinTextures:Scale3Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonBackDisabledSkinTextures:Scale3Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonForwardUpSkinTextures:Scale3Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonForwardDownSkinTextures:Scale3Textures;

		/**
		 * 
		 * @default 
		 */
		protected var buttonForwardDisabledSkinTextures:Scale3Textures;

		/**
		 * 
		 * @default 
		 */
		protected var pickerListButtonIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var pickerListButtonIconDisabledTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var tabDownSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var tabSelectedSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var tabSelectedDisabledSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var pickerListItemSelectedIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var radioUpIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var radioDownIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var radioDisabledIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var radioSelectedUpIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var radioSelectedDownIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var radioSelectedDisabledIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var checkUpIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var checkDownIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var checkDisabledIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var checkSelectedUpIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var checkSelectedDownIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var checkSelectedDisabledIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var pageIndicatorNormalSkinTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var pageIndicatorSelectedSkinTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var itemRendererUpSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var itemRendererSelectedSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var insetItemRendererFirstUpSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var insetItemRendererFirstSelectedSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var insetItemRendererLastUpSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var insetItemRendererLastSelectedSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var insetItemRendererSingleUpSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var insetItemRendererSingleSelectedSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var backgroundPopUpSkinTextures:Scale9Textures;

		/**
		 * 
		 * @default 
		 */
		protected var calloutTopArrowSkinTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var calloutRightArrowSkinTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var calloutBottomArrowSkinTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var calloutLeftArrowSkinTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var verticalScrollBarThumbSkinTextures:Scale3Textures;

		/**
		 * 
		 * @default 
		 */
		protected var horizontalScrollBarThumbSkinTextures:Scale3Textures;

		/**
		 * 
		 * @default 
		 */
		protected var searchIconTexture:Texture;

		/**
		 * 
		 * @default 
		 */
		protected var searchIconDisabledTexture:Texture;

		/**
		 * Disposes the atlas before calling super.dispose()
		 */
		override public function dispose():void {

			if ( this.themeAtlas ) {
				this.themeAtlas.dispose();
				this.themeAtlas = null;
			}
			
			if ( this.themeIconAtlas ) {
				this.themeIconAtlas.dispose();
				this.themeIconAtlas = null;
			}

			
			//don't forget to call super.dispose()!
			super.dispose();
		}

		/**
		 * Initializes the theme. Expected to be called by subclasses after the
		 * assets have been loaded and the skin texture atlas has been created.
		 */
		override public function initialize():void {

			if ( !_isPreinitialized )
				throw new Error( "BaseFlatTheme has not been preinitialized." );

			// Set atlas prefix
			trace("Atlas suffix" + fmgr.theme.atlasScaleSuffix);
			trace("Atalas theme" + baseAtlasName);
			//metal-works-mobile  is default
			baseAtlasName += fmgr.theme.atlasScaleSuffix;
			customAtlasName += fmgr.theme.atlasScaleSuffix;
			
			// Separating main theme assets and icons into separate atlases for maintenance
			this.themeAtlas = fmgr.theme.assetManager.getTextureAtlas( baseAtlasName );

			if ( !this.themeAtlas )
				throw new Error( "Theme Atlas was not found or initialized." );
			
			this.themeIconAtlas = fmgr.theme.assetManager.getTextureAtlas( customAtlasName );
			
			if ( !this.themeIconAtlas )
				throw new Error( "Icon Atlas was not found or initialized." );

			this.initializeScale();
			this.initializeDimensions();
			this.initializeFonts();
			this.initializeTextures();
			this.initializeGlobals();
			this.initializeStage();
			this.initializeStyleProviders();
			this.initializeObjectPools();

		}
 

		/**
		 * Initializes the theme colors. Expected to be called by subclasses after the
		 * assets have been loaded and the skin texture atlas has been created.
		 */
		override public function preinitializeThemeParams():void {
 
			//metal-works-mobile  is default
			baseAtlasName = this.themeProperties.ATLAS_BASE_TEXTURES;
			customAtlasName = this.themeProperties.ATLAS_CUSTOM_TEXTURES;
			
			THEME_NAME_PICKER_LIST_ITEM_RENDERER = baseAtlasName + "-picker-list-item-renderer";
			THEME_NAME_ALERT_BUTTON_GROUP_BUTTON = baseAtlasName + "-alert-button-group-button";

			THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB = baseAtlasName + "-horizontal-simple-scroll-bar-thumb";
			THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB = baseAtlasName + "-vertical-simple-scroll-bar-thumb";

			THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK = baseAtlasName + "-horizontal-slider-minimum-track";
			THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK = baseAtlasName + "-horizontal-slider-maximum-track";

			THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK = baseAtlasName + "-vertical-slider-minimum-track";
			THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK = baseAtlasName + "-vertical-slider-maximum-track";
 

			// THEME COLORS
			ITEM_RENDERER_BACKGROUND_COLOR= getThemePropertyValue(this.themeProperties.ITEM_RENDERER_BACKGROUND_COLOR);
			ITEM_RENDERER_LABEL_COLOR_DARK = getThemePropertyValue(this.themeProperties.ITEM_RENDERER_LABEL_COLOR_DARK);
			ITEM_RENDERER_LABEL_COLOR_LIGHT = getThemePropertyValue(this.themeProperties.ITEM_RENDERER_LABEL_COLOR_LIGHT);
			PRIMARY_BACKGROUND_COLOR = getThemePropertyValue(this.themeProperties.PRIMARY_BACKGROUND_COLOR);
			LIGHT_TEXT_COLOR = getThemePropertyValue(this.themeProperties.LIGHT_TEXT_COLOR); 
			SELECTED_TEXT_COLOR = getThemePropertyValue(this.themeProperties.SELECTED_TEXT_COLOR);
			DISABLED_TEXT_COLOR = getThemePropertyValue(this.themeProperties.DISABLED_TEXT_COLOR);
			DARK_TEXT_COLOR = getThemePropertyValue(this.themeProperties.DARK_TEXT_COLOR);
			DARK_DISABLED_TEXT_COLOR = getThemePropertyValue(this.themeProperties.DARK_DISABLED_TEXT_COLOR);
			LIST_BACKGROUND_COLOR = getThemePropertyValue(this.themeProperties.LIST_BACKGROUND_COLOR);
			TAB_DISABLED_BACKGROUND_COLOR = getThemePropertyValue(this.themeProperties.TAB_DISABLED_BACKGROUND_COLOR);
			GROUPED_LIST_HEADER_BACKGROUND_COLOR = getThemePropertyValue(this.themeProperties.GROUPED_LIST_HEADER_BACKGROUND_COLOR);
			GROUPED_LIST_FOOTER_BACKGROUND_COLOR = getThemePropertyValue(this.themeProperties.GROUPED_LIST_FOOTER_BACKGROUND_COLOR);
			MODAL_OVERLAY_COLOR = getThemePropertyValue(this.themeProperties.MODAL_OVERLAY_COLOR);
			MODAL_OVERLAY_ALPHA = getThemePropertyValue(this.themeProperties.MODAL_OVERLAY_ALPHA);

			// THEME FONTS
			FONT_NAME = this.themeProperties.FONT_NAME;
			FONT_NAME_BOLD = this.themeProperties.FONT_NAME_BOLD;
			FONT_NAME_REGULAR = this.themeProperties.FONT_NAME_REGULAR;
			FONT_SIZE_SMALL = this.themeProperties.FONT_SIZE_SMALL;
			FONT_SIZE_NORMAL = this.themeProperties.FONT_SIZE_NORMAL;
			FONT_SIZE_MEDIUM = this.themeProperties.FONT_SIZE_MEDIUM;
			FONT_SIZE_LARGE = this.themeProperties.FONT_SIZE_LARGE;
			FONT_SIZE_XLARGE = this.themeProperties.FONT_SIZE_XLARGE;
			
			// NOTE: Dimensions will be set from theme properties later during the initialization
			
			 
		}

		/**
		 * Ahhenderson: Set's object pools up
		 */
		protected function initializeObjectPools():void {

			BaseFlatThemePoolFunctions.initializeDimensions(this.themeProperties, this.scale);
			
			ObjectPoolManager.instance.createPool( FeathersComponentPoolType.BUTTON, BaseFlatThemePoolFunctions.resetButtonObject, 10 ); 
			ObjectPoolManager.instance.createPool( FeathersComponentPoolType.TEXT_INPUT, BaseFlatThemePoolFunctions.resetTextInputObject, 6 ); 
			ObjectPoolManager.instance.createPool( FeathersComponentPoolType.LABEL, BaseFlatThemePoolFunctions.resetLabelObject, 10 );
			ObjectPoolManager.instance.createPool( FeathersComponentPoolType.IMAGE_LOADER, BaseFlatThemePoolFunctions.resetImageLoaderObject, 10 ); 
			ObjectPoolManager.instance.createPool( FeathersComponentPoolType.PICKER_LIST, BaseFlatThemePoolFunctions.resetPickerListObject, 5 );
			ObjectPoolManager.instance.createPool( FeathersComponentPoolType.SPINNER_LIST, BaseFlatThemePoolFunctions.resetSpinnerListObject, 5 );
			ObjectPoolManager.instance.createPool( FeathersComponentPoolType.SCREEN_NAVIGATOR, null, 2);
			ObjectPoolManager.instance.createPool( FeathersComponentPoolType.HEADER, null, 2);
		}

		/**
		 * Sets the stage background color.
		 */
		protected function initializeStage():void {

			Starling.current.stage.color = PRIMARY_BACKGROUND_COLOR;
			Starling.current.nativeStage.color = PRIMARY_BACKGROUND_COLOR;
		}

		/**
		 * Initializes global variables (not including global style providers).
		 */
		protected function initializeGlobals():void {

			FeathersControl.defaultTextRendererFactory = textRendererFactory;
			FeathersControl.defaultTextEditorFactory = textEditorFactory;

			PopUpManager.overlayFactory = popUpOverlayFactory;
			Callout.stagePadding = this.smallGutterSize;
		}

		/**
		 * Initializes the scale value based on the screen density and content
		 * scale factor.
		 */
		protected function initializeScale():void {

			var scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
			this._originalDPI = scaledDPI;

			if ( this._scaleToDPI ) {
				if ( DeviceCapabilities.isTablet( Starling.current.nativeStage )) {
					this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				} else {
					this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
				}
			}

			// NOTE: Handled automatically be theme
			//this.scale = _fmgr.theme.scaledResolution; //SystemModel.appDpiScale; //2; 
			//this.scale = scaledDPI / this._originalDPI;
		}

		/**
		 * Initializes scaling grids for appropriate resoluations
		 */
		protected function initializeScalingGrids():void{
			 
			var defBtnInset:Number = roundToNearest(this.scale9ButtonInset/this.scale);
			var defPanelGutter:Number = defBtnInset;
			var defCtrlSize:Number = roundToNearest(this.controlSize/this.scale);
			var defPopUpFillSize:Number = roundToNearest(this.popUpFillSize/this.scale);
			var alteredScale:Number = 1
				
			SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID = DrawingUtils.getScaledRectangle(alteredScale, defBtnInset, defBtnInset, defCtrlSize, defCtrlSize);
			 
			DEFAULT_SCALE9_GRID = DrawingUtils.getScaledRectangle(this.scale, 5, 5, defPanelGutter, defPanelGutter );
			 
			POPUP_SCALE9_GRID = DrawingUtils.getScaledRectangle(alteredScale, defPanelGutter, defPanelGutter, defPopUpFillSize, defPopUpFillSize );
			 
			BUTTON_SCALE9_GRID = DrawingUtils.getScaledRectangle(alteredScale, defBtnInset, defBtnInset, defCtrlSize, defCtrlSize);
			 
			BUTTON_SELECTED_SCALE9_GRID = BUTTON_SCALE9_GRID;
			 
			BACK_BUTTON_SCALE3_REGION1 = 64;
			 
			BACK_BUTTON_SCALE3_REGION2 = 94;
			 
			FORWARD_BUTTON_SCALE3_REGION1 = 8;
			 
			FORWARD_BUTTON_SCALE3_REGION2 = 102;
			 
			ITEM_RENDERER_SCALE9_GRID = DrawingUtils.getScaledRectangle(alteredScale, defBtnInset, defBtnInset, 546, this.controlSize );
			 
			INSET_ITEM_RENDERER_FIRST_SCALE9_GRID = DrawingUtils.getScaledRectangle(this.scale, 13, 13, 3, 70 );
			 
			INSET_ITEM_RENDERER_LAST_SCALE9_GRID = DrawingUtils.getScaledRectangle(this.scale, 13, 0, 3, 75 );
			 
			INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID = DrawingUtils.getScaledRectangle(this.scale, 13, 13, 3, 62 );
			 
			TAB_SCALE9_GRID = DrawingUtils.getScaledRectangle(this.scale, 16, 16, 56, 30 );
			 
			SCROLL_BAR_THUMB_REGION1 = 10;
			 
			SCROLL_BAR_THUMB_REGION2 = 28;
		}
		/**
		 * Initializes common values used for setting the dimensions of components.
		 */
		protected function initializeDimensions():void {

			//***************************************
			// Theme Dimensions
			//***************************************
			
			
			
			// THEME PADDINGS 
			buttonPaddingTop = getThemePropertyValue(Math.round(this.themeProperties.BUTTON_PADDING_TOP * this.scale ), Math.round( 4 * this.scale ));
			buttonPaddingBottom = getThemePropertyValue(Math.round(this.themeProperties.BUTTON_PADDING_BOTTOM * this.scale ), Math.round( 4 * this.scale ));
			buttonPaddingRight = getThemePropertyValue(Math.round(this.themeProperties.BUTTON_PADDING_RIGHT * this.scale ), Math.round( 8 * this.scale ));
			buttonPaddingLeft = getThemePropertyValue(Math.round(this.themeProperties.BUTTON_PADDING_LEFT * this.scale ), Math.round( 8 * this.scale ));
			
			itemPaddingTop = getThemePropertyValue(Math.round(this.themeProperties.ITEM_PADDING_TOP * this.scale ));
			itemPaddingBottom = getThemePropertyValue(Math.round(this.themeProperties.ITEM_PADDING_BOTTOM * this.scale ));
			
			
			// Gutters
			this.xSmallGutterSize = getThemePropertyValue(Math.round(this.themeProperties.XSMALL_GUTTER_SIZE * this.scale ), Math.round( 8 * this.scale ));
			this.smallGutterSize = getThemePropertyValue(Math.round(this.themeProperties.SMALL_GUTTER_SIZE * this.scale ), Math.round( 12 * this.scale ));
			this.gutterSize = getThemePropertyValue(Math.round(this.themeProperties.GUTTER_SIZE * this.scale ), Math.round( 20 * this.scale ));
			this.largeGutterSize = getThemePropertyValue(Math.round(this.themeProperties.LARGE_GUTTER_SIZE * this.scale ), Math.round( 28 * this.scale ));
			this.scrollBarGutterSize = getThemePropertyValue(Math.round(this.themeProperties.SCROLLBAR_GUTTER_SIZE * this.scale ), Math.round( 4 * this.scale ));
			
			this.xSmallGutterSize = getThemePropertyValue(Math.round(this.themeProperties.XSMALL_GUTTER_SIZE * this.scale ), Math.round( 8 * this.scale ));
			this.smallGutterSize = getThemePropertyValue(Math.round(this.themeProperties.SMALL_GUTTER_SIZE * this.scale ), Math.round( 12 * this.scale ));
			this.gutterSize = getThemePropertyValue(Math.round(this.themeProperties.GUTTER_SIZE * this.scale ), Math.round( 20 * this.scale ));
			this.largeGutterSize = getThemePropertyValue(Math.round(this.themeProperties.LARGE_GUTTER_SIZE * this.scale ), Math.round( 28 * this.scale ));
			this.scrollBarGutterSize = getThemePropertyValue(Math.round(this.themeProperties.SCROLLBAR_GUTTER_SIZE * this.scale ), Math.round( 4 * this.scale ));
			
			// Controls/Containers
			this.gridSize = getThemePropertyValue(Math.round(this.themeProperties.GRID_SIZE * this.scale ), Math.round( 88 * this.scale ));
			this.headerSize = getThemePropertyValue(Math.round(this.themeProperties.HEADER_SIZE * this.scale ), Math.round( 66 * this.scale ));
			
			this.toggleControlSize = getThemePropertyValue(Math.round(this.themeProperties.TOGGLE_CONTROL_SIZE * this.scale ), Math.round( 60 * this.scale ));
			this.controlSize = getThemePropertyValue(Math.round(this.themeProperties.CONTROL_SIZE * this.scale ), Math.round( 60 * this.scale ));
			this.smallControlSize = getThemePropertyValue(Math.round(this.themeProperties.SMALL_CONTROL_SIZE * this.scale ), Math.round( 20 * this.scale ));
			this.popUpFillSize = getThemePropertyValue(Math.round(this.themeProperties.POPUP_FILL_SIZE * this.scale ), Math.round( 552 * this.scale ));
			this.calloutBackgroundMinSize = getThemePropertyValue(Math.round(this.themeProperties.CALLOUT_BACKGROUND_MIN_SIZE * this.scale ), Math.round( 50 * this.scale ));
			this.wideControlSize = getThemePropertyValue(Math.round(this.themeProperties.WIDE_CONTROL_SIZE * this.scale ), this.gridSize * 3 + this.gutterSize * 2);
			this.itemRendererMinSize = getThemePropertyValue(Math.round(this.themeProperties.ITEM_RENDERER_SIZE * this.scale ), Math.round( 70 * this.scale ));
			this.scale9ButtonInset = getThemePropertyValue(Math.round(this.themeProperties.SCALE_9_BUTTON_INSET * this.scale ));
			
			// Other
			this.adHocScaleReduction = getThemePropertyValue(this.themeProperties.ADHOC_REDUCTION_SIZE, 0.7);  
			this.controlTouchBoundaryScale = getThemePropertyValue(this.themeProperties.CONTROL_TOUCH_BOUNDRY_SCALE, 1.25);  
			 
			// Initialize scaling grids for resolution scale first.
			initializeScalingGrids();
		}

		/**
		 * Initializes font sizes and formats.
		 */
		protected function initializeFonts():void {

			this.smallFontSize = Math.round( FONT_SIZE_SMALL * this.scale );
			this.regularFontSize = Math.round( FONT_SIZE_NORMAL * this.scale );
			this.mediumFontSize = Math.round( FONT_SIZE_MEDIUM * this.scale );
			this.largeFontSize = Math.round( FONT_SIZE_LARGE * this.scale );
			this.extraLargeFontSize = Math.round( FONT_SIZE_XLARGE * this.scale );

			//these are for components that don't use FTE
			this.scrollTextTextFormat = new TextFormat( "_sans", this.regularFontSize, LIGHT_TEXT_COLOR );
			this.scrollTextDisabledTextFormat = new TextFormat( "_sans", this.regularFontSize, DISABLED_TEXT_COLOR );

			this.regularFontDescription =
				new FontDescription( FONT_NAME_REGULAR,
									 FontWeight.NORMAL,
									 FontPosture.NORMAL,
									 FontLookup.EMBEDDED_CFF,
									 RenderingMode.CFF,
									 CFFHinting.NONE );
			this.boldFontDescription =
				new FontDescription( FONT_NAME_BOLD,
									 FontWeight.BOLD,
									 FontPosture.NORMAL,
									 FontLookup.EMBEDDED_CFF,
									 RenderingMode.CFF,
									 CFFHinting.NONE );
 
			this.itemRendererLabelFormatDark = new ElementFormat( this.regularFontDescription, this.mediumFontSize, ITEM_RENDERER_LABEL_COLOR_DARK );
			this.itemRendererLabelFormatLight = new ElementFormat( this.regularFontDescription, this.mediumFontSize, ITEM_RENDERER_LABEL_COLOR_LIGHT );
			this.headerElementFormatBold = new ElementFormat( this.boldFontDescription, this.extraLargeFontSize, LIGHT_TEXT_COLOR );
			this.headerElementFormat = new ElementFormat( this.regularFontDescription, this.extraLargeFontSize, LIGHT_TEXT_COLOR );
			this.headerElementFormatDark = new ElementFormat( this.regularFontDescription, this.extraLargeFontSize, DARK_TEXT_COLOR );

			this.darkUIElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, DARK_TEXT_COLOR );
			this.lightUIElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, LIGHT_TEXT_COLOR );
			this.selectedUIElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, SELECTED_TEXT_COLOR );
			this.lightUIDisabledElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, DISABLED_TEXT_COLOR );
			this.darkUIDisabledElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, DARK_DISABLED_TEXT_COLOR );

			this.actionElementFormat = new ElementFormat( this.regularFontDescription, smallFontSize, ACTION_COLOR );
			this.actionUIElementFormat = new ElementFormat( this.regularFontDescription, smallFontSize, ACTION_COLOR );

			this.largeUIDarkElementFormat = new ElementFormat( this.regularFontDescription, this.mediumFontSize, DARK_TEXT_COLOR );
			this.largeUILightElementFormat = new ElementFormat( this.regularFontDescription, this.mediumFontSize, LIGHT_TEXT_COLOR );
			this.largeUISelectedElementFormat = new ElementFormat( this.regularFontDescription, this.mediumFontSize, SELECTED_TEXT_COLOR );
			this.largeUIDarkDisabledElementFormat =
				new ElementFormat( this.boldFontDescription, this.largeFontSize, DARK_DISABLED_TEXT_COLOR );
			this.largeUILightDisabledElementFormat = new ElementFormat( this.regularFontDescription, this.largeFontSize, DISABLED_TEXT_COLOR );

			this.darkElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, DARK_TEXT_COLOR );
			this.lightElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, LIGHT_TEXT_COLOR );
			this.disabledElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, DISABLED_TEXT_COLOR );

			this.smallLightElementFormat = new ElementFormat( this.regularFontDescription, this.smallFontSize, LIGHT_TEXT_COLOR );
			this.smallDarkElementFormat = new ElementFormat( this.regularFontDescription, this.smallFontSize, DARK_TEXT_COLOR );
			this.smallDisabledElementFormat = new ElementFormat( this.regularFontDescription, this.smallFontSize, DISABLED_TEXT_COLOR );

			this.largeDarkElementFormat = new ElementFormat( this.regularFontDescription, this.mediumFontSize, DARK_TEXT_COLOR );
			this.largeLightElementFormat = new ElementFormat( this.regularFontDescription, this.mediumFontSize, LIGHT_TEXT_COLOR );
			this.largeDisabledElementFormat = new ElementFormat( this.regularFontDescription, this.mediumFontSize, DISABLED_TEXT_COLOR );
		}

		/**
		 * Initializes the textures by extracting them from the atlas and
		 * setting up any scaling grids that are needed.
		 */
		protected function initializeTextures():void {

			var text1:Texture = fmgr.theme.assetManager.getTexture( "textinput-semi-trans-up" )
				
			// Custom
			this.skin_text_input_semi = new Scale9Textures( fmgr.theme.assetManager.getTexture( "textinput-semi-trans-up" ), BUTTON_SCALE9_GRID );
			this.skin_text_input_focus_semi = new Scale9Textures( fmgr.theme.assetManager.getTexture( "textinput-semi-trans-focus" ), BUTTON_SCALE9_GRID ); 
			
			// From theme
			var rect_bg:Rectangle = DrawingUtils.getScaledRectangle(this.scale,8, 8, 70, 10);
			bg_null = new Scale9Textures(fmgr.theme.assetManager.getTexture("null_bg"), new Rectangle(0,0,1,1)); 
			bg_popup = new Scale9Textures(fmgr.theme.assetManager.getTexture("background-popup-skin"), POPUP_SCALE9_GRID); 
			skin_text_input = new Scale9Textures(fmgr.theme.assetManager.getTexture("textinput-up"), BUTTON_SCALE9_GRID);
			skin_text_input_focus = new Scale9Textures(fmgr.theme.assetManager.getTexture("textinput-focus"), BUTTON_SCALE9_GRID);
			btn_blue_second = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-blue-second"), BUTTON_SCALE9_GRID);
			
			this.buttonRedLightUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-redlight-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonRedLightDownSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-redlight-down-skin"), BUTTON_SCALE9_GRID);
			
			this.buttonUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonDownSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonDisabledSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-disabled-skin"), BUTTON_SCALE9_GRID);
			this.buttonSelectedUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-selected-up-skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonSelectedDisabledSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-selected-disabled-skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonCallToActionUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-call-to-action-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonCallToActionDownSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-call-to-action-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonDangerUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-danger-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonDangerDownSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("button-danger-down-skin"), BUTTON_SCALE9_GRID);
			
			// Disabled for size contraints
			/*this.buttonBackUpSkinTextures = new Scale3Textures(fmgr.theme.assetManager.getTexture("button-back-up-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonBackDownSkinTextures = new Scale3Textures(fmgr.theme.assetManager.getTexture("button-back-down-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonBackDisabledSkinTextures = new Scale3Textures(fmgr.theme.assetManager.getTexture("button-back-disabled-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonForwardUpSkinTextures = new Scale3Textures(fmgr.theme.assetManager.getTexture("button-forward-up-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonForwardDownSkinTextures = new Scale3Textures(fmgr.theme.assetManager.getTexture("button-forward-down-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonForwardDisabledSkinTextures = new Scale3Textures(fmgr.theme.assetManager.getTexture("button-forward-disabled-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			*/
			this.tabDownSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("tab-down-skin"), TAB_SCALE9_GRID);
			this.tabDownDisabledSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("tab-down-disabled"), TAB_SCALE9_GRID);
			
			this.tabSelectedSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("tab-selected-skin"), TAB_SCALE9_GRID);
			this.tabSelectedDisabledSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("tab-selected-disabled-skin"), TAB_SCALE9_GRID);
			
			
			this.pickerListButtonIconTexture = fmgr.theme.assetManager.getTexture(FlatThemeCustomTextures.ICONS_CONTROL_DROPDOWN_ARROW_DOWN);
			this.pickerListButtonIconDisabledTexture = fmgr.theme.assetManager.getTexture("picker-list-icon-disabled");
			this.pickerListItemSelectedIconTexture = fmgr.theme.assetManager.getTexture("picker-list-item-selected-icon");
			
			this.pageIndicatorSelectedSkinTexture = fmgr.theme.assetManager.getTexture("page-indicator-selected-skin");
			this.pageIndicatorNormalSkinTexture = fmgr.theme.assetManager.getTexture("page-indicator-normal-skin");
			
			
			this.searchIconTexture = fmgr.theme.assetManager.getTexture(FlatThemeCustomTextures.ICONS_BUTTON_SEARCH);
			this.searchIconDisabledTexture = fmgr.theme.assetManager.getTexture(FlatThemeCustomTextures.ICONS_BUTTON_SEARCH);
			
			this.itemRendererUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("list-item-up-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.itemRendererSelectedSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("list-item-selected-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.insetItemRendererFirstUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("list-inset-item-first-up-skin"), INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
			this.insetItemRendererFirstSelectedSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("list-inset-item-first-selected-skin"), INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
			this.insetItemRendererLastUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("list-inset-item-last-up-skin"), INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
			this.insetItemRendererLastSelectedSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("list-inset-item-last-selected-skin"), INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
			this.insetItemRendererSingleUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("list-inset-item-single-up-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
			this.insetItemRendererSingleSelectedSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("list-inset-item-single-selected-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
			
			this.headerBackgroundSkinTexture = fmgr.theme.assetManager.getTexture("header-background-skin");
			
			this.calloutTopArrowSkinTexture = fmgr.theme.assetManager.getTexture("callout-arrow-top-skin");
			this.calloutRightArrowSkinTexture = fmgr.theme.assetManager.getTexture("callout-arrow-right-skin");
			this.calloutBottomArrowSkinTexture = fmgr.theme.assetManager.getTexture("callout-arrow-bottom-skin");
			this.calloutLeftArrowSkinTexture = fmgr.theme.assetManager.getTexture("callout-arrow-left-skin");
			
			this.horizontalScrollBarThumbSkinTextures = new Scale3Textures(fmgr.theme.assetManager.getTexture("horizontal-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_HORIZONTAL);
			this.verticalScrollBarThumbSkinTextures = new Scale3Textures(fmgr.theme.assetManager.getTexture("vertical-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_VERTICAL);
			
			this.spinnerListSelectionOverlaySkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture("textinput-focus"), SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID);
			
			StandardIcons.listDrillDownAccessoryTexture = fmgr.theme.assetManager.getTexture("list-accessory-drill-down-icon");
		}

		/**
		 * Sets global style providers for all components.
		 */
		protected function initializeStyleProviders():void {

			
			//alert
			this.getStyleProviderForClass( Alert ).defaultStyleFunction = this.setAlertStyles;
			this.getStyleProviderForClass( ButtonGroup ).setFunctionForStyleName( Alert.DEFAULT_CHILD_STYLE_NAME_BUTTON_GROUP,
																				  this.setAlertButtonGroupStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( THEME_NAME_ALERT_BUTTON_GROUP_BUTTON,
																			 this.setAlertButtonGroupButtonStyles );
			this.getStyleProviderForClass( Header ).setFunctionForStyleName( Alert.DEFAULT_CHILD_STYLE_NAME_HEADER,
																			 this.setAlertHeaderWithoutBackgroundStyles );
			this.getStyleProviderForClass( TextBlockTextRenderer ).setFunctionForStyleName( Alert.DEFAULT_CHILD_STYLE_NAME_MESSAGE,
																							this.setAlertMessageTextRendererStyles );

			
			//button
			this.getStyleProviderForClass( Button ).defaultStyleFunction = this.setButtonStyles;
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON,
																			 this.setCallToActionButtonStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON, this.setQuietButtonStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON,
																			 this.setDangerButtonStyles );
		/*	this.getStyleProviderForClass( Button ).setFunctionForStyleName( Button.ALTERNATE_NAME_BACK_BUTTON, this.setBackButtonStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( Button.ALTERNATE_NAME_FORWARD_BUTTON,
																			 this.setForwardButtonStyles );
*/
			
			//button group
			this.getStyleProviderForClass( ButtonGroup ).defaultStyleFunction = this.setButtonGroupStyles;
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( ButtonGroup.DEFAULT_CHILD_STYLE_NAME_BUTTON,
																			 this.setButtonGroupButtonStyles );

			
			//callout
			this.getStyleProviderForClass( Callout ).defaultStyleFunction = this.setCalloutStyles;

			
			//check
			this.getStyleProviderForClass( Check ).defaultStyleFunction = this.setCheckStyles;

			//drawers
			this.getStyleProviderForClass( Drawers ).defaultStyleFunction = this.setDrawersStyles;

			
			//grouped list (see also: item renderers)
			this.getStyleProviderForClass( GroupedList ).defaultStyleFunction = this.setGroupedListStyles;
			this.getStyleProviderForClass( GroupedList ).setFunctionForStyleName( GroupedList.ALTERNATE_STYLE_NAME_INSET_GROUPED_LIST,
																				  this.setInsetGroupedListStyles );

			
			//header
			this.getStyleProviderForClass( Header ).defaultStyleFunction = this.setHeaderStyles;
			this.getStyleProviderForClass(Header).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.HEADER_TRANSPARENT,
				this.setHeaderWithoutBackgroundStyles);
			
			//header and footer renderers for grouped list
			this.getStyleProviderForClass( DefaultGroupedListHeaderOrFooterRenderer ).defaultStyleFunction =
				this.setGroupedListHeaderRendererStyles;
			this.getStyleProviderForClass( DefaultGroupedListHeaderOrFooterRenderer ).setFunctionForStyleName( GroupedList.DEFAULT_CHILD_STYLE_NAME_FOOTER_RENDERER,
																											   this.setGroupedListFooterRendererStyles );
			this.getStyleProviderForClass( DefaultGroupedListHeaderOrFooterRenderer ).setFunctionForStyleName( GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_HEADER_RENDERER,
																											   this.setInsetGroupedListHeaderRendererStyles );
			this.getStyleProviderForClass( DefaultGroupedListHeaderOrFooterRenderer ).setFunctionForStyleName( GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FOOTER_RENDERER,
																											   this.setInsetGroupedListFooterRendererStyles );

			
			//item renderers for lists
			this.getStyleProviderForClass( DefaultListItemRenderer ).defaultStyleFunction = this.setItemRendererStyles;
			this.getStyleProviderForClass( DefaultListItemRenderer ).setFunctionForStyleName(FeathersExtLib_StyleNameConstants.LIST_ITEM_RENDERER__TRANSPARENT_BACKGROUND, this.setItemRendererNoBackgroundStyles);
			this.getStyleProviderForClass( DefaultGroupedListItemRenderer ).defaultStyleFunction = this.setItemRendererStyles;

			
			//the picker list has a custom item renderer name defined by the theme
			this.getStyleProviderForClass( DefaultListItemRenderer ).setFunctionForStyleName( THEME_NAME_PICKER_LIST_ITEM_RENDERER,
																							  this.setPickerListItemRendererStyles );
			this.getStyleProviderForClass( TextBlockTextRenderer ).setFunctionForStyleName( BaseDefaultItemRenderer.DEFAULT_CHILD_STYLE_NAME_ACCESSORY_LABEL,
																							this.setItemRendererAccessoryLabelRendererStyles );
			this.getStyleProviderForClass( TextBlockTextRenderer ).setFunctionForStyleName( BaseDefaultItemRenderer.DEFAULT_CHILD_STYLE_NAME_ICON_LABEL,
																							this.setItemRendererIconLabelStyles );

			this.getStyleProviderForClass( DefaultGroupedListItemRenderer ).setFunctionForStyleName( GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_ITEM_RENDERER,
																									 this.setInsetGroupedListMiddleItemRendererStyles );
			this.getStyleProviderForClass( DefaultGroupedListItemRenderer ).setFunctionForStyleName( GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FIRST_ITEM_RENDERER,
																									 this.setInsetGroupedListFirstItemRendererStyles );
			this.getStyleProviderForClass( DefaultGroupedListItemRenderer ).setFunctionForStyleName( GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_LAST_ITEM_RENDERER,
																									 this.setInsetGroupedListLastItemRendererStyles );
			this.getStyleProviderForClass( DefaultGroupedListItemRenderer ).setFunctionForStyleName( GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_SINGLE_ITEM_RENDERER,
																									 this.setInsetGroupedListSingleItemRendererStyles );

			//the spinner list has a custom item renderer name defined by the theme
			this.getStyleProviderForClass(DefaultListItemRenderer).setFunctionForStyleName(THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER, this.setSpinnerListItemRendererStyles);
			
			//labels
			this.getStyleProviderForClass( Label ).defaultStyleFunction = this.setLabelStyles;
			this.getStyleProviderForClass( Label ).setFunctionForStyleName( Label.ALTERNATE_STYLE_NAME_HEADING, this.setHeadingLabelStyles );
			this.getStyleProviderForClass( Label ).setFunctionForStyleName( Label.ALTERNATE_STYLE_NAME_DETAIL, this.setDetailLabelStyles );

			//list (see also: item renderers)
			this.getStyleProviderForClass( List ).defaultStyleFunction = this.setListStyles;
			this.getStyleProviderForClass( List ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.LIST__TRANSPARENT_BACKGROUND, this.setListStylesNoBackground );
			
			//numeric stepper
			this.getStyleProviderForClass( NumericStepper ).defaultStyleFunction = this.setNumericStepperStyles;
			  
			this.getStyleProviderForClass( TextInput ).setFunctionForStyleName( NumericStepper.DEFAULT_CHILD_STYLE_NAME_TEXT_INPUT,
																				this.setNumericStepperTextInputStyles );
			this.getStyleProviderForClass( TextInput ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.NUMERIC_STEPPER__CHILD_STYLE_NAME_TEXT_INPUT_NO_BACKGROUND,
				this.setNumericStepperTextInputStylesWithoutBackground );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( NumericStepper.DEFAULT_CHILD_STYLE_NAME_DECREMENT_BUTTON,
																			 this.setNumericStepperButtonStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( NumericStepper.DEFAULT_CHILD_STYLE_NAME_INCREMENT_BUTTON,
																			 this.setNumericStepperButtonStyles );

			 
			//page indicator
			this.getStyleProviderForClass( PageIndicator ).defaultStyleFunction = this.setPageIndicatorStyles;

			
			//panel
			this.getStyleProviderForClass( Panel ).defaultStyleFunction = this.setPanelStyles;
			this.getStyleProviderForClass( Header ).setFunctionForStyleName( Panel.DEFAULT_CHILD_STYLE_NAME_HEADER,
																			 this.setHeaderBoldFontStyles );

			 
			//panel screen
			this.getStyleProviderForClass( Header ).setFunctionForStyleName( PanelScreen.DEFAULT_CHILD_STYLE_NAME_HEADER,
																			 this.setPanelScreenHeaderStyles );

			
			//picker list (see also: list and item renderers)
			this.getStyleProviderForClass( PickerList ).defaultStyleFunction = this.setPickerListStyles;
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( PickerList.DEFAULT_CHILD_STYLE_NAME_BUTTON,
																			 this.setPickerListButtonStyles );

			
			//progress bar
			this.getStyleProviderForClass( ProgressBar ).defaultStyleFunction = this.setProgressBarStyles;

			
			//radio
			this.getStyleProviderForClass( Radio ).defaultStyleFunction = this.setRadioStyles;

			
			//scroll container
			this.getStyleProviderForClass( ScrollContainer ).defaultStyleFunction = this.setScrollContainerStyles;
			this.getStyleProviderForClass( ScrollContainer ).setFunctionForStyleName( ScrollContainer.ALTERNATE_STYLE_NAME_TOOLBAR,
																					  this.setToolbarScrollContainerStyles );

			
			//scroll text
			this.getStyleProviderForClass( ScrollText ).defaultStyleFunction = this.setScrollTextStyles;

			
			//simple scroll bar
			this.getStyleProviderForClass( SimpleScrollBar ).defaultStyleFunction = this.setSimpleScrollBarStyles;
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB,
																			 this.setHorizontalSimpleScrollBarThumbStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB,
																			 this.setVerticalSimpleScrollBarThumbStyles );

			
			//spinner list
			this.getStyleProviderForClass(SpinnerList).defaultStyleFunction = this.setSpinnerListStyles;
			
			//slider
			this.getStyleProviderForClass( Slider ).defaultStyleFunction = this.setSliderStyles;
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( Slider.DEFAULT_CHILD_STYLE_NAME_THUMB,
																			 this.setSimpleButtonInitializerRedLightSlider );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK,
																			 this.setHorizontalSliderMinimumTrackStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK,
																			 this.setHorizontalSliderMaximumTrackStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK,
																			 this.setVerticalSliderMinimumTrackStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK,
																			 this.setVerticalSliderMaximumTrackStyles );

			
			//tab bar
			this.getStyleProviderForClass( TabBar ).defaultStyleFunction = this.setTabBarStyles;
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( TabBar.DEFAULT_CHILD_STYLE_NAME_TAB, this.setTabStyles );

			
			//text input
			this.getStyleProviderForClass( TextInput ).defaultStyleFunction = this.setTextInputStyles;
			this.getStyleProviderForClass( TextInput ).setFunctionForStyleName( TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT,
																				this.setSearchTextInputStyles );
			  
			
			this.getStyleProviderForClass( TextInput ).setFunctionForStyleName(  FeathersExtLib_StyleNameConstants.TEXT_INPUT__ALTERNATE_NAME_TEXT_INPUT_SEMI,
				this.setTextInputSemiTransparentStyles);
			
			this.getStyleProviderForClass( TextInput ).setFunctionForStyleName(  FeathersExtLib_StyleNameConstants.TEXT_INPUT__ALTERNATE_NAME_SEARCH_TEXT_INPUT_SEMI,
				this.setSearchTextInputSemiStyles );
 
			this.getStyleProviderForClass( TextInput ).setFunctionForStyleName(  FeathersExtLib_StyleNameConstants.TEXT_INPUT__ALTERNATE_NAME_TEXT_INPUT_TRANSPARENT,
				this.setTextInputTransparentStyles);
			
			//text area
			this.getStyleProviderForClass( TextArea ).defaultStyleFunction = this.setTextAreaStyles;

			//toggle switch
			this.getStyleProviderForClass( ToggleSwitch ).defaultStyleFunction = this.setToggleSwitchStyles;
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_THUMB,
																			 this.setSimpleButtonInitializerWhite );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_ON_TRACK,
																			 this.setToggleSwitchTrackStyles );
			//we don't need a style function for the off track in this theme
			//the toggle switch layout uses a single track
		}

		/**
		 * 
		 * @return 
		 */
		protected function pageIndicatorNormalSymbolFactory():DisplayObject {

			var symbol:ImageLoader = new ImageLoader();
			symbol.source = this.pageIndicatorNormalSkinTexture;
			symbol.textureScale =1;//.5; 
			//symbol.textureScale = Math.ceil(this.scale*this.adHocScaleReduction);
			return symbol;
		}

		/**
		 * 
		 * @return 
		 */
		protected function pageIndicatorSelectedSymbolFactory():DisplayObject {

			var symbol:ImageLoader = new ImageLoader();
			symbol.source = this.pageIndicatorSelectedSkinTexture;
			symbol.textureScale = 1;//.5; 
			//symbol.textureScale = Math.ceil(this.scale*this.adHocScaleReduction);
			return symbol;
		}

		/**
		 * 
		 * @return 
		 */
		protected function imageLoaderFactory():ImageLoader {

			var image:ImageLoader = new ImageLoader();
			image.textureScale = this.scale;
			return image;
		}
		
		protected function imageLoaderFactory_noSmoothing():ImageLoader
		{
			const image:ImageLoader = new ImageLoader();
			image.textureScale = this.scale;//*0.7;
			image.smoothing = TextureSmoothing.NONE;
			return image;
		}

		//-------------------------
		// Shared
		//-------------------------

		/**
		 * 
		 * @param scroller
		 */
		protected function setScrollerStyles( scroller:Scroller ):void {

			scroller.horizontalScrollBarFactory = scrollBarFactory;
			scroller.verticalScrollBarFactory = scrollBarFactory;
		}

		/**
		 * 
		 * @param button
		 */
		protected function setSimpleButtonInitializerWhite( button:Button ):void {

			var overrideControlSize:Number = Math.round(this.controlSize * .8);
			
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = btn_blue_second;
			skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.displayObjectProperties = { width: overrideControlSize, height: overrideControlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;

			button.minWidth = button.minHeight = overrideControlSize;
			button.minTouchWidth = button.minTouchHeight = overrideControlSize;
		}

		/**
		 * 
		 * @param button
		 */
		protected function setSimpleButtonInitializerRedLightSlider( button:Button ):void {

			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = buttonRedLightUpSkinTextures;
			skinSelector.setValueForState( buttonRedLightDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;

			button.minWidth = button.minHeight =  this.controlSize;
			button.minTouchWidth = button.minTouchHeight =Math.round( this.controlSize * this.controlTouchBoundaryScale);
		}

		//-------------------------
		// Alert
		//-------------------------

		/**
		 * 
		 * @param alert
		 */
		protected function setAlertStyles( alert:Alert ):void {

			this.setScrollerStyles( alert );

			const backgroundSkin:Scale9Image = new Scale9Image( bg_popup, 1 );
			alert.backgroundSkin = backgroundSkin;

			alert.paddingTop = 0;
			alert.paddingRight = this.gutterSize;
			alert.paddingBottom = this.smallGutterSize;
			alert.paddingLeft = this.gutterSize;
			alert.gap = this.smallGutterSize;
			alert.maxWidth = this.popUpFillSize;
			//alert.maxHeight = this.popUpFillSize;

			// Added
			alert.paddingTop = 0;
			alert.buttonGroupProperties.padding = 18;

		}

		//see Panel section for Header styles

		/**
		 * 
		 * @param group
		 */
		protected function setAlertButtonGroupStyles( group:ButtonGroup ):void {

			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
			group.verticalAlign = ButtonGroup.VERTICAL_ALIGN_JUSTIFY;
			group.distributeButtonSizes = false;
			group.gap = this.smallGutterSize;
			group.padding = this.smallGutterSize;
			group.customButtonStyleName = THEME_NAME_ALERT_BUTTON_GROUP_BUTTON;

		}

		/**
		 * 
		 * @param button
		 */
		protected function setAlertButtonGroupButtonStyles( button:Button ):void {

			this.setButtonStyles( button );
			button.minWidth = 2 * this.controlSize;
		}

		/**
		 * 
		 * @param renderer
		 */
		protected function setAlertMessageTextRendererStyles( renderer:TextBlockTextRenderer ):void {

			renderer.wordWrap = true;
			renderer.elementFormat = this.darkElementFormat;
		}

		//-------------------------
		// Button
		//-------------------------

		/**
		 * 
		 * @param button
		 */
		protected function setBaseButtonStyles( button:Button ):void {

			button.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			button.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;

			if ( button is ToggleButton ) {
				ToggleButton( button ).selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			}

			button.paddingTop =  this.buttonPaddingTop;
			button.paddingBottom =  this.buttonPaddingBottom; 
			button.paddingLeft = this.buttonPaddingLeft;
			button.paddingRight = this.buttonPaddingRight;
			
			button.gap = this.smallGutterSize;
			button.minGap = this.smallGutterSize;
			button.minWidth = button.minHeight = this.controlSize;
			button.minTouchWidth =  Math.round(this.controlSize * this.controlTouchBoundaryScale);
			button.minTouchHeight =  Math.round(this.controlSize * this.controlTouchBoundaryScale);
			
		 
			// IMPORTANT: recommended for object pooling
			//trace("RESET FUNC: ", (button.label) ? button.label : "Icon only");
			button.resetObjectFunction =  BaseFlatThemePoolFunctions.resetButtonObject;
			 
			button.iconOffsetY = -2 * fmgr.theme.scaledResolution;
		}

		/**
		 * 
		 * @param button
		 */
		protected function setButtonStyles( button:Button ):void {

			//trace("Setting button styles...");
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState( this.buttonDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.setValueForState( this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true );
			skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles( button );
			
			
		}

		/**
		 * 
		 * @param button
		 */
		protected function setButtonGreenStyles( button:Button ):void {

			this.setButtonStyles( button );
		}

		/**
		 * 
		 * @param button
		 */
		protected function setCallToActionButtonStyles( button:Button ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonCallToActionUpSkinTextures;
			skinSelector.setValueForState( this.buttonCallToActionDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			button.hoverLabelProperties.elementFormat = this.lightUIElementFormat;
			button.upLabelProperties.elementFormat = this.lightUIElementFormat;
			button.downLabelProperties.elementFormat = this.lightUIElementFormat;

			this.setBaseButtonStyles( button );
		}

		/**
		 * 
		 * @param button
		 */
		protected function setQuietButtonStyles( button:Button ):void {

			 
			button.stateToSkinFunction = null;
			
			var transQuad:Quad = new Quad(10,10, 0x000000);
			transQuad.visible = false;
			button.defaultSkin = transQuad;
			
			this.setBaseButtonStyles( button );
			
			button.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			button.downLabelProperties.elementFormat = this.lightUIElementFormat;
			button.downLabelProperties.alpha =.6;
			button.defaultLabelProperties.alpha =1;
			button.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;

			if ( button is ToggleButton ) {
				var toggleButton:ToggleButton = ToggleButton( button );
				toggleButton.defaultSelectedLabelProperties.elementFormat = this.lightUIElementFormat;
				toggleButton.selectedDisabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			}

			button.paddingTop =  this.buttonPaddingTop;
			button.paddingBottom =  this.buttonPaddingBottom; 
			button.paddingLeft = this.buttonPaddingLeft;
			button.paddingRight = this.buttonPaddingRight;
			
			button.gap = 0;//this.smallGutterSize;
			button.minGap = 2;//this.smallGutterSize;
			button.minWidth = 20;// button.minHeight = this.controlSize;
			button.iconOffsetY = -1 * fmgr.theme.scaledResolution;
			//button.paddingLeft = Math.ceil(this.gutterSize * 2);// + this.smallGutterSize;
			
			/*button.paddingTop = button.paddingBottom = this.smallGutterSize;
			button.paddingLeft = button.paddingRight = this.gutterSize;
			button.gap = this.smallGutterSize;
			button.minGap = this.smallGutterSize;
			button.minWidth = button.minHeight = this.controlSize;
			button.minTouchWidth = button.minTouchHeight = this.gridSize;*/
			
			
		}

		/**
		 * 
		 * @param button
		 */
		protected function setDangerButtonStyles( button:Button ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonDangerUpSkinTextures;
			skinSelector.setValueForState( this.buttonDangerDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;

			this.setBaseButtonStyles( button );
		}

		/**
		 * 
		 * @param button
		 */
		protected function setBackButtonStyles( button:Button ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonBackUpSkinTextures;
			skinSelector.setValueForState( this.buttonBackDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( this.buttonBackDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles( button );
			button.paddingLeft = Math.ceil(this.gutterSize * 2);// + this.smallGutterSize;
		}

		/**
		 * 
		 * @param button
		 */
		protected function setForwardButtonStyles( button:Button ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonForwardUpSkinTextures;
			skinSelector.setValueForState( this.buttonForwardDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( this.buttonForwardDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles( button );
			button.paddingRight = Math.ceil(this.gutterSize * 2);// + this.smallGutterSize;
		}

		//-------------------------
		// ButtonGroup
		//-------------------------

		/**
		 * 
		 * @param group
		 */
		protected function setButtonGroupStyles( group:ButtonGroup ):void {

			group.minWidth = this.popUpFillSize;
			group.gap = this.smallGutterSize;
		}

		/**
		 * 
		 * @param button
		 */
		protected function setButtonGroupButtonStyles( button:Button ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState( this.buttonDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.setValueForState( this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true );
			skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultLabelProperties.elementFormat = this.largeUILightElementFormat;
			button.disabledLabelProperties.elementFormat = this.largeUIDarkDisabledElementFormat;

			if ( button is ToggleButton ) {
				ToggleButton( button ).selectedDisabledLabelProperties.elementFormat = this.largeUIDarkDisabledElementFormat;
			}

			button.paddingTop = this.smallGutterSize;
			button.paddingBottom = this.smallGutterSize;
			button.paddingLeft = this.gutterSize;
			button.paddingRight = this.gutterSize;
			button.gap = this.smallGutterSize;
			button.minGap = this.smallGutterSize;
			button.minWidth = this.controlSize;
			button.minHeight = this.controlSize;
			button.minTouchWidth = Math.round(this.controlSize * this.controlTouchBoundaryScale);
			button.minTouchHeight = Math.round(this.controlSize * this.controlTouchBoundaryScale);
		}

		//-------------------------
		// Callout
		//-------------------------

		/**
		 * 
		 * @param callout
		 */
		protected function setCalloutStyles( callout:Callout ):void {

			var alternateScale:Number = 1;
			var backgroundSkin:Scale9Image = new Scale9Image( this.bg_popup, alternateScale );
			backgroundSkin.width = this.calloutBackgroundMinSize;
			backgroundSkin.height = this.calloutBackgroundMinSize;
			callout.backgroundSkin = backgroundSkin;

			var topArrowSkin:Image = new Image( this.calloutTopArrowSkinTexture );
			topArrowSkin.scaleX = topArrowSkin.scaleY = alternateScale;
			callout.topArrowSkin = topArrowSkin;

			var rightArrowSkin:Image = new Image( this.calloutRightArrowSkinTexture );
			rightArrowSkin.scaleX = rightArrowSkin.scaleY = alternateScale;
			callout.rightArrowSkin = rightArrowSkin;

			var bottomArrowSkin:Image = new Image( this.calloutBottomArrowSkinTexture );
			bottomArrowSkin.scaleX = bottomArrowSkin.scaleY = alternateScale;
			callout.bottomArrowSkin = bottomArrowSkin;

			var leftArrowSkin:Image = new Image( this.calloutLeftArrowSkinTexture );
			leftArrowSkin.scaleX = leftArrowSkin.scaleY = alternateScale;
			callout.leftArrowSkin = leftArrowSkin;

			callout.padding = this.gutterSize;
		}

		//-------------------------
		// Check
		//-------------------------

		/**
		 * 
		 * @param check
		 */
		protected function setCheckStyles( check:Check ):void {

			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.defaultValue = btn_check_off;
			iconSelector.defaultSelectedValue = btn_check_on;

			iconSelector.setValueForState( this.btn_check_off, Button.STATE_DOWN, false );
			iconSelector.setValueForState( this.btn_check_dis_off, Button.STATE_DISABLED, false );
			iconSelector.setValueForState( this.btn_check_on, Button.STATE_DOWN, true );
			iconSelector.setValueForState( this.btn_check_dis_on, Button.STATE_DISABLED, true );
			iconSelector.displayObjectProperties = { scaleX: this.scale, scaleY: this.scale };
			check.stateToIconFunction = iconSelector.updateValue;

			check.defaultLabelProperties.elementFormat = this.darkUIElementFormat;
			check.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			check.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;

			check.iconOffsetX = 10;
			check.gap = this.gutterSize;
			check.minWidth = this.toggleControlSize;
			check.minHeight = this.toggleControlSize;
			check.minTouchWidth = Math.round(this.toggleControlSize * 1.25); //this.gridSize;
			check.minTouchHeight = Math.round(this.toggleControlSize * 1.25); // this.gridSize;

		}

		//-------------------------
		// Drawers
		//-------------------------

		/**
		 * 
		 * @param drawers
		 */
		protected function setDrawersStyles( drawers:Drawers ):void {

			var overlaySkin:Quad = new Quad( 10, 10, DRAWER_OVERLAY_COLOR );
			overlaySkin.alpha = DRAWER_OVERLAY_ALPHA;
			drawers.overlaySkin = overlaySkin;
		}

		//-------------------------
		// GroupedList
		//-------------------------

		/**
		 * 
		 * @param list
		 */
		protected function setGroupedListStyles( list:GroupedList ):void {

			this.setScrollerStyles( list );
			var backgroundSkin:Quad = new Quad( this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR );
			list.backgroundSkin = backgroundSkin;
		}

		//see List section for item renderer styles

		/**
		 * 
		 * @param renderer
		 */
		protected function setGroupedListHeaderRendererStyles( renderer:DefaultGroupedListHeaderOrFooterRenderer ):void {

			renderer.backgroundSkin = new Quad( 1, 1, GROUPED_LIST_HEADER_BACKGROUND_COLOR );

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.contentLabelProperties.elementFormat = this.lightUIElementFormat;
			renderer.contentLabelProperties.disabledElementFormat = this.lightUIDisabledElementFormat;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.smallGutterSize + this.gutterSize;
			renderer.paddingRight = this.gutterSize;

			/*renderer.minWidth = renderer.minHeight = (smallControlSize*2) * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = (smallControlSize*2) * this.scale;*/

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		/**
		 * 
		 * @param renderer
		 */
		protected function setGroupedListFooterRendererStyles( renderer:DefaultGroupedListHeaderOrFooterRenderer ):void {

			renderer.backgroundSkin = new Quad( 1, 1, GROUPED_LIST_FOOTER_BACKGROUND_COLOR );

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
			renderer.contentLabelProperties.elementFormat = this.lightElementFormat;
			renderer.contentLabelProperties.disabledElementFormat = this.disabledElementFormat;
			renderer.paddingTop = renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.smallGutterSize + this.gutterSize;
			renderer.paddingRight = this.gutterSize;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		/**
		 * 
		 * @param list
		 */
		protected function setInsetGroupedListStyles(list:GroupedList):void
		{
			list.customItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_ITEM_RENDERER;
			list.customFirstItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FIRST_ITEM_RENDERER;
			list.customLastItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_LAST_ITEM_RENDERER;
			list.customSingleItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_SINGLE_ITEM_RENDERER;
			list.customHeaderRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_HEADER_RENDERER;
			list.customFooterRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FOOTER_RENDERER;
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.useVirtualLayout = true;
			layout.padding = this.smallGutterSize;
			layout.gap = 0;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			list.layout = layout;
		}

		/**
		 * 
		 * @param renderer
		 * @param defaultSkinTextures
		 * @param selectedAndDownSkinTextures
		 */
		protected function setInsetGroupedListItemRendererStyles( renderer:DefaultGroupedListItemRenderer,
																  defaultSkinTextures:Scale9Textures,
																  selectedAndDownSkinTextures:Scale9Textures ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = defaultSkinTextures;
			skinSelector.defaultSelectedValue = selectedAndDownSkinTextures;
			skinSelector.setValueForState( selectedAndDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.displayObjectProperties = { width: this.itemRendererMinSize, height: this.itemRendererMinSize, textureScale: this.scale };
			renderer.stateToSkinFunction = skinSelector.updateValue;
 
			renderer.defaultLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize + this.smallGutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.gap = this.gutterSize;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.gutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = this.itemRendererMinSize;
			renderer.minTouchWidth = renderer.minTouchHeight = this.itemRendererMinSize;

			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
		}

		/**
		 * 
		 * @param renderer
		 */
		protected function setInsetGroupedListMiddleItemRendererStyles( renderer:DefaultGroupedListItemRenderer ):void {

			this.setInsetGroupedListItemRendererStyles( renderer, this.itemRendererUpSkinTextures, this.itemRendererSelectedSkinTextures );
		}

		/**
		 * 
		 * @param renderer
		 */
		protected function setInsetGroupedListFirstItemRendererStyles( renderer:DefaultGroupedListItemRenderer ):void {

			this.setInsetGroupedListItemRendererStyles( renderer,
														this.insetItemRendererFirstUpSkinTextures,
														this.insetItemRendererFirstSelectedSkinTextures );
		}

		/**
		 * 
		 * @param renderer
		 */
		protected function setInsetGroupedListLastItemRendererStyles( renderer:DefaultGroupedListItemRenderer ):void {

			this.setInsetGroupedListItemRendererStyles( renderer,
														this.insetItemRendererLastUpSkinTextures,
														this.insetItemRendererLastSelectedSkinTextures );
		}

		/**
		 * 
		 * @param renderer
		 */
		protected function setInsetGroupedListSingleItemRendererStyles( renderer:DefaultGroupedListItemRenderer ):void {

			this.setInsetGroupedListItemRendererStyles( renderer,
														this.insetItemRendererSingleUpSkinTextures,
														this.insetItemRendererSingleSelectedSkinTextures );
		}

		/**
		 * 
		 * @param renderer
		 */
		protected function setInsetGroupedListHeaderRendererStyles( renderer:DefaultGroupedListHeaderOrFooterRenderer ):void {

			var defaultSkin:Quad = new Quad( 1, 1, 0xff00ff );
			defaultSkin.alpha = 0;
			renderer.backgroundSkin = defaultSkin;

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.contentLabelProperties.elementFormat = this.lightUIElementFormat;
			renderer.contentLabelProperties.disabledElementFormat = this.darkUIDisabledElementFormat;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize + this.smallGutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.minWidth = this.controlSize;
			renderer.minHeight = Math.round(this.controlSize * 1.5);

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		/**
		 * 
		 * @param renderer
		 */
		protected function setInsetGroupedListFooterRendererStyles( renderer:DefaultGroupedListHeaderOrFooterRenderer ):void {

			var defaultSkin:Quad = new Quad( 1, 1, 0xff00ff );
			defaultSkin.alpha = 0;
			renderer.backgroundSkin = defaultSkin;

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
			renderer.contentLabelProperties.elementFormat = this.darkUIElementFormat;
			renderer.contentLabelProperties.disabledElementFormat = this.darkUIDisabledElementFormat;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize + this.smallGutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.minWidth = this.controlSize;
			renderer.minHeight = this.controlSize;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		//-------------------------
		// Header
		//-------------------------
 
		protected function setBaseHeaderStyles(header:Header):void{
			
			header.resetObjectFunction = BaseFlatThemePoolFunctions.resetHeaderObject;
		}
		/**
		 * 
		 * @param header
		 */
		protected function setHeaderStyles( header:Header ):void {

			header.minWidth = this.headerSize;
			header.minHeight = this.headerSize;
			header.padding = this.smallGutterSize;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;

			//var backgroundSkin:TiledImage = new TiledImage( this.headerBackgroundSkinTexture, this.scale );

			//backgroundSkin.smoothing = TextureSmoothing.NONE;
			//backgroundSkin.width = backgroundSkin.height =  (this.controlSize * 2 ) * this.scale; // 124 size
			//header.backgroundSkin = new Quad( 10, 10, 0x2c3e50 ); // backgroundSkin;
			//header.backgroundSkin = new Quad( 10, 10, 0x2c3e50 );
			
			header.backgroundSkin = new Quad( 10, 10, 0xFFFFFF );
			header.backgroundSkin.alpha=.4;
			//header.backgroundSkin.width = header.backgroundSkin.height = 20;
			header.titleProperties.elementFormat = this.headerElementFormat;
			 
			setBaseHeaderStyles(header);
			
		}

		//-------------------------
		// Label
		//-------------------------

		/**
		 * 
		 * @param label
		 */
		protected function setLabelStyles( label:Label ):void {

			setBaseLabelStyles(label);
			
			label.textRendererProperties.elementFormat = this.lightElementFormat;
			label.textRendererProperties.disabledElementFormat = this.disabledElementFormat;  
		}
		 

		protected function setBaseLabelStyles(label:Label):void{
			
			// IMPORTANT: recommended for object pooling
			label.resetObjectFunction = BaseFlatThemePoolFunctions.resetLabelObject;
		}
		/**
		 * 
		 * @param label
		 */
		protected function setHeadingLabelStyles( label:Label ):void {

			setBaseLabelStyles(label);
			
			label.textRendererProperties.elementFormat = this.largeLightElementFormat;
			label.textRendererProperties.disabledElementFormat = this.largeDisabledElementFormat;
		}
		

		/**
		 * 
		 * @param label
		 */
		protected function setDetailLabelStyles( label:Label ):void {

			setBaseLabelStyles(label);
			
			label.textRendererProperties.elementFormat = this.smallLightElementFormat;
			label.textRendererProperties.disabledElementFormat = this.smallDisabledElementFormat;
		}
		
		

		//-------------------------
		// List
		//-------------------------

		/**
		 * 
		 * @param list
		 */
		protected function setListStyles( list:List ):void {

			this.setScrollerStyles( list );
			var backgroundSkin:Quad = new Quad( this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR );
			list.backgroundSkin = backgroundSkin;
		}
		
		protected function setListStylesNoBackground( list:List ):void {
			
			this.setListStyles( list );
			var backgroundSkin:Quad = new Quad( this.gridSize, this.gridSize, 0x000000 );
			list.backgroundSkin = backgroundSkin;
			list.backgroundSkin.alpha = 0;
		}

		private var _itemRendererBackground:Quad;
		
		protected function setItemRendererNoBackgroundStyles( renderer:BaseDefaultItemRenderer ):void {
			
			setItemRendererStyles(renderer);
			
		 
			
			renderer.stateToSkinFunction = null;
			renderer.defaultSkin = this.itemRendererBackground;
			//renderer.defaultSkin.alpha=.5;
			renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_BOTTOM;
			renderer.iconPosition = Button.ICON_POSITION_TOP;
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			renderer.defaultLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;
		}

		
		/**
		 * 
		 * @param renderer
		 */
		protected function setItemRendererStyles( renderer:BaseDefaultItemRenderer ):void {

			var alteredScale:Number =1;
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.defaultSelectedValue = this.itemRendererSelectedSkinTextures;
			skinSelector.setValueForState( this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false );
			skinSelector.displayObjectProperties =
				{ width: this.itemRendererMinSize, height: this.itemRendererMinSize, textureScale: alteredScale };
			/*skinSelector.displayObjectProperties =
				{
					width: this.gridSize,
						height: this.gridSize,
						textureScale: this.scale
				};*/
			renderer.stateToSkinFunction = skinSelector.updateValue;

			renderer.defaultLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = itemPaddingTop * this.scale;
			renderer.paddingBottom = itemPaddingBottom * this.scale;

			/*renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;*/
			renderer.paddingLeft = this.gutterSize + this.smallGutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.gap = this.gutterSize;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.gutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = this.itemRendererMinSize;
			renderer.minHeight = this.itemRendererMinSize;
			renderer.minTouchWidth = this.itemRendererMinSize;
			renderer.minTouchHeight = this.itemRendererMinSize;

			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
		}

		/**
		 * 
		 * @param renderer
		 */
		protected function setItemRendererAccessoryLabelRendererStyles( renderer:TextBlockTextRenderer ):void {

			renderer.elementFormat = this.darkElementFormat;
		}

		/**
		 * 
		 * @param renderer
		 */
		protected function setItemRendererIconLabelStyles( renderer:TextBlockTextRenderer ):void {

			renderer.elementFormat = this.darkElementFormat;
		}

		//-------------------------
		// NumericStepper
		//-------------------------

		/**
		 * 
		 * @param stepper
		 */
		protected function setNumericStepperStyles( stepper:NumericStepper ):void {

			stepper.buttonLayoutMode = NumericStepper.BUTTON_LAYOUT_MODE_SPLIT_HORIZONTAL;
			stepper.incrementButtonLabel = "+";
			stepper.decrementButtonLabel = "-";
		}

		/**
		 * 
		 * @param input
		 */
		protected function setNumericStepperTextInputStyles( input:TextInput ):void {

			var backgroundSkin:Scale9Image = new Scale9Image( this.bg_null, this.scale );
			backgroundSkin.width = this.controlSize;
			backgroundSkin.height = this.controlSize;
			input.backgroundSkin = backgroundSkin;

			var backgroundDisabledSkin:Scale9Image = new Scale9Image( this.bg_null, this.scale );
			backgroundDisabledSkin.width = this.controlSize;
			backgroundDisabledSkin.height = this.controlSize;
			input.backgroundDisabledSkin = backgroundDisabledSkin;

			var backgroundFocusedSkin:Scale9Image = new Scale9Image( this.bg_null, this.scale );
			backgroundFocusedSkin.width = this.controlSize;
			backgroundFocusedSkin.height = this.controlSize;
			input.backgroundFocusedSkin = backgroundFocusedSkin;

			/*input.minWidth = input.minHeight = this.controlSize;
			input.minTouchWidth = input.minTouchHeight = this.gridSize;
			input.gap = this.smallGutterSize;
			input.padding = this.smallGutterSize;*/
			input.minWidth = 60 * this.scale;
			input.minHeight = 40 * this.scale;
			input.minTouchWidth = input.minTouchHeight = 60 * this.scale;
			input.gap = 0 * this.scale;
			input.paddingTop = 10 * this.scale;
			input.paddingLeft = input.paddingRight = 4 * this.scale;

			input.isEditable = false;
			input.textEditorFactory = stepperTextEditorFactory;
			input.textEditorProperties.elementFormat = this.largeUIDarkElementFormat;
			input.textEditorProperties.disabledElementFormat = this.largeDisabledElementFormat;
			input.textEditorProperties.textAlign = TextBlockTextEditor.TEXT_ALIGN_CENTER;
		}
		
		/**
		 * 
		 * @param input
		 */
		protected function setNumericStepperTextInputStylesWithoutBackground( input:TextInput ):void {
			
			this.setNumericStepperTextInputStyles(input);
			
			 
			input.textEditorProperties.elementFormat = this.largeUILightElementFormat;
			input.textEditorProperties.disabledElementFormat = this.largeDisabledElementFormat;
			input.textEditorProperties.textAlign = TextBlockTextEditor.TEXT_ALIGN_CENTER;
		}

		/**
		 * 
		 * @param button
		 */
		protected function setNumericStepperButtonStyles( button:Button ):void {

			//this.setButtonStyles( button );
			// From Button Styles
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var overrideControlSize:Number = Math.round(this.controlSize * .8);
			
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState( this.buttonDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.setValueForState( this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true );
			skinSelector.displayObjectProperties = { width: overrideControlSize, height: overrideControlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;
			//this.setBaseButtonStyles( button );
			
			// From base button styles
			button.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			button.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			
			if ( button is ToggleButton ) {
				ToggleButton( button ).selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			}
			
			button.paddingTop =  buttonPaddingTop * this.scale;
			button.paddingBottom =  buttonPaddingBottom * this.scale;
			
			/*button.paddingTop = this.smallGutterSize;
			button.paddingBottom = this.smallGutterSize;*/
			button.paddingLeft = this.gutterSize;
			button.paddingRight = this.gutterSize;
			button.gap = this.smallGutterSize;
			button.minGap = this.smallGutterSize;
			button.minWidth = button.minHeight = overrideControlSize;
			button.minTouchWidth =  this.controlSize;
			button.minTouchHeight =  this.controlSize;
			
			button.keepDownStateOnRollOut = true;
		}

		//-------------------------
		// PageIndicator
		//-------------------------

		/**
		 * 
		 * @param pageIndicator
		 */
		protected function setPageIndicatorStyles( pageIndicator:PageIndicator ):void {

			pageIndicator.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
			pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
			pageIndicator.gap = this.smallGutterSize;
			pageIndicator.padding = this.smallGutterSize / 2;
			pageIndicator.minTouchWidth = this.smallControlSize * 2
			pageIndicator.minTouchHeight = this.smallControlSize * 2;
		}

		//-------------------------
		// Panel
		//-------------------------

		/**
		 * 
		 * @param panel
		 */
		protected function setPanelStyles( panel:Panel ):void {

			this.setScrollerStyles( panel );

			panel.backgroundSkin = new Scale9Image( this.bg_popup, this.contentScaleFactor );
			panel.backgroundSkin.alpha=0;
			panel.paddingTop = 0;
			panel.paddingRight = this.smallGutterSize;
			panel.paddingBottom = this.smallGutterSize;
			panel.paddingLeft = this.smallGutterSize;
			 
		}
		
	
		/**
		 * 
		 * @param header
		 */
		protected function setHeaderWithoutBackgroundStyles( header:Header  ):void {

			header.minWidth = this.headerSize;
			header.minHeight = this.headerSize;
			header.paddingTop = header.paddingBottom = this.smallGutterSize * this.scale;
			header.paddingLeft = header.paddingRight = this.gutterSize * this.scale;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;

			//header.titleProperties.elementFormat = this.headerElementFormat;
			 
			header.titleProperties.elementFormat = this.headerElementFormat;
			
			setBaseHeaderStyles(header);
		}
		
		/**
		 * 
		 * @param header
		 */
		protected function setAlertHeaderWithoutBackgroundStyles( header:Header  ):void {
			
			header.minWidth = this.headerSize;
			header.minHeight = this.headerSize;
			header.paddingTop = header.paddingBottom = this.smallGutterSize * this.scale;
			header.paddingLeft = header.paddingRight = this.gutterSize * this.scale;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
			
			header.backgroundSkin = new Quad( 10, 10, 0x000000 );
			header.backgroundSkin.alpha = 0;
			//header.titleProperties.elementFormat = this.headerElementFormat;
			
			header.titleProperties.elementFormat = this.headerElementFormatDark;
		}
		
		 
		/*	protected function headerWithoutBackgroundInitializerDark(header:Header):void
			{
				header.minWidth = this.gridSize;
				header.minHeight = this.gridSize;
				header.paddingTop = header.paddingBottom = (this.smallGutterSize*2) * this.scale;
				header.paddingLeft = header.paddingRight = this.gutterSize * this.scale;

				header.titleProperties.elementFormat = this.headerElementFormatDark;
			}*/

		//-------------------------
		// PanelScreen
		//-------------------------

		/**
		 * 
		 * @param header
		 */
		protected function setPanelScreenHeaderStyles( header:Header ):void {

			this.setHeaderStyles( header );
			header.useExtraPaddingForOSStatusBar = true;
		}

		protected function setHeaderBoldFontStyles( header:Header ):void {
			setHeaderStyles(header);
			
			header.minWidth =  this.headerSize;
			header.minHeight =  this.headerSize;
			
			header.padding = 0;//this.smallGutterSize;
			header.gap = 0;//this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
			header.paddingLeft=2 * fmgr.theme.scaledResolution;
			header.paddingRight=2 * fmgr.theme.scaledResolution;
			header.paddingTop = 2 * fmgr.theme.scaledResolution;
			header.paddingBottom = 2 * fmgr.theme.scaledResolution;
			header.backgroundSkin = new Quad( 10, 10, 0x000000 );
			header.backgroundSkin.alpha=.2;
			
			header.titleProperties.elementFormat = this.headerElementFormatBold;
		}
		
		
		
		//-------------------------
		// PickerList
		//-------------------------

		
		/**
		 * 
		 * @param list
		 */
		/*protected function setPickerListStyles( list:PickerList ):void {

			if ( DeviceCapabilities.isTablet( Starling.current.nativeStage )) {
				list.popUpContentManager = new CalloutPopUpContentManager();
			} else {
				var centerStage:VerticalCenteredPopUpContentManager = new VerticalCenteredPopUpContentManager();
				centerStage.marginTop = centerStage.marginRight = centerStage.marginBottom = centerStage.marginLeft = this.gutterSize;
				list.popUpContentManager = centerStage;
			}
			
			var alteredScale:Number = 1;

			
			var layout:VerticalLayout = new VerticalLayout();
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_BOTTOM;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			layout.useVirtualLayout = true;
			layout.gap = 0;
			layout.padding = 0;
			list.listProperties.layout = layout;
			list.listProperties.verticalScrollPolicy = List.SCROLL_POLICY_ON;

			if ( DeviceCapabilities.isTablet( Starling.current.nativeStage )) {
				list.listProperties.minWidth = 150 * this.contentScaleFactor; //this.popUpFillSize;
				list.listProperties.maxHeight = this.popUpFillSize;
			} else {
				var backgroundSkin:Scale9Image = new Scale9Image( this.bg_null, this.contentScaleFactor );
				backgroundSkin.width = this.gutterSize;
				backgroundSkin.height = this.gutterSize;
				list.listProperties.backgroundSkin = backgroundSkin;
				list.listProperties.padding = this.xSmallGutterSize;
			}

			list.listProperties.itemRendererName = THEME_NAME_PICKER_LIST_ITEM_RENDERER;
			
			list.resetObjectFunction = BaseFlatThemePoolFunctions.resetPickerListObject;
		}*/

		/**
		 * 
		 * @param button
		 */
		/*protected function setPickerListButtonStyles( button:Button ):void {

			this.setButtonStyles( button );
			 
			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.setValueTypeHandler( SubTexture, textureValueTypeHandler );
			iconSelector.defaultValue = this.pickerListButtonIconTexture;
			iconSelector.setValueForState( this.pickerListButtonIconDisabledTexture, Button.STATE_DISABLED, false );
			 
			var maxHeight:Number = Math.round(this.controlSize - (buttonPaddingBottom + buttonPaddingTop));
			 
			iconSelector.displayObjectProperties = { height: maxHeight, textureScale: this.scale, snapToPixels: true };
			button.stateToIconFunction = iconSelector.updateValue;

			 
			button.gap = Number.POSITIVE_INFINITY;
			//button.minGap = this.gutterSize; 
			button.iconPosition = Button.ICON_POSITION_RIGHT;
		}*/

		/**
		 * 
		 * @param renderer
		 */
		protected function setPickerListItemRendererStyles( renderer:BaseDefaultItemRenderer ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.setValueForState( this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false );
			skinSelector.displayObjectProperties =
				{ width: this.itemRendererMinSize, height: this.itemRendererMinSize, textureScale: this.contentScaleFactor };
			/*skinSelector.displayObjectProperties =
				{
					width: this.gridSize,
						height: this.gridSize,
						textureScale: this.scale
				};*/
			renderer.stateToSkinFunction = skinSelector.updateValue;

			var defaultSelectedIcon:Image = new Image( this.pickerListItemSelectedIconTexture );
			defaultSelectedIcon.scaleX = defaultSelectedIcon.scaleY = this.contentScaleFactor;
			renderer.defaultSelectedIcon = defaultSelectedIcon;

			var defaultIcon:Quad = new Quad( defaultSelectedIcon.width, defaultSelectedIcon.height, 0xff00ff );
			defaultIcon.alpha = 0;
			renderer.defaultIcon = defaultIcon;

			renderer.defaultLabelProperties.elementFormat = this.largeDarkElementFormat;

			// Not using Selected format for picker lists; just icons
			//renderer.defaultSelectedLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;

			renderer.itemHasIcon = false;
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize + this.smallGutterSize;
			renderer.paddingRight = this.smallGutterSize;
			renderer.gap = Number.POSITIVE_INFINITY;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = Button.ICON_POSITION_RIGHT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.gutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = this.itemRendererMinSize;
			renderer.minHeight = this.itemRendererMinSize;
			renderer.minTouchWidth = this.itemRendererMinSize;
			renderer.minTouchHeight = this.itemRendererMinSize;
		}

		//-------------------------
		// ProgressBar
		//-------------------------

		/*protected function setProgressBarStyles(progress:ProgressBar):void
		{
			var backgroundSkin:Scale9Image = new Scale9Image(this.backgroundSkinTextures, this.scale);
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				backgroundSkin.width = this.smallControlSize;
				backgroundSkin.height = this.wideControlSize;
			}
			else
			{
				backgroundSkin.width = this.wideControlSize;
				backgroundSkin.height = this.smallControlSize;
			}
			progress.backgroundSkin = backgroundSkin;

			var backgroundDisabledSkin:Scale9Image = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				backgroundDisabledSkin.width = this.smallControlSize;
				backgroundDisabledSkin.height = this.wideControlSize;
			}
			else
			{
				backgroundDisabledSkin.width = this.wideControlSize;
				backgroundDisabledSkin.height = this.smallControlSize;
			}
			progress.backgroundDisabledSkin = backgroundDisabledSkin;

			var fillSkin:Scale9Image = new Scale9Image(this.buttonUpSkinTextures, this.scale);
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				fillSkin.width = this.smallControlSize;
				fillSkin.height = this.smallControlSize;
			}
			else
			{
				fillSkin.width = this.smallControlSize;
				fillSkin.height = this.smallControlSize;
			}
			progress.fillSkin = fillSkin;

			var fillDisabledSkin:Scale9Image = new Scale9Image(this.buttonDisabledSkinTextures, this.scale);
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				fillDisabledSkin.width = this.smallControlSize;
				fillDisabledSkin.height = this.smallControlSize;
			}
			else
			{
				fillDisabledSkin.width = this.smallControlSize;
				fillDisabledSkin.height = this.smallControlSize;
			}
			progress.fillDisabledSkin = fillDisabledSkin;
		}*/

		/**
		 * 
		 * @param progress
		 */
		protected function setProgressBarStyles( progress:ProgressBar ):void {

			var p_h:Number = this.smallControlSize; //38 * this.scale;

			var backgroundSkin:Scale3Image =
				new Scale3Image( new Scale3Textures( fmgr.theme.assetManager.getTexture( "preloader_bg" ), 0, 128 ), this.scale );

			if ( progress.direction == ProgressBar.DIRECTION_VERTICAL ) {
				backgroundSkin.width = Math.ceil( this.smallControlSize  );
				backgroundSkin.height = this.wideControlSize;
			} else {
				backgroundSkin.width = this.wideControlSize;
				backgroundSkin.height = Math.ceil( this.smallControlSize );
			}
			progress.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale3Image =
				new Scale3Image( new Scale3Textures( fmgr.theme.assetManager.getTexture( "preloader_bg_dis" ), 0, 128 ), this.scale );

			if ( progress.direction == ProgressBar.DIRECTION_VERTICAL ) {
				backgroundDisabledSkin.width = p_h;
				backgroundDisabledSkin.height = this.wideControlSize;
			} else {
				backgroundDisabledSkin.width = this.wideControlSize;
				backgroundDisabledSkin.height = p_h;
			}
			progress.backgroundDisabledSkin = backgroundDisabledSkin;

			const fillSkin:Scale3Image =
				new Scale3Image( new Scale3Textures( fmgr.theme.assetManager.getTexture( "preloader_fill" ), 0, 128 ), this.scale );

			if ( progress.direction == ProgressBar.DIRECTION_VERTICAL ) {
				fillSkin.width = p_h;
				fillSkin.height = this.xSmallGutterSize;
			} else {
				fillSkin.width = this.xSmallGutterSize;
				fillSkin.height = p_h;
			}
			progress.fillSkin = fillSkin;

			const fillDisabledSkin:Scale3Image =
				new Scale3Image( new Scale3Textures( fmgr.theme.assetManager.getTexture( "preloader_fill_dis" ), 0, 128 ), this.scale );

			if ( progress.direction == ProgressBar.DIRECTION_VERTICAL ) {
				fillDisabledSkin.width = p_h;
				fillDisabledSkin.height = this.smallControlSize;
			} else {
				fillDisabledSkin.width = this.smallControlSize;
				fillDisabledSkin.height = p_h;
			}
			progress.fillDisabledSkin = fillDisabledSkin;
		}

		//-------------------------
		// Radio
		//-------------------------

		/**
		 * 
		 * @param radio
		 */
		protected function setRadioStyles( radio:Radio ):void {

			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.defaultValue = btn_radio_off;
			iconSelector.defaultSelectedValue = btn_radio_on;
			iconSelector.setValueForState( this.btn_radio_off, Button.STATE_DOWN, false );
			iconSelector.setValueForState( this.btn_radio_off_dis, Button.STATE_DISABLED, false );
			iconSelector.setValueForState( this.btn_radio_on, Button.STATE_DOWN, true );
			iconSelector.setValueForState( this.btn_radio_dis, Button.STATE_DISABLED, true );
			iconSelector.displayObjectProperties = { scaleX: this.scale, scaleY: this.scale };
			radio.stateToIconFunction = iconSelector.updateValue;

			radio.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			radio.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			radio.selectedDisabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;

			radio.gap = this.smallGutterSize;
			radio.minWidth = this.toggleControlSize;
			radio.minHeight = this.toggleControlSize;
			radio.minTouchWidth = Math.round(this.toggleControlSize * 1.25)
			radio.minTouchHeight = Math.round(this.toggleControlSize * 1.25)
		}

		//-------------------------
		// ScrollContainer
		//-------------------------

		/**
		 * 
		 * @param container
		 */
		protected function setScrollContainerStyles( container:ScrollContainer ):void {

			this.setScrollerStyles( container );
		}

		/**
		 * 
		 * @param container
		 */
		protected function setToolbarScrollContainerStyles( container:ScrollContainer ):void {

			this.setScrollerStyles( container );

			if ( !container.layout ) {
				var layout:HorizontalLayout = new HorizontalLayout();
				layout.padding = this.smallGutterSize;
				layout.gap = this.xSmallGutterSize;
				container.layout = layout;
			}
			container.minWidth = this.gridSize;
			container.minHeight = this.gridSize;

			var backgroundSkin:TiledImage = new TiledImage( this.headerBackgroundSkinTexture, this.scale );
			backgroundSkin.width = backgroundSkin.height = this.gridSize;
			container.backgroundSkin = backgroundSkin;
		}

		//-------------------------
		// ScrollText
		//-------------------------

		/**
		 * 
		 * @param text
		 */
		protected function setScrollTextStyles( text:ScrollText ):void {

			this.setScrollerStyles( text );

			text.textFormat = this.scrollTextTextFormat;
			text.disabledTextFormat = this.scrollTextDisabledTextFormat;
			text.padding = this.gutterSize;
			text.paddingRight = this.gutterSize + this.smallGutterSize;
		}

		//-------------------------
		// SimpleScrollBar
		//-------------------------

		//-------------------------
		// SimpleScrollBar
		//-------------------------
		
		protected function setSimpleScrollBarStyles(scrollBar:SimpleScrollBar):void
		{
			if(scrollBar.direction == SimpleScrollBar.DIRECTION_HORIZONTAL)
			{
				scrollBar.paddingRight = this.scrollBarGutterSize;
				scrollBar.paddingBottom = this.scrollBarGutterSize;
				scrollBar.paddingLeft = this.scrollBarGutterSize;
				scrollBar.customThumbStyleName = THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB;
			}
			else
			{
				scrollBar.paddingTop = this.scrollBarGutterSize;
				scrollBar.paddingRight = this.scrollBarGutterSize;
				scrollBar.paddingBottom = this.scrollBarGutterSize;
				scrollBar.customThumbStyleName = THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB;
			}
		}
		
		protected function setHorizontalSimpleScrollBarThumbStyles(thumb:Button):void
		{
			var defaultSkin:Scale3Image = new Scale3Image(this.horizontalScrollBarThumbSkinTextures, this.scale);
			defaultSkin.width = this.smallGutterSize;
			thumb.defaultSkin = defaultSkin;
			thumb.hasLabelTextRenderer = false;
		}
		
		protected function setVerticalSimpleScrollBarThumbStyles(thumb:Button):void
		{
			var defaultSkin:Scale3Image = new Scale3Image(this.verticalScrollBarThumbSkinTextures, this.scale);
			defaultSkin.height = this.smallGutterSize;
			thumb.defaultSkin = defaultSkin;
			thumb.hasLabelTextRenderer = false;
		}

		//-------------------------
		// Slider
		//-------------------------

		/**
		 * 
		 * @param slider
		 */
		protected function setSliderStyles(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_MIN_MAX;
			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				slider.customMinimumTrackStyleName = THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK;
				slider.customMaximumTrackStyleName = THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK;
				slider.minWidth = this.controlSize;
			}
			else //horizontal
			{
				slider.customMinimumTrackStyleName = THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK;
				slider.customMaximumTrackStyleName = THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK;
				slider.minHeight = this.controlSize;
			}
		}

		/*protected function setHorizontalSliderMinimumTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
				{
					textureScale: this.scale
				};
			skinSelector.displayObjectProperties.width = this.wideControlSize;
			skinSelector.displayObjectProperties.height = this.controlSize;
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}*/

		/**
		 * 
		 * @param track
		 */
		protected function setHorizontalSliderMinimumTrackStyles( track:Button ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();

			var rect:Rectangle = DrawingUtils.getScaledRectangle(this.scale, 18, 18, 142, 14 );

			skinSelector.defaultValue = new Scale9Textures( fmgr.theme.assetManager.getTexture( "slider_left" ), rect );
			skinSelector.setValueForState( new Scale9Textures( fmgr.theme.assetManager.getTexture( "slider_left" ), rect ), Button.STATE_DOWN, false );
			skinSelector.setValueForState( new Scale9Textures( fmgr.theme.assetManager.getTexture( "slider_left_dis" ), rect ),
																					  Button.STATE_DISABLED,
																					  false );
			skinSelector.displayObjectProperties = { textureScale: this.scale };
			skinSelector.displayObjectProperties.width = 196 * this.scale; //this.wideControlSize;
			skinSelector.displayObjectProperties.height = this.smallControlSize;
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}

		/**
		 * 
		 * @param track
		 */
		protected function setHorizontalSliderMaximumTrackStyles( track:Button ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();

			/*skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);*/

			var rect:Rectangle = DrawingUtils.getScaledRectangle(this.scale, 18, 18, 142, 14 );

			skinSelector.defaultValue = new Scale9Textures( fmgr.theme.assetManager.getTexture( "slider_right" ), rect );
			skinSelector.setValueForState( new Scale9Textures( fmgr.theme.assetManager.getTexture( "slider_right" ), rect ), Button.STATE_DOWN, false );
			skinSelector.setValueForState( new Scale9Textures( fmgr.theme.assetManager.getTexture( "slider_right_dis" ), rect ),
																					  Button.STATE_DISABLED,
																					  false );
			skinSelector.displayObjectProperties = { textureScale: this.scale };
			skinSelector.displayObjectProperties.width = 196 * this.scale; //this.wideControlSize;
			skinSelector.displayObjectProperties.height = this.smallControlSize;
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}

		/**
		 * 
		 * @param track
		 */
		protected function setVerticalSliderMinimumTrackStyles( track:Button ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var rect:Rectangle = DrawingUtils.getScaledRectangle(this.scale, 18, 18, 14, 142 );

			skinSelector.defaultValue = new Scale9Textures( fmgr.theme.assetManager.getTexture( "v_slider_left" ), rect );
			skinSelector.setValueForState( new Scale9Textures( fmgr.theme.assetManager.getTexture( "v_slider_left" ), rect ), Button.STATE_DOWN, false );
			skinSelector.setValueForState( new Scale9Textures( fmgr.theme.assetManager.getTexture( "v_slider_left_dis" ), rect ),
																					  Button.STATE_DISABLED,
																					  false );

			skinSelector.displayObjectProperties = { textureScale: this.scale };
			skinSelector.displayObjectProperties.width = this.smallControlSize;
			skinSelector.displayObjectProperties.height = 196 * this.scale; //this.wideControlSize;
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}

		/**
		 * 
		 * @param track
		 */
		protected function setVerticalSliderMaximumTrackStyles( track:Button ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var rect:Rectangle = DrawingUtils.getScaledRectangle(this.scale, 18, 18, 14, 142 );

			skinSelector.defaultValue = new Scale9Textures( fmgr.theme.assetManager.getTexture( "v_slider_right" ), rect );
			skinSelector.setValueForState( new Scale9Textures( fmgr.theme.assetManager.getTexture( "v_slider_right" ), rect ), Button.STATE_DOWN, false );
			skinSelector.setValueForState( new Scale9Textures( fmgr.theme.assetManager.getTexture( "v_slider_right_dis" ), rect ),
																					  Button.STATE_DISABLED,
																					  false );

			skinSelector.displayObjectProperties = { textureScale: this.scale };
			skinSelector.displayObjectProperties.width = this.smallControlSize;
			skinSelector.displayObjectProperties.height = 196 * this.scale; //this.wideControlSize;
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}

		//-------------------------
		// TabBar
		//-------------------------

		/**
		 * 
		 * @param tabBar
		 */
		protected function setTabBarStyles( tabBar:TabBar ):void {

			tabBar.distributeTabSizes = true;
		}

		/**
		 * 
		 * @param tab
		 */
		protected function setTabStyles( tab:ToggleButton ):void {

			var defaultSkin:Quad = new Quad( this.controlSize, this.controlSize, TAB_BACKGROUND_COLOR );
			tab.defaultSkin = defaultSkin;

			var downSkin:Scale9Image = new Scale9Image( this.tabDownSkinTextures, this.scale );
			tab.downSkin = downSkin;

			var defaultSelectedSkin:Scale9Image = new Scale9Image( this.tabSelectedSkinTextures, this.scale );
			tab.defaultSelectedSkin = defaultSelectedSkin;

			var disabledSkin:Quad = new Quad( this.controlSize, this.controlSize, TAB_DISABLED_BACKGROUND_COLOR );
			tab.disabledSkin = disabledSkin;

			var selectedDisabledSkin:Scale9Image = new Scale9Image( this.tabSelectedDisabledSkinTextures, this.scale );
			tab.selectedDisabledSkin = selectedDisabledSkin;

			tab.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			tab.defaultSelectedLabelProperties.elementFormat = this.lightUIElementFormat;
			tab.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			tab.selectedDisabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;

			tab.paddingTop = this.xSmallGutterSize;
			tab.paddingBottom = this.smallGutterSize;
			tab.paddingLeft = this.gutterSize;
			tab.paddingRight = this.gutterSize;
			tab.gap = this.smallGutterSize;
			tab.minGap = this.smallGutterSize;
			tab.minWidth = tab.minHeight = this.controlSize;
			tab.minTouchWidth = tab.minTouchHeight = Math.round(this.controlSize * this.controlTouchBoundaryScale);
		}

		//-------------------------
		// TextArea
		//-------------------------

		/**
		 * 
		 * @param textArea
		 */
		protected function setTextAreaStyles( textArea:TextArea ):void {

			this.setScrollerStyles( textArea );

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundInsetSkinTextures;
			skinSelector.setValueForState( this.backgroundDisabledSkinTextures, TextArea.STATE_DISABLED );
			skinSelector.setValueForState( this.backgroundFocusedSkinTextures, TextArea.STATE_FOCUSED );
			skinSelector.displayObjectProperties = { width: this.wideControlSize, height: this.controlSize * 2, textureScale: this.scale };
			textArea.stateToSkinFunction = skinSelector.updateValue;

			textArea.padding = this.smallGutterSize;

			textArea.textEditorProperties.textFormat = this.scrollTextTextFormat;
			textArea.textEditorProperties.disabledTextFormat = this.scrollTextDisabledTextFormat;
		}

		//-------------------------
		// TextInput
		//-------------------------

		/**
		 * 
		 * @param input
		 */
		protected function setBaseTextInputStyles( input:TextInput ):void {
 
			var alteredScale:Number =1
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			/*skinSelector.defaultValue = this.backgroundInsetSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, TextInput.STATE_DISABLED);
			skinSelector.setValueForState(this.backgroundFocusedSkinTextures, TextInput.STATE_FOCUSED);
			*/
			skinSelector.defaultValue = skin_text_input; 
			skinSelector.setValueForState( skin_text_input, TextInput.STATE_DISABLED );
			skinSelector.setValueForState( skin_text_input_focus, TextInput.STATE_FOCUSED );

			skinSelector.displayObjectProperties = { width: this.wideControlSize, 
				height: this.controlSize, 
				textureScale: alteredScale};
			
			input.stateToSkinFunction = skinSelector.updateValue;

			input.minWidth = this.controlSize;
			input.minHeight = this.controlSize;
			input.minTouchWidth = Math.round(this.controlSize * this.controlTouchBoundaryScale);
			input.minTouchHeight = Math.round(this.controlSize * this.controlTouchBoundaryScale);
			input.gap = this.smallGutterSize;
			 
			//input.padding = this.smallGutterSize;
			input.paddingTop = this.xSmallGutterSize;
			input.paddingLeft = roundToNearest(this.gutterSize);
			input.paddingRight = roundToNearest(this.smallGutterSize);
			input.textEditorProperties.fontFamily = "Helvetica";
			input.textEditorProperties.fontSize = this.regularFontSize;
			input.textEditorProperties.color = DARK_TEXT_COLOR;
			input.textEditorProperties.disabledColor = DISABLED_TEXT_COLOR;

			//input.promptProperties.elementFormat = this.largeDarkElementFormat;
			
			input.promptProperties.elementFormat = this.darkElementFormat; 
			input.promptProperties.disabledElementFormat = this.disabledElementFormat;
			input.promptProperties.alpha=.6;
			 
			// IMPORTANT: recommended for object pooling
			input.resetObjectFunction = BaseFlatThemePoolFunctions.resetTextInputObject;
		}

		/**
		 * 
		 * @param input
		 */
		protected function setTextInputStyles( input:TextInput ):void {

			this.setBaseTextInputStyles( input );
			
			
		}
		
		/**
		 * 
		 * @param input
		 */
		protected function setTextInputTransparentStyles( input:TextInput ):void {
			
			this.setBaseTextInputStyles( input );
			
			input.stateToSkinFunction = null;
			
			input.textEditorProperties.color =DARK_TEXT_COLOR;
			input.textEditorProperties.disabledColor = DARK_DISABLED_TEXT_COLOR;
			 
			input.promptProperties.alpha=.8;
			input.promptProperties.elementFormat = this.darkUIElementFormat;
			input.promptProperties.disabledElementFormat = this.darkUIDisabledElementFormat;
			
		}
		
		/**
		 * 
		 * @param input
		 */
		protected function setTextInputSemiTransparentStyles( input:TextInput ):void {
			
			this.setBaseTextInputStyles( input );
			
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			 
			skinSelector.defaultValue = skin_text_input_semi; 
			skinSelector.setValueForState( skin_text_input_semi, TextInput.STATE_DISABLED );
			skinSelector.setValueForState( skin_text_input_focus_semi, TextInput.STATE_FOCUSED );
			
			skinSelector.displayObjectProperties = { width: this.wideControlSize, 
				height: this.controlSize, 
				textureScale: this.scale * this.adHocScaleReduction};
			
			input.stateToSkinFunction = skinSelector.updateValue;
			
			input.textEditorProperties.color =LIGHT_TEXT_COLOR;
			input.textEditorProperties.disabledColor = DISABLED_TEXT_COLOR;
			 
			
			input.promptProperties.alpha=1;
			input.promptProperties.elementFormat = this.lightUIElementFormat;
			input.promptProperties.disabledElementFormat = this.disabledElementFormat;
		}

		/**
		 * 
		 * @param input
		 */
		protected function setSearchTextInputStyles( input:TextInput ):void {

			this.setBaseTextInputStyles( input );

			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.setValueTypeHandler( SubTexture, textureValueTypeHandler );
			iconSelector.defaultValue = this.searchIconTexture;
			iconSelector.setValueForState( this.searchIconDisabledTexture, TextInput.STATE_DISABLED, false );
			iconSelector.displayObjectProperties = { textureScale: this.scale, snapToPixels: true }
			input.stateToIconFunction = iconSelector.updateValue;
		}
		
		/**
		 * 
		 * @param input
		 */
		protected function setSearchTextInputSemiStyles( input:TextInput ):void {
			
			this.setTextInputSemiTransparentStyles(input);
			
			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.setValueTypeHandler( SubTexture, textureValueTypeHandler );
			iconSelector.defaultValue = this.searchIconTexture;
			iconSelector.setValueForState( this.searchIconDisabledTexture, TextInput.STATE_DISABLED, false );
			iconSelector.displayObjectProperties = { textureScale: this.scale, snapToPixels: true }
			input.stateToIconFunction = iconSelector.updateValue;
		}

		//-------------------------
		// ToggleSwitch
		//-------------------------

		/**
		 * 
		 * @param toggle
		 */
		protected function setToggleSwitchStyles( toggle:ToggleSwitch ):void {

			toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;
			 
			toggle.defaultLabelProperties.elementFormat = this.smallLightElementFormat;
			toggle.onLabelProperties.elementFormat = this.smallLightElementFormat; //this.selectedUIElementFormat;
			toggle.disabledLabelProperties.elementFormat = this.smallDisabledElementFormat; //this.lightUIDisabledElementFormat;

			toggle.paddingRight = Math.round(this.xSmallGutterSize/2);
			toggle.paddingLeft = Math.round(this.xSmallGutterSize/2);// + Math.round( 2 * this.scale );
		}

		//see Shared section for thumb styles

		/**
		 * 
		 * @param track
		 */
		protected function setToggleSwitchTrackStyles( track:Button ):void {

			var overrideControlSize:Number = Math.round(this.controlSize * .90);
			
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();

			skinSelector.defaultValue = buttonCallToActionUpSkinTextures;

			skinSelector.setValueForState( buttonDisabledSkinTextures, Button.STATE_DISABLED, false )
			skinSelector.displayObjectProperties =
				{ width: Math.round( this.controlSize * 2 ), height: overrideControlSize, textureScale: this.scale };
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}

		/**
		 * A subclass may embed the theme's assets and override this setter to
		 * return the class that creates the bitmap used for the texture atlas.
		 */
		protected function get atlasImageClass():Class {

			return null;
		}

		/**
		 * A subclass may embed the theme's assets and override this setter to
		 * return the class that creates the XML used for the texture atlas.
		 */
		protected function get atlasXMLClass():Class {

			return null;
		}
		
		//-------------------------
		// SpinnerList
		//-------------------------
		
		protected function setSpinnerListStyles(list:SpinnerList):void
		{
			this.setScrollerStyles(list);
			//list.backgroundSkin = new Scale9Image(this.spinnerListBackgroundSkinTextures, this.scale);
			list.customItemRendererStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER;
			list.selectionOverlaySkin = new Scale9Image(this.spinnerListSelectionOverlaySkinTextures, this.scale);
			
			/*this.setListStyles(list);
			list.customItemRendererStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER;
			
			list.selectionOverlaySkin = new Scale9Image(this.spinnerListSelectionOverlaySkinTextures, this.scale);
			*/
			// Pooling
			list.resetObjectFunction = BaseFlatThemePoolFunctions.resetSpinnerListObject;
		}
		
		protected function setSpinnerListItemRendererStyles(renderer:DefaultListItemRenderer):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.displayObjectProperties =
				{
					width: this.itemRendererMinSize,
						height: this.itemRendererMinSize,
						textureScale: this.scale
				};
			renderer.stateToSkinFunction = skinSelector.updateValue;
			
			renderer.defaultLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.gap = this.gutterSize;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.gutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = this.itemRendererMinSize;
			renderer.minHeight = this.itemRendererMinSize;
			renderer.minTouchWidth = this.itemRendererMinSize;
			renderer.minTouchHeight = this.itemRendererMinSize;
			
			renderer.accessoryLoaderFactory = this.imageLoaderFactory_noSmoothing;
			renderer.iconLoaderFactory = this.imageLoaderFactory_noSmoothing;
		}
		
		
		/////////////////////////////
		// Newly added
		/////////////////////////////
		
		/**
		 * @private
		 * The theme's custom style name for the label text renderer of an item
		 * renderer with the "check" style.
		 */
		protected static const THEME_STYLE_NAME_CHECK_ITEM_RENDERER_LABEL:String = "metal-works-mobile-check-item-renderer-label";
		
		/**
		 * @private
		 * The theme's custom style name for the icon label text renderer of an
		 * item renderer with the "check" style.
		 */
		protected static const THEME_STYLE_NAME_CHECK_ITEM_RENDERER_ICON_LABEL:String = "metal-works-mobile-check-item-renderer-icon-label";
		
		/**
		 * @private
		 * The theme's custom style name for the accessory label text renderer
		 * of an item renderer with the "check" style.
		 */
		protected static const THEME_STYLE_NAME_CHECK_ITEM_RENDERER_ACCESSORY_LABEL:String = "metal-works-mobile-check-item-renderer-accessory-label";

		
		//-------------------------
		// PickerList
		//-------------------------
		
		protected function setPickerListStyles(list:PickerList):void
		{
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.popUpContentManager = new CalloutPopUpContentManager();
			}
			else
			{
				list.listFactory = pickerListSpinnerListFactory;
				// Ahhender Changes: 
				list.popUpContentManager = new CustomBottomDrawerPopUpManager(); 
			}
			
			// Ahhender Changes: 
			list.resetObjectFunction = BaseFlatThemePoolFunctions.resetPickerListObject;
		}
		
		protected function setPickerListPopUpListStyles(list:List):void
		{
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.minWidth = this.popUpFillSize;
				list.maxHeight = this.popUpFillSize;
			}
			else //phone
			{
				//the pop-up list should be a SpinnerList in this case, but we
				//should provide a reasonable fallback skin if the listFactory
				//on the PickerList returns a List instead. we don't want the
				//List to be too big for the BottomDrawerPopUpContentManager
				
				var backgroundSkin:Scale9Image = new Scale9Image(this.backgroundSkinTextures, this.contentScaleFactor);
				backgroundSkin.width = this.gridSize;
				backgroundSkin.height = this.gridSize;
				list.backgroundSkin =  backgroundSkin;
				list.padding = this.smallGutterSize;
				
				var layout:VerticalLayout = new VerticalLayout();
				layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
				layout.requestedRowCount = 4;
				list.layout = layout;
			}
			
			list.customItemRendererStyleName = DefaultListItemRenderer.ALTERNATE_STYLE_NAME_CHECK;
		}
		
		protected function setPickerListButtonStyles(button:Button):void
		{
			this.setButtonStyles(button);
			
			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.setValueTypeHandler(SubTexture, textureValueTypeHandler);
			iconSelector.defaultValue = this.pickerListButtonIconTexture;
			iconSelector.setValueForState(this.pickerListButtonIconDisabledTexture, Button.STATE_DISABLED, false);
			iconSelector.displayObjectProperties =
				{
					textureScale: this.contentScaleFactor,
						snapToPixels: true
				}
			button.stateToIconFunction = iconSelector.updateValue;
			
			button.gap = Number.POSITIVE_INFINITY;
			button.minGap = this.gutterSize;
			button.iconPosition = Button.ICON_POSITION_RIGHT;
		}
		
		//-------------------------
		// List
		//-------------------------

		protected function setCheckItemRendererStyles(renderer:BaseDefaultItemRenderer):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
				{
					width: this.gridSize,
						height: this.gridSize,
						textureScale: this.scale
				};
			renderer.stateToSkinFunction = skinSelector.updateValue;
			
			var defaultSelectedIcon:ImageLoader = new ImageLoader();
			defaultSelectedIcon.source = this.pickerListItemSelectedIconTexture;
			defaultSelectedIcon.textureScale = this.scale;
			renderer.defaultSelectedIcon = defaultSelectedIcon;
			defaultSelectedIcon.validate();
			
			var defaultIcon:Quad = new Quad(defaultSelectedIcon.width, defaultSelectedIcon.height, 0xff00ff);
			defaultIcon.alpha = 0;
			renderer.defaultIcon = defaultIcon;
			
			renderer.customLabelStyleName = THEME_STYLE_NAME_CHECK_ITEM_RENDERER_LABEL;
			renderer.customIconLabelStyleName = THEME_STYLE_NAME_CHECK_ITEM_RENDERER_ICON_LABEL;
			renderer.customAccessoryLabelStyleName = THEME_STYLE_NAME_CHECK_ITEM_RENDERER_ACCESSORY_LABEL;
			
			renderer.itemHasIcon = false;
			renderer.horizontalAlign = BaseDefaultItemRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.gap = Number.POSITIVE_INFINITY;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = BaseDefaultItemRenderer.ICON_POSITION_RIGHT;
			renderer.accessoryGap = this.smallGutterSize;
			renderer.minAccessoryGap = this.smallGutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_BOTTOM;
			renderer.layoutOrder = BaseDefaultItemRenderer.LAYOUT_ORDER_LABEL_ACCESSORY_ICON;
			renderer.minWidth = this.gridSize;
			renderer.minHeight = this.gridSize;
			renderer.minTouchWidth = this.gridSize;
			renderer.minTouchHeight = this.gridSize;
		}
	}
}

