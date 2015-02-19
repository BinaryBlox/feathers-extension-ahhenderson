package feathers.extension.ahhenderson.controls.screens
{
	import feathers.controls.IScreen;
	import feathers.controls.LayoutGroup;

	public class LayoutGroupScreen extends LayoutGroup implements IScreen
	{
		public function LayoutGroupScreen()
		{
			super();
		}
		 
		include "../../_includes/_FeathersAppManager.inc";
		include "../../_includes/_Screen.inc";
	}
}