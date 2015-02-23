package feathers.extension.ahhenderson.controls.core
{
	import flash.events.UncaughtErrorEvent;
	
	import ahhenderson.core.starling.controls.core.StarlingApplication;
	
	import feathers.extension.ahhenderson.helpers.DialogHelper;
	import feathers.extension.ahhenderson.managers.dependency.themeManager.interfaces.IManagedTheme;
	
	import starling.core.Starling;
	
	/*[Event(name="feathersApplicationComplete", type="starling.events.Event")] */
	public class FeathersApplication extends StarlingApplication
	{
		
		include "../../_includes/_FeathersAppManager.inc";
		
		public function FeathersApplication(debug:Boolean=false)
		{  
			super(debug);
			
			this.fmgr.initialize(debug);
		}
		
		 
		public static const FEATHERS_APPLICATION_COMPLETE_EVENT:String ="feathersApplicationComplete";
		
		  
		override protected function onRootContainerCreated(event:Object, rootContainer:*):void{
			
			if(!(rootContainer as FeathersRootContainer)){
				throw new Error( "FeathersApplication starling_rootCreatedHandler() method: rootView must be of BaseRootView type." );
			}
			
			initializeTheme(rootContainer as FeathersRootContainer);
			
			// Store default screen (if it exists)
			this.fmgr.navigation.defaultScreenId = this.defaultScreenId();
			 
		} 
		
		override protected function onUncaughtError( e:UncaughtErrorEvent ):void {
			
			if(!this.fmgr.theme.isLoaded)
				return;
			
			//this suppresses the error dialogue
			e.preventDefault();
			
			DialogHelper.showAlert(( e.error as Error ).name, ( e.error as Error ).message); 
			
		} 
		
		protected function defaultScreenId():String {
			
			throw new Error( "Override FeathersApplication defaultScreenId() method" );
			
		}
		
		protected function defaultTheme():IManagedTheme{
			
			throw new Error( "Override FeathersApplication defaultTheme() method" );
			
		}
		 
		protected function initializeTheme(rootContainer:FeathersRootContainer):void{
			
			this.fmgr.theme.initialize(rootContainer,  defaultTheme(), Starling.current.nativeStage, 1, true);
			
			rootContainer.loadTheme();
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