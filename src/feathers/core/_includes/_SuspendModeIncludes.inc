 

import ahhenderson.core.managers.DeviceManager;
import ahhenderson.core.managers.dependency.device.enums.SuspendModeTypeEnum;

public function get suspendMode():SuspendModeTypeEnum {
 
	var suspendMode:SuspendModeTypeEnum;

	suspendMode=DeviceManager.instance.suspendMode;

	if (suspendMode)
		return suspendMode;
 
	return null;
}


