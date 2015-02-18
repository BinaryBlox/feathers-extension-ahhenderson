 
import feathers.extension.ahhenderson.managers.FeathersApplicationManager;

private  var _fmgr:FeathersApplicationManager;

		
protected function get fmgr():FeathersApplicationManager
{
	if(!_fmgr)
		_fmgr = FeathersApplicationManager.instance;
	
	return _fmgr;
}
