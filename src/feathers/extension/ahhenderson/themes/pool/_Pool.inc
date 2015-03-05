
import feathers.core.IFeathersControl;
import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
import flash.text.engine.ElementFormat;

private static var _fmgr:FeathersApplicationManager;

		
private static function get fmgr():FeathersApplicationManager
{
	if(!_fmgr)
		_fmgr = FeathersApplicationManager.instance;
	
	return _fmgr;
}

private static function removeStyles(input:IFeathersControl):void{
	  
	// Remove custom style names
	if(input.styleName.length >0){
		var styles:Array = input.styleName.split(" ");
		
		var test:String = "";
		
		for (var i:int=0;i<styles.length;i++){
			
			//trace("Removed style: " + styles[i]);
			
			input.styleNameList.remove(styles[i]);
		}
	}  
}

public static function getThemePropertyValue(property:*, defaultValue:*=null):*{
			
	if(property)
		return property;
	
	return defaultValue
}

	private static var smallFontSize:int;
		 
	private static var mediumFontSize:int;
	 
	private static var regularFontSize:int;
	 
	private static var largeFontSize:int;
	 
	private static var extraLargeFontSize:int;
 
	private static var gridSize:int;
	 
	private static var gutterSize:int;
	 
	private static var smallGutterSize:int;
	 
	private static var largeGutterSize:int;
	 
	private static var xSmallGutterSize:int;
	 
	private static var wideControlSize:int;
	 
	private static var controlSize:int;
	 
	private static var headerSize:int;
	 
	private static var toggleControlSize:int;
	 
	private static var smallControlSize:int;
	 
	private static var popUpFillSize:int;
	 
	private static var calloutBackgroundMinSize:int;
	 
	private static var scrollBarGutterSize:int;
	 
	private static var actionElementFormat:ElementFormat;
	 
	private static var actionUIElementFormat:ElementFormat;
	 
	private static var adHocScaleReduction:Number;
	 
	private static var controlTouchBoundaryScale:Number;
	 
	private static var itemRendererMinSize:Number;
	
	// THEME PADDING
	private static var buttonPaddingTop:Number;
	
	private static var buttonPaddingBottom:Number;
	
	private static var buttonPaddingLeft:Number;
	
	private static var buttonPaddingRight:Number;
	
	private static var itemPaddingTop:Number;
	
	private static var itemPaddingBottom:Number;
	
	/**
	 * Initializes common values used for setting the dimensions of components.
	 */
	public static function initializeDimensions(themeProperties:Object, scale:Number):void {
		
		//***************************************
		// Theme Dimensions
		//***************************************
		
		
		// THEME PADDINGS 
		buttonPaddingTop = getThemePropertyValue(Math.round(themeProperties.BUTTON_PADDING_TOP * scale ), Math.round( 4 * scale ));
		buttonPaddingBottom = getThemePropertyValue(Math.round(themeProperties.BUTTON_PADDING_BOTTOM * scale ), Math.round( 4 * scale ));
		buttonPaddingRight = getThemePropertyValue(Math.round(themeProperties.BUTTON_PADDING_RIGHT * scale ), Math.round( 8 * scale ));
		buttonPaddingLeft = getThemePropertyValue(Math.round(themeProperties.BUTTON_PADDING_LEFT * scale ), Math.round( 8 * scale ));
		
		itemPaddingTop = getThemePropertyValue(Math.round(themeProperties.ITEM_PADDING_TOP * scale ));
		itemPaddingBottom = getThemePropertyValue(Math.round(themeProperties.ITEM_PADDING_BOTTOM * scale ));
		
		// Gutters
		xSmallGutterSize = getThemePropertyValue(Math.round(themeProperties.XSMALL_GUTTER_SIZE * scale ), Math.round( 8 * scale ));
		smallGutterSize = getThemePropertyValue(Math.round(themeProperties.SMALL_GUTTER_SIZE * scale ), Math.round( 12 * scale ));
		gutterSize = getThemePropertyValue(Math.round(themeProperties.GUTTER_SIZE * scale ), Math.round( 20 * scale ));
		largeGutterSize = getThemePropertyValue(Math.round(themeProperties.LARGE_GUTTER_SIZE * scale ), Math.round( 28 * scale ));
		scrollBarGutterSize = getThemePropertyValue(Math.round(themeProperties.SCROLLBAR_GUTTER_SIZE * scale ), Math.round( 4 * scale ));
		
		xSmallGutterSize = getThemePropertyValue(Math.round(themeProperties.XSMALL_GUTTER_SIZE * scale ), Math.round( 8 * scale ));
		smallGutterSize = getThemePropertyValue(Math.round(themeProperties.SMALL_GUTTER_SIZE * scale ), Math.round( 12 * scale ));
		gutterSize = getThemePropertyValue(Math.round(themeProperties.GUTTER_SIZE * scale ), Math.round( 20 * scale ));
		largeGutterSize = getThemePropertyValue(Math.round(themeProperties.LARGE_GUTTER_SIZE * scale ), Math.round( 28 * scale ));
		scrollBarGutterSize = getThemePropertyValue(Math.round(themeProperties.SCROLLBAR_GUTTER_SIZE * scale ), Math.round( 4 * scale ));
		
		// Controls/Containers
		gridSize = getThemePropertyValue(Math.round(themeProperties.GRID_SIZE * scale ), Math.round( 88 * scale ));
		headerSize = getThemePropertyValue(Math.round(themeProperties.HEADER_SIZE * scale ), Math.round( 66 * scale ));
		
		toggleControlSize = getThemePropertyValue(Math.round(themeProperties.TOGGLE_CONTROL_SIZE * scale ), Math.round( 60 * scale ));
		controlSize = getThemePropertyValue(Math.round(themeProperties.CONTROL_SIZE * scale ), Math.round( 60 * scale ));
		smallControlSize = getThemePropertyValue(Math.round(themeProperties.SMALL_CONTROL_SIZE * scale ), Math.round( 20 * scale ));
		popUpFillSize = getThemePropertyValue(Math.round(themeProperties.POPUP_FILL_SIZE * scale ), Math.round( 552 * scale ));
		calloutBackgroundMinSize = getThemePropertyValue(Math.round(themeProperties.CALLOUT_BACKGROUND_MIN_SIZE * scale ), Math.round( 50 * scale ));
		wideControlSize = getThemePropertyValue(Math.round(themeProperties.WIDE_CONTROL_SIZE * scale ), gridSize * 3 + gutterSize * 2);
		itemRendererMinSize = getThemePropertyValue(Math.round(themeProperties.ITEM_RENDERER_SIZE * scale ), Math.round( 70 * scale ));
		
		// Other
		adHocScaleReduction = getThemePropertyValue(themeProperties.ADHOC_REDUCTION_SIZE, 0.7);  
		controlTouchBoundaryScale = getThemePropertyValue(themeProperties.CONTROL_TOUCH_BOUNDRY_SCALE, 1.25);  
		
	}