
import feathers.core.IFeathersControl;
import feathers.extension.ahhenderson.managers.FeathersApplicationManager;

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