//------------------------------------------------------------------------------
//
//   Anthony Henderson  Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.helpers {

	import feathers.controls.Button;
	import feathers.controls.DateTimeSpinner;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.PickerList;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_StyleNameConstants;
	import feathers.extension.ahhenderson.controls.DateTimePicker;
	import feathers.extension.ahhenderson.controls.TitledTextBlock;
	import feathers.extension.ahhenderson.controls.renderers.HorizontalTitledTextBlockItemRenderer;
	import feathers.extension.ahhenderson.controls.renderers.VerticalTitledTextBlockItemRenderer;
	import feathers.extension.ahhenderson.controls.renderers.base.BaseTitledTextBlockItemRenderer;
	import feathers.extension.ahhenderson.enums.CustomComponentPoolType;
	import feathers.extension.ahhenderson.enums.FeathersComponentPoolType;
	import feathers.extension.ahhenderson.themes.constants.FlatThemeCustomTextures;
	import feathers.extension.ahhenderson.themes.pool.BaseFlatThemePoolFunctions;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.ILayoutData;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.display.Quad;
	import starling.textures.TextureSmoothing;


	public class UiFactoryHelper {

		include "_Helpers.inc";

		public static function buttonFactory( label:String = null, customStyleName:String = null, upIcon:String=null, downIcon:String=null ):Button {

			var button:Button = fmgr.pool.borrowObj( FeathersComponentPoolType.BUTTON );
 
			if ( label )
				button.label = label;
			
			if ( customStyleName )
				button.styleNameList.add( customStyleName );
			
			if ( upIcon ){
				button.defaultIcon = AssetHelper.getImage(upIcon);
				
				if(!downIcon)
					downIcon = upIcon;
			}
				
			if ( downIcon ){
				button.downIcon = AssetHelper.getImage(downIcon);
				button.downIcon.alpha = .6;
			}
			
			

			return button;
		}

		public static function headerFactory( title:String = null, 
											  customStyleName:String = FeathersExtLib_StyleNameConstants.HEADER__SUB_HEADER_TRANSPARENT_LIGHT,
		layoutData:ILayoutData=null):Header {
			
			var control:Header = fmgr.pool.borrowObj( FeathersComponentPoolType.HEADER ) as Header;
			
			if ( customStyleName ) {
				control.styleNameList.add( customStyleName );
			}
			
			if ( title ) {
				control.title = title;
			}
			
			if ( layoutData ) {
				control.layoutData = layoutData;
			}
			
			return control;
		}
		
		public static function defaultFooterFactory( title:String = null, customStyleName:String = null ):Header {

			var footer:Header = fmgr.pool.borrowObj( FeathersComponentPoolType.HEADER ) as Header;

			if ( customStyleName ) {
				footer.styleNameList.add( customStyleName );
			}

			if ( title ) {
				footer.title = title;
			}
			return footer;
		}

		public static function defaultItemRendererFactory( labelField:String = "labelField" ):IListItemRenderer {

			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = labelField;
			renderer.isQuickHitAreaEnabled = true;
			return renderer;
		}

		public static function defaultGroupedListFactory( visible:Boolean = true, selectable:Boolean = false, hasElasticEdges:Boolean = false):GroupedList {
			
			var control:GroupedList = new GroupedList();
			control.visible = visible;
			control.isSelectable = selectable;
			control.hasElasticEdges = hasElasticEdges 
			
			return control;
		}
		
		 
		
		public static function defaultListFactory( visible:Boolean = true, selectable:Boolean = false, hasElasticEdges:Boolean = false):List {
			
			var list:List = new List();
			list.visible = visible;
			list.isSelectable = selectable;
			list.hasElasticEdges = hasElasticEdges 
			
			return list;
		}
		
		public static function formControlListFactory( visible:Boolean = true, selectable:Boolean = false, hasElasticEdges:Boolean = false,
													   itemRenderFactory:Function = null ):List {

			var list:List = new List();
			list.visible = visible;
			list.isSelectable = selectable;
			list.hasElasticEdges = hasElasticEdges
			list.itemRendererFactory = ( itemRenderFactory ) ? itemRenderFactory : UiFactoryHelper.formLabelItemRendererFactory;

			return list;
		}

		public static function formLabelItemRendererFactory( labelField:String = "labelField" ):IListItemRenderer {

			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = labelField;
			renderer.isQuickHitAreaEnabled = false;
			renderer.styleNameList.add( FeathersExtLib_StyleNameConstants.FORM_LABEL_LIST_ITEM_RENDERER );
			return renderer;
		}

		public static function imageLoaderFactory( noSmoothing:Boolean = false ):ImageLoader {

			var image:ImageLoader = new ImageLoader(); //fmgr.pool.borrowObj(FeathersComponentPoolType.IMAGE_LOADER);

			image.textureScale = 1; //fmgr.theme.scaledResolution;

			if ( noSmoothing )
				image.smoothing = TextureSmoothing.NONE;

			//image.resetObjectFunction = BaseFlatThemePoolFunctions.resetImageLoaderObject;

			return image;
		}

		
		public static function horizontalTitledTextBlockItemRendererFactory():IListItemRenderer{
			
			return baseTitledTextBlockItemRendererFactory(HorizontalTitledTextBlockItemRenderer.HORIZONTAL_LAYOUT_TYPE,
				FeathersExtLib_StyleNameConstants.TITLED_TEXTBOX__DARK_STYLES);
		}
		
		public static function verticalTitledTextBlockItemRendererFactory():IListItemRenderer{
			
			return baseTitledTextBlockItemRendererFactory(VerticalTitledTextBlockItemRenderer.VERTICAL_LAYOUT_TYPE,
				FeathersExtLib_StyleNameConstants.TITLED_TEXTBOX__DARK_STYLES);
		}
		
		private static function baseTitledTextBlockItemRendererFactory( layoutType:String=null, 
																   customStyleName:String=null, 
																   isQuickHitAreaEnabled:Boolean=true,
												customProperties:Object = null):IListItemRenderer {
			
			var renderer:IListItemRenderer; 
			 
			switch(layoutType){
				
				case HorizontalTitledTextBlockItemRenderer.HORIZONTAL_LAYOUT_TYPE:
					renderer = new HorizontalTitledTextBlockItemRenderer(); 
					break;
				
				case VerticalTitledTextBlockItemRenderer.VERTICAL_LAYOUT_TYPE:
					renderer = new VerticalTitledTextBlockItemRenderer(); 
					break;
				
				default:
					renderer = new HorizontalTitledTextBlockItemRenderer();
					break;
			}
			
			if(!customStyleName) 
				customStyleName = FeathersExtLib_StyleNameConstants.TITLED_TEXTBOX__DARK_STYLES;
			 
			
			(renderer  as BaseTitledTextBlockItemRenderer).customTitleTextBlockStylename = customStyleName;
			(renderer  as BaseTitledTextBlockItemRenderer).isQuickHitAreaEnabled = isQuickHitAreaEnabled;
			
			return renderer;
		}
		
		public static function panelFactory( title:String = null, customHeaderFactory:String = null ):Panel {

			var panel:Panel = new Panel(); //fmgr.pool.borrowObj(FeathersComponentPoolType.IMAGE_LOADER);

			/*if(customHeaderFactory)
				panel.customHeaderStyleName = (customHeaderFactory) ? customHeaderFactory : CustomFlatTheme.PANEL_HEADER__DARK_TITLE;
			*/
			if ( title )
				panel.title = title;

			return panel;
		}

		public static function pickerListFactory( customStyleName:String = null,  
												  labelField:String = "labelField", 
												  typicalItem:String ="XXXXXXXXX", 
												  itemRendererFactory:IListItemRenderer = null,  
												  prompt:String = "Select an Item", 
												  listHeight:int = 250 ):PickerList {
			
			var control:PickerList = fmgr.pool.borrowObj( FeathersComponentPoolType.PICKER_LIST );
			
			// Defaults 
			control.listProperties.itemRendererFactory = UiFactoryHelper.defaultItemRendererFactory;
			control.styleNameList.add( FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_DARK );
			
			if ( customStyleName ) {
				control.styleNameList.add( customStyleName );
			}
			
			if ( itemRendererFactory ) {
				control.listProperties.itemRendererFactory = UiFactoryHelper.defaultItemRendererFactory;
			}
			
			// Defined
			control.prompt = prompt;
			control.labelField = labelField;
			control.listProperties.typicalItem = typicalItem;
			control.listProperties.height = listHeight * fmgr.theme.scaledResolution;
			
			return control;
		}
		
		private static function navigationButtonFactory(control:Button,
														label:String, 
														customStyle:String=Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON, 
														icon:String=FlatThemeCustomTextures.ICONS_CONTROL_BUTTON_BACK,
														horizontalPosition:String = Button.HORIZONTAL_ALIGN_LEFT,
														iconPosition:String = Button.ICON_POSITION_LEFT,
														gap:int=0, 
														minWidth:int=100):void{
		
			control.styleNameList.add(customStyle); 
			control.minWidth = minWidth * fmgr.theme.scaledResolution;
			control.gap=gap;
			control.label = label;
			control.paddingLeft=gap; 
			control.defaultIcon = AssetHelper.getImage(icon);
			control.horizontalAlign = horizontalPosition;
			control.iconPosition = iconPosition;
		}
		
		
		public static function backButtonFactory(label:String="Back", 
												 customStyle:String=Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON, 
												 icon:String=FlatThemeCustomTextures.ICONS_CONTROL_BUTTON_BACK,
												 gap:int=0, 
												 minWidth:int=100):Button{
			
			var control:Button = fmgr.pool.borrowObj(FeathersComponentPoolType.BUTTON); 
			 
			navigationButtonFactory(control, 
				label, 
				customStyle, 
				icon, 
				Button.HORIZONTAL_ALIGN_LEFT,
				Button.ICON_POSITION_LEFT,
				gap, 
				minWidth);
			 
			return control;
		}
		
		public static const HORIZONTAL_SPACER:Number = 20;
		public static const VERTICAL_SPACER:Number = 20;
		
		public static function horizontalSpacerFactory(height:Number=HORIZONTAL_SPACER):Quad{
	 
			var value:int = height*fmgr.theme.scaledResolution;
			var spacer:Quad = new Quad(10, value);
			spacer.visible = false;
			 
			return spacer;
		}
		
		public static function verticalSpacerFactory(width:int=VERTICAL_SPACER):Quad{
			 
			var value:int = width*fmgr.theme.scaledResolution;
			var spacer:Quad = new Quad(value, 10);
			spacer.visible = false;
			
			return spacer;
		}
		
		
		public static function nextButtonFactory(label:String="Next", 
												 customStyle:String=Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON, 
												 icon:String=FlatThemeCustomTextures.ICONS_CONTROL_BUTTON_FORWARD,
												 gap:int=0, 
												 minWidth:int=20):Button{
			
			var control:Button = fmgr.pool.borrowObj(FeathersComponentPoolType.BUTTON); 
			
			navigationButtonFactory(control, 
				label, 
				customStyle, 
				icon, 
				Button.HORIZONTAL_ALIGN_RIGHT,
				Button.ICON_POSITION_RIGHT,
				gap, 
				minWidth);
			
			return control;
		}
		
		public static function dateTimePickerFactory( customStyleName:String = null,  
												  editMode:String = DateTimePicker.DISPLAY_DATE_MMM_DD_YYYY,
												  labelField:String = "labelField", 
												  itemRendererFactory:IListItemRenderer = null,   
												  prompt:String = null, 
												  contentHeight:int = 250 ):DateTimePicker {

			var control:DateTimePicker = fmgr.pool.borrowObj( CustomComponentPoolType.DATE_TIME_PICKER );

			// Defaults 
			//control.listProperties.itemRendererFactory = UiFactoryHelper.defaultItemRendererFactory;
			control.styleNameList.add( FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_DARK );

			if ( customStyleName ) {
				control.styleNameList.add( customStyleName );
			}

			/*if ( itemRendererFactory ) {
				control.listProperties.itemRendererFactory = UiFactoryHelper.defaultItemRendererFactory;
			}*/

			// Defined
			if(!prompt){
				switch(control.editingMode){
					
					case DateTimeSpinner.EDITING_MODE_DATE:
						prompt = "Select Date";
						break;
					
					case DateTimeSpinner.EDITING_MODE_DATE_AND_TIME:
						prompt = "Select Date/Time";
						break;
					case DateTimeSpinner.EDITING_MODE_TIME:
						prompt = "Select Time";
						break;
					default:
						prompt = "Select Date";
						break;
				}
			}
			
			control.prompt = prompt;
			control.labelField = labelField;
			control.pickerContentProperties.height = contentHeight * fmgr.theme.scaledResolution;
			 
			return control;
		}

		public static function screenNavigatorFactory( transitionDuration:Number = 0.2, clipContent:Boolean = true ):ScreenNavigator {

			// Get from Pool
			var navigator:ScreenNavigator = fmgr.pool.borrowObj( FeathersComponentPoolType.SCREEN_NAVIGATOR );
			navigator.clipContent = clipContent;

			// Set transition
			var transitionManager:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager( navigator );
			transitionManager.duration = transitionDuration;

			// Set reset function 
			navigator.resetObjectFunction = BaseFlatThemePoolFunctions.resetScreenNavigatorObject;

			return navigator;
		}

		public static function scrollingFooterFactor():ScrollContainer {

			var container:ScrollContainer = new ScrollContainer();
			container.styleNameList.add( ScrollContainer.ALTERNATE_STYLE_NAME_TOOLBAR );
			container.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			container.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			return container;

		}

		public static function textInputFactory( prompt:String = null, maxChars:int = -1, restrict:String = null, isPassword:Boolean =
			false, customStyleName:String = null ):TextInput {

			var textInput:TextInput = fmgr.pool.borrowObj( FeathersComponentPoolType.TEXT_INPUT );

			if ( maxChars > 0 )
				textInput.maxChars = maxChars;

			if ( prompt )
				textInput.prompt = prompt;

			if ( restrict )
				textInput.restrict = restrict;

			if ( isPassword )
				textInput.displayAsPassword = true;

			if ( customStyleName )
				textInput.styleNameList.add( customStyleName );

			return textInput;
		}

		public static function titledTextBlockFactory( title:String, content:String, layoutData:AnchorLayoutData = null,
													   autoSizeMode:String = "stage" ):TitledTextBlock {

			// Add Text block  
			var control:TitledTextBlock = new TitledTextBlock(); //fmgr.pool.borrowObj( CustomComponentPoolType.TITLED_TEXT_BLOCK );

			// Either 'stage', 'content'
			control.autoSizeMode = autoSizeMode;

			if ( !layoutData ) {
				control.layoutData = new AnchorLayoutData( NaN, NaN, NaN, NaN, 0, 0 );
			}

			control.title = title;
			control.content = content;

			return control;

		}
	}
}
