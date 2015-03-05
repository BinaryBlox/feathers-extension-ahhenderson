

//////////////////////////////////////
// Included from ahhenderson
//////////////////////////////////////

/*
Instructions:

1. Remove overriden dispose() method from feathers control and add here.
2. Add the IPoolObj Interface with FeathersControl
3. Add the include for this file at the bottom of the FeathersControl.
 
*/
import ahhenderson.core.managers.ObjectPoolManager;
import ahhenderson.core.collections.HashMapList;
import ahhenderson.core.managers.dependency.objectPool.interfaces.IPoolType;

import feathers.extension.ahhenderson.managers.FeathersApplicationManager;

private var _resetObjectFunction:Function;

private var _initObjectFunction:Function;

private var _isPooled:Boolean=false;

private var _autoReturnOnDispose:Boolean=true;

private var _objId:String;

private var _poolType:IPoolType;

public function get autoReturnOnDispose():Boolean{
	return _autoReturnOnDispose;
}

public function set autoReturnOnDispose(value:Boolean):void{
	_autoReturnOnDispose = value;
}

public function get resetObjectFunction():Function{
	return _resetObjectFunction;
}

public function set resetObjectFunction(value:Function):void{ 
	_resetObjectFunction = value;
}

public function get initObjectFunction():Function{
	return _initObjectFunction;
}

public function set initObjectFunction(value:Function):void{
	_initObjectFunction = value;
}

public function initObject(objId:String):void
{
	if (_objId)
		return;
	
	_objId=objId;
	
}

public function resetObject():void
{
	// Important to reset this
	_autoReturnOnDispose= true;
	
	if(_resetObjectFunction)
		_resetObjectFunction(this);
	
}

public function get isPooled():Boolean
{
	return _isPooled;
}

public function set isPooled(value:Boolean):void
{
	_isPooled=value; 
}

public function get objId():String
{
	return _objId;
}

public function get poolType():IPoolType
{ 
	return _poolType;
}

public function set poolType(value:IPoolType):void
{ 
	_poolType =value;
}

public function get properties():HashMapList
{
	// TODO Auto Generated method stub
	return null;
}

public function get scaledResolution():Number{
	return FeathersApplicationManager.instance.theme.scaledResolution;
	
}
 

override public function dispose():void{
	  
	if(this.isPooled){
		
		resetObject();
		 
		// If object is not aumatically returned, it must be returned manually or it will take up space in the pool.
		if(_autoReturnOnDispose){ 
			ObjectPoolManager.instance.returnObj(this);
		}
		   
		return;
	}
	
	// Object is not being pooled; dispose
	this._validationQueue = null; 
	this._isDisposed = true;
	 
	super.dispose();
}


 
