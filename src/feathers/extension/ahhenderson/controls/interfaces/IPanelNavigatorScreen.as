package feathers.extension.ahhenderson.controls.interfaces {
	import feathers.extension.ahhenderson.controls.PanelNavigator;


	public interface IPanelNavigatorScreen {

		function get panelNavigator():PanelNavigator;
		
		function showLastScreen(delay:int=0):void;
		 
		
	}
}
