package feathers.extension.ahhenderson.mvc.facade
{
	import ahhenderson.core.mvc.patterns.facade.AbstractFacadeView;
	
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	
	public class FeathersFacadeView extends AbstractFacadeView
	{
		public function FeathersFacadeView()
		{
			super();
		}
		
		include "../../_includes/_FeathersAppManager.inc";
		 
	}
}