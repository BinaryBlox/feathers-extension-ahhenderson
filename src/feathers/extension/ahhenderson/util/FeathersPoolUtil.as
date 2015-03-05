package feathers.extension.ahhenderson.util {
	import feathers.core.FeathersControl;
	
	import starling.display.DisplayObject;

	public class FeathersPoolUtil {
		public function FeathersPoolUtil() {
		}

		public static function forceDisposeOfPooledObjects(value:Vector.<DisplayObject>, resetObjectFunction:Function=null):void{
			var i:int = value.length;
			
			trace("HERE - disposeDisplayObjectVector");
			while(i--){
				
				if(value[i] is FeathersControl){
					
					if(!(value[i] as FeathersControl).isPooled)
						return;
					
					if(resetObjectFunction)
						(value[i] as FeathersControl).resetObjectFunction = resetObjectFunction;
					 
					(value[i] as FeathersControl).dispose();
					trace("Removing feathers control");
				}
				else{
					value[i].dispose();
				}
				
			}
			
		}
	}
}
