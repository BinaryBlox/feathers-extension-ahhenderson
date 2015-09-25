package feathers.extension.ahhenderson.themes
{
	import flash.geom.Rectangle;
	
	import ahhenderson.core.managers.ObjectPoolManager;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.SpinnerList;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_StyleNameConstants;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_ThemeConstants;
	import feathers.extension.ahhenderson.controls.DateSelector;
	import feathers.extension.ahhenderson.controls.IconLabel;
	import feathers.extension.ahhenderson.controls.PanelNavigator;
	import feathers.extension.ahhenderson.controls.TitledTextBlock;
	import feathers.extension.ahhenderson.enums.CustomComponentPoolType;
	import feathers.extension.ahhenderson.helpers.AssetHelper;
	import feathers.extension.ahhenderson.helpers.LayoutHelper;
	import feathers.extension.ahhenderson.themes.constants.FlatThemeBaseTextures;
	import feathers.extension.ahhenderson.themes.constants.FlatThemeCustomTextures;
	import feathers.extension.ahhenderson.themes.pool.CustomFlatThemePoolFunctions;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.textures.Scale9Textures;
	import feathers.utils.math.roundToNearest;
	
	import starling.display.Quad;

	public class CustomFlatTheme extends BaseFlatTheme
	{
		public function CustomFlatTheme(properties:Object=null, scaleToDPI:Boolean=true)
		{
			super(properties, scaleToDPI);
		}
		  
		
		/**
		 * 
		 * @default 
		 */
		
		// NEW CODE
		protected var spinnerListSelectionCustomOverlaySkinTextures:Scale9Textures;
		protected static const SPINNER_LIST_SELECTION_CUSTOM_OVERLAY_SCALE9_GRID:Rectangle = new Rectangle(8, 8, 184, 84);//new Rectangle(11, 11, 2, 2);
		
		protected var buttonSocialFbUpSkinTextures:Scale9Textures;
		
		protected var buttonSocialFbDownSkinTextures:Scale9Textures;
		
		protected var buttonSocialTwitterUpSkinTextures:Scale9Textures;
		
		protected var buttonSocialTwitterDownSkinTextures:Scale9Textures;
		
		protected var buttonSocialGoogPlusUpSkinTextures:Scale9Textures;
		
		protected var buttonSocialGoogPlusDownSkinTextures:Scale9Textures;
		
		override protected function initializeStyleProviders():void{
			
			super.initializeStyleProviders();
			
			// Buttons
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.BUTTON_ALTERNATE_NAME_SOCIAL_FACEBOOK, this.setSocialFbButtonStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.BUTTON_ALTERNATE_NAME_SOCIAL_TWITTER, this.setSocialTwitterButtonStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.BUTTON_ALTERNATE_NAME_SOCIAL_GOOGLE_PLUS, this.setSocialGoogPlusButtonStyles );
			 
			// Titled Text Block
			this.getStyleProviderForClass( TitledTextBlock ).defaultStyleFunction = this.setTitledTextBlockStyles;
			
			// Date Selector
			this.getStyleProviderForClass( DateSelector ).defaultStyleFunction = this.setDateSelectorStyles;
			 
			// Icon label
			this.getStyleProviderForClass( IconLabel ).defaultStyleFunction = this.setIconLabelStyles;
			
			// PanelNavigator 
			this.getStyleProviderForClass( PanelNavigator ).defaultStyleFunction = this.setPanelNavigatorStyles;
			
			// Custom spinner 
			this.getStyleProviderForClass( SpinnerList ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.SPINNER_LIST__ALTERNATE_OVERLAY, 
				setCustomSpinnerListStyles)
			  
			// Item Renderers
			this.getStyleProviderForClass( DefaultListItemRenderer ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.FORM_LABEL_LIST_ITEM_RENDERER, 
				setItemRendererFormLabelStyles)
			this.getStyleProviderForClass( DefaultListItemRenderer ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.FORM_LABEL_LIST_DRILL_DOWN_ITEM_RENDERER, 
				setItemRendererFormLabelDrillDownStyles)
			this.getStyleProviderForClass( DefaultListItemRenderer ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.ARROW_LABEL_LIST_ITEM_RENDERER, 
				setItemRendererArrowLabelStyles)
				
			this.getStyleProviderForClass( TitledTextBlock ).setFunctionForStyleName( TitledTextBlock.TITLED_TEXT_BLOCK_ITEM_RENDERER,
				this.setTitledTextBlockItemRendererStyles );
				 
			// Header
			this.getStyleProviderForClass(Header).setFunctionForStyleName(FeathersExtLib_StyleNameConstants.HEADER_TITLED_NAVIGATOR_SCREEN, setTitledNavigationHeaderStyles);
			//this.getStyleProviderForClass( Header).setFunctionForStyleName(PANEL_HEADER__DARK_TITLE, setPanelHeaderStyles);
			
			// Dark labels
			this.getStyleProviderForClass( Label ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.LABEL_ALTERNATE_DARK_STYLE_NAME_NORMAL, this.setDarkLabelStyles );
			this.getStyleProviderForClass( Label ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.LABEL_ALTERNATE_DARK_STYLE_NAME_HEADING, this.setHeadingDarkLabelStyles );
			this.getStyleProviderForClass( Label ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.LABEL_ALTERNATE_DARK_STYLE_NAME_DETAIL, this.setDetailDarkLabelStyles ); 
			
		}

		/**
		 * Initializes the textures by extracting them from the atlas and
		 * setting up any scaling grids that are needed.
		 */
		override protected function initializeTextures():void {

			super.initializeTextures();
			
			this.buttonSocialFbUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture(FlatThemeBaseTextures.BUTTON_SOCIAL_FB_UP_SKIN), BUTTON_SCALE9_GRID);
			this.buttonSocialFbDownSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture(FlatThemeBaseTextures.BUTTON_SOCIAL_FB_DOWN_SKIN), BUTTON_SCALE9_GRID);
			 
			this.buttonSocialGoogPlusUpSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture(FlatThemeBaseTextures.BUTTON_SOCIAL_GPLUS_UP_SKIN), BUTTON_SCALE9_GRID);
			this.buttonSocialGoogPlusDownSkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture(FlatThemeBaseTextures.BUTTON_SOCIAL_GPLUS_DOWN_SKIN), BUTTON_SCALE9_GRID);
		
			this.spinnerListSelectionCustomOverlaySkinTextures = new Scale9Textures(fmgr.theme.assetManager.getTexture(FlatThemeBaseTextures.SPINNER_OVERLAY), SPINNER_LIST_SELECTION_CUSTOM_OVERLAY_SCALE9_GRID);
			
		}
	
		
		override protected function initializeObjectPools():void{
			
			super.initializeObjectPools();
			
			// For Pooling dimensions
			CustomFlatThemePoolFunctions.initializeDimensions(this.themeProperties, this.scale);
			
			ObjectPoolManager.instance.createPool( CustomComponentPoolType.TITLED_TEXT_BLOCK, null, 5 ); 
			ObjectPoolManager.instance.createPool( CustomComponentPoolType.ICON_LABEL, null, 5 ); 
		}
		
		
		//-------------------------
		// Buttons
		//-------------------------
		protected function setSocialFbButtonStyles( button:Button ):void {
			
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonSocialFbUpSkinTextures;
			skinSelector.setValueForState( this.buttonSocialFbDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;
			
			this.setBaseButtonStyles( button );
			
			button.defaultIcon = AssetHelper.getImage(FlatThemeCustomTextures.ICONS_SOCIAL_FACEBOOK);
		}
		
		protected function setSocialGoogPlusButtonStyles( button:Button ):void {
			
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonSocialGoogPlusUpSkinTextures;
			skinSelector.setValueForState( this.buttonSocialGoogPlusDownSkinTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
			skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
			button.stateToSkinFunction = skinSelector.updateValue;
			
			this.setBaseButtonStyles( button );
			 
			button.defaultIcon = AssetHelper.getImage(FlatThemeCustomTextures.ICONS_SOCIAL_GOOGLE_PLUS);
		}
		
		protected function setSocialTwitterButtonStyles( button:Button ):void {
			 
			this.setButtonStyles(button);  
			
			button.defaultIcon = AssetHelper.getImage(FlatThemeCustomTextures.ICONS_SOCIAL_TWITTER_BIRD);
		}
		
		
		//-------------------------
		// SpinnerList
		//-------------------------
		
		protected function setCustomSpinnerListStyles(list:SpinnerList):void
		{
			this.setSpinnerListStyles(list);
			  
			list.selectionOverlaySkin = new Scale9Image(this.spinnerListSelectionCustomOverlaySkinTextures, this.scale);
			 
		}
		
		//-------------------------
		// Custom
		//-------------------------
		protected function setIconLabelStyles( control:IconLabel ):void {
			
			control.touchable = false;
			control.textRendererProperties.elementFormat = this.lightElementFormat;
			
			control.resetObjectFunction = CustomFlatThemePoolFunctions.resetIconLabel;
		}
		
		protected function setTitledTextBlockItemRendererStyles( titledTextBlock:TitledTextBlock ):void {
			
			setTitledTextBlockStyles( titledTextBlock );
			
			/*titledTextBlock.titleFormat = this.fontLightItemRenderer;
			titledTextBlock.contentFormat = this.fontLightSmallDetail;*/
		}
		
		protected function setTitledTextBlockStyles( styledControl:TitledTextBlock ):void {
			
			styledControl.minWidth = 150 * this.scale;
			styledControl.minHeight = 44 * this.scale;
			styledControl.titleFormat = this.largeLightElementFormat;
			styledControl.contentFormat = this.smallLightElementFormat;
			
			
			//styledControl.titleFormat 
			/*titledTextBlock.textFontStyle = VzLabel.FONT_SMALL_SEMI_HIGHLIGHT;
			titledTextBlock.titleFontStyle = VzLabel.FONT_LARGE_DARK;
			titledTextBlock.gap = 6;*/
			/*	iconLabel.height = 150*this.scale;
			iconLabel.width = 30 * this.scale; */
			 
			styledControl.minTouchWidth = 150 * this.scale;
			styledControl.minTouchHeight = 100 * this.scale;
			
			// IMPORTANT: recommended for object pooling
			styledControl.resetObjectFunction =  CustomFlatThemePoolFunctions.resetTitledTextBlock;
		}
		
		protected function setDateSelectorStyles( styledControl:DateSelector ):void {
			//styledControl.width= roundToNearest(350* this.scale);
			styledControl.minWidth = roundToNearest(350* this.scale);
			styledControl.minHeight = roundToNearest(150* this.scale);
			
			//styledControl.resetObjectFunction =  CustomFlatThemePoolFunctions.resetDateSelectorObject(;
			 
		}
		
		protected function setPanelNavigatorStyles( styledControl:PanelNavigator ):void {
			 
			this.setPanelStyles(styledControl);
			
		}
		
		 
		
		 
		//-------------------------
		// Header
		//-------------------------
		/**
		 * 
		 * @param header
		 */
		protected function setTitledNavigationHeaderStyles( header:Header ):void {
			
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
			
			header.titleProperties.elementFormat = this.headerElementFormat;
			 
		}
		/**
		 * 
		 * @param header
		 */
		protected function setPanelHeaderStyles( header:Header ):void {
			
			setPanelScreenHeaderStyles(header);
			//setHeaderStyles(header);
			//setAlertHeaderWithoutBackgroundStyles(header);
			
			//header.titleProperties.elementFormat = this.headerElementFormatDark;
		}
		
		//-------------------------
		// Item Renderers
		//-------------------------
		
		
		protected function setItemRendererFormLabelStyles(renderer:BaseDefaultItemRenderer):void{
			
			// Text
			renderer.defaultLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeDarkElementFormat; 
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;
			 
			// Dimensions
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = FeathersExtLib_ThemeConstants.CONTROL_GUTTER/2; 
			renderer.paddingLeft = FeathersExtLib_ThemeConstants.CONTROL_GUTTER*2;
			renderer.paddingRight = FeathersExtLib_ThemeConstants.CONTROL_GUTTER*2;
			renderer.gap = FeathersExtLib_ThemeConstants.CONTROL_GUTTER;
			renderer.minWidth = renderer.minHeight = FeathersExtLib_ThemeConstants.ITEM_RENDERER_MIN_SIZE;
			
			// Touch Dimensions
			LayoutHelper.setTouchBoundaries(renderer);
			renderer.minTouchWidth = renderer.minTouchHeight = roundToNearest(FeathersExtLib_ThemeConstants.ITEM_RENDERER_MIN_SIZE * FeathersExtLib_ThemeConstants.TOUCH_BOUNDARY_MULTIPLIER);
			
			// Accessory
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
			
			// Icon
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
		}
		
		protected function setItemRendererArrowLabelStyles( renderer:BaseDefaultItemRenderer ):void {
			
			setItemRendererFormLabelStyles(renderer);
			
			/*const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultSelectedValue = this.itemRendererCustom1SelectedSkinTextures;
			skinSelector.setValueForState( this.itemRendererCustom1SelectedSkinTextures, Button.STATE_DOWN, false );
			skinSelector.displayObjectProperties = { width: 44 * this.scale, height: 30 * this.scale, textureScale: this.scale };
			
			// Update renderer to support state.
			renderer.stateToSkinFunction = skinSelector.updateValue; */
			 
		}
		
		protected function setItemRendererFormLabelDrillDownStyles( renderer:BaseDefaultItemRenderer ):void {
			
			setItemRendererFormLabelStyles(renderer);
			
			// Custom gap
			renderer.gap = roundToNearest(FeathersExtLib_ThemeConstants.CONTROL_GUTTER * 1.5);
			 
			renderer.layoutOrder = BaseDefaultItemRenderer.LAYOUT_ORDER_LABEL_ACCESSORY_ICON;
			renderer.iconPosition = Button.ICON_POSITION_RIGHT;
			renderer.iconSourceField = "drillDownIcon"; 
		}
	 
	 

		//-------------------------
		// Label
		//-------------------------
		protected function setDarkLabelStyles( label:Label ):void {
			
			setBaseLabelStyles(label);
			
			label.textRendererProperties.elementFormat = this.darkElementFormat;
			label.textRendererProperties.disabledElementFormat = this.darkUIDisabledElementFormat;  
		}
		
		protected function setHeadingDarkLabelStyles( label:Label ):void {
			
			setBaseLabelStyles(label);
			
			label.textRendererProperties.elementFormat = this.largeDarkElementFormat;
			label.textRendererProperties.disabledElementFormat = this.largeDisabledElementFormat;
		}
		
		protected function setDetailDarkLabelStyles( label:Label ):void {
			
			setBaseLabelStyles(label);
			
			label.textRendererProperties.elementFormat = this.smallDarkElementFormat;
			label.textRendererProperties.disabledElementFormat = this.smallDisabledElementFormat;
		}
		
		//-------------------------
		// PageIndicator
		//-------------------------
		
		/**
		 * 
		 * @param pageIndicator
		 */
		/*protected function setPageIndicatorStyles( pageIndicator:PageIndicator ):void {
			
			pageIndicator.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
			pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
			pageIndicator.gap = this.smallGutterSize;
			pageIndicator.padding = this.smallGutterSize / 2;
			pageIndicator.minTouchWidth = this.smallControlSize * 2
			pageIndicator.minTouchHeight = this.smallControlSize * 2;
		}*/
	}
}