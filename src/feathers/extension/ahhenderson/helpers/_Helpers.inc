import feathers.extension.ahhenderson.managers.FeathersApplicationManager;

private static var _fmgr:FeathersApplicationManager;

		
private static function get fmgr():FeathersApplicationManager
{
	if(!_fmgr)
		_fmgr = FeathersApplicationManager.instance;
	
	return _fmgr;
}