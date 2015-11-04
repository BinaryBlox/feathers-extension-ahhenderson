package feathers.extension.ahhenderson.interfaces
{
	import ahhenderson.core.mvc.interfaces.ICommandActor;
	import ahhenderson.core.mvc.interfaces.IFacadeMessage;
	
	public interface IDataServiceCommand extends ICommandActor
	{
		function startServiceCommand(message:IFacadeMessage):void;
		
		function endServiceCommand():void;
		
		function handleServiceCommandResult(message:IFacadeMessage):void;
	}
}