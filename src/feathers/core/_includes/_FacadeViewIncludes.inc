import flash.display.BitmapData;

import ahhenderson.core.ahhenderson_internal;
import ahhenderson.core.mvc.interfaces.IMediatorActor;
import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
import ahhenderson.core.mvc.patterns.facade.GlobalFacade;

use namespace ahhenderson_internal;

private var _componentArgs:Array;

private var _mediatorGuid:String;

private var _mediatorKey:String;

private var _mediatorName:String;

private var _messageGroupsFilter:Array;

private var _messageTypesFilter:Array;

private var _strictMessageFilter:Boolean;

private var _viewSnapShot:BitmapData;

public function get componentArgs():Array {
	if (!_componentArgs)
		_componentArgs=[];

	return _componentArgs;
}

/**
*
* @Purpose is to override to handle scenario when component arguments have been loaded.
* @Note: This function will be triggered before create children and is used for setting properties.
*/
public function componentArgumentsUpdated():void {


}

public function get mediatorGuid():String {

	return _mediatorGuid;
}

public function get mediatorKey():String {

	return _mediatorKey;
}

public function set mediatorKey(value:String):void {

	_mediatorKey=value;
}

public function get mediatorName():String {

	return _mediatorName;
}


public function get messageGroupsFilter():Array {

	return _messageGroupsFilter;
}


public function set messageGroupsFilter(value:Array):void {

	_messageGroupsFilter=value;
}


public function get messageTypesFilter():Array {

	return _messageTypesFilter;
}


public function set messageTypesFilter(value:Array):void {

	_messageTypesFilter=value;
}


public function registerMediator(mediator:IMediatorActor, messageFilter:FacadeMessageFilter, useStarling:Boolean=true, ... args):void {

	mediator.setComponent(this);

	//TODO: update args support later
	//TODO: mediator.setToken(); 
	if (messageFilter) {
		_mediatorKey=mediator.register(mediator, messageFilter, useStarling);
	} else {
		_mediatorKey=mediator.register(mediator, new FacadeMessageFilter(_messageGroupsFilter, _messageTypesFilter), useStarling);
	}

	_mediatorName=mediator.actorName;
	_mediatorGuid=_mediatorKey.replace(_mediatorName, "");
	trace("Mediator Guid: " + _mediatorGuid + " _ Mediator Name:" + _mediatorName);
}


public function removeMediator():Boolean {

	return GlobalFacade.instance.removeActor(this.mediatorName, this.mediatorGuid);
}


// Use when passing in rest parameters argument.
public function setArgs(... args):void {
	_componentArgs=args;
	componentArgumentsUpdated();
}

public function get strictMessageFilter():Boolean {

	return _strictMessageFilter;
}


public function set strictMessageFilter(value:Boolean):void {

	_strictMessageFilter=value;
}


public function get viewSnapShot():BitmapData {

	return _viewSnapShot;
}

public function set viewSnapShot(value:BitmapData):void {

	_viewSnapShot=value;
}
