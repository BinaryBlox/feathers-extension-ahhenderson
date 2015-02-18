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
		
		private var _fmgr:FeathersApplicationManager;
		
		protected function get fmgr():FeathersApplicationManager
		{
			if(!_fmgr)
				_fmgr = FeathersApplicationManager.instance;
			
			return _fmgr;
		}
	}
}