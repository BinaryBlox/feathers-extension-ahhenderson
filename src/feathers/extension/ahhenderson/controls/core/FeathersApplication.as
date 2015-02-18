package feathers.extension.ahhenderson.controls.core
{
	import flash.events.UncaughtErrorEvent;
	
	import feathers.extension.ahhenderson.helpers.DialogHelper;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	import feathers.extension.ahhenderson.managers.dependency.themeManager.interfaces.IManagedTheme;
	
	import ahhenderson.core.starling.controls.core.StarlingApplication;
	import starling.core.Starling;
	
	/*[Event(name="feathersApplicationComplete", type="starling.events.Event")] */
	public class FeathersApplication extends StarlingApplication
	{
		public function FeathersApplication(debug:Boolean=false)
		{  
			super(debug);
			
			this.fmgr.initialize(debug);
		}
		
		private var _fmgr:FeathersApplicationManager;
		
		public static const FEATHERS_APPLICATION_COMPLETE_EVENT:String ="feathersApplicationComplete";
		
		protected function get fmgr():FeathersApplicationManager
		{  
			return FeathersApplicationManager.instance;
		}
		
		override protected function onRootCreated(event:Object, rootView:*):void{
			
			if(!(rootView as FeathersRootScreen)){
				throw new Error( "FeathersApplication starling_rootCreatedHandler() method: rootView must be of BaseRootView type." );
			}
			
			initializeTheme(rootView as FeathersRootScreen);
			 
		} 
		override protected function onUncaughtError( e:UncaughtErrorEvent ):void {
			
			if(!this.fmgr.theme.isLoaded)
				return;
			
			//this suppresses the error dialogue
			e.preventDefault();
			
			DialogHelper.showAlert(( e.error as Error ).name, ( e.error as Error ).message); 
			
		} 
		
		protected function defaultTheme():IManagedTheme{
			
			throw new Error( "Override FeathersApplication defaultTheme() method" );
			
		}
		 
		protected function initializeTheme(rootView:FeathersRootScreen):void{
			
			this.fmgr.theme.initialize(rootView,  defaultTheme(), Starling.current.nativeStage, 1, true);
			
			rootView.loadTheme();
		} 
		
		override protected function scopeClassInstances():void{
			/*
			//LoggingManager.instance;
			FacadeServiceManager.instance;
			FeathersApplicationManager.instance;
			//ObjectPoolManager.instance;
			
			FeathersApplicationManager.instance.facade;
			FeathersApplicationManager.instance.pool;
			FeathersApplicationManager.instance.logger;
			//super.registerClassDependencies();
			
*/		}
	 
		
	}
}