package feathers.extension.ahhenderson.helpers {

	import mx.rpc.Fault;
	
	import feathers.controls.Alert;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.extension.ahhenderson.controls.dialogs.LoadingDialog;
	import feathers.extension.ahhenderson.themes.constants.FlatThemeCustomTextures;
	
	import starling.core.Starling;
	import starling.events.Event;


	/**
	 *
	 * @author thenderson
	 */
	public class DialogHelper {
		/**
		 *
		 */
		public function DialogHelper() {
		}

		include "_Helpers.inc";
		
		private static var _dialog:LoadingDialog;
		
		
		// DIALOG :
		
		private static function get dialog():LoadingDialog
		{
			if(!_dialog){
				_dialog = new LoadingDialog();
				_dialog.minHeight = 250 * fmgr.theme.scaledResolution;
				_dialog.width = 350 * fmgr.theme.scaledResolution;
			}
			return _dialog;
		}
		
		 
		public static function showLoadingDialog( message:String = "Loading...", title:String=null, autoClose:Number=NaN, loadingIcon:String=null):void{
			 
			
			dialog.title = title;
			dialog.content = message;
			  
			loadingIcon = (loadingIcon) ? loadingIcon : FlatThemeCustomTextures.ICONS_CIRCLEBUTTON_SYNC_1;
			dialog.loadingIcon=loadingIcon;
		 
			
			PopUpManager.addPopUp(dialog);
			PopUpManager.centerPopUp(dialog);
			
			// If autoClose value set
			if(!isNaN(autoClose) && autoClose>0){
				Starling.juggler.delayCall(
					function():void { PopUpManager.removePopUp(dialog)},
					autoClose);
			}
		}
		
		
		private static function removePopUpDialog():void{
			 
			if(PopUpManager.isPopUp(dialog)){
				PopUpManager.removePopUp(dialog);
			}
		}
		
		public static function hideLoadingDialog(delay:Number=NaN):void{
			
			if(!dialog)
				return;
			
			// If delay value set
			if(!isNaN(delay) && delay>0){
				Starling.juggler.delayCall(
					removePopUpDialog,
					delay);
				
				return;
			}
			
			PopUpManager.removePopUp(dialog); 
		}

		/**
		 *
		 * @param title
		 * @param message
		 * @param alertCloseFunction
		 * @param buttons - collection of buttons to display (and events)
		 * @param autoCloseDialog - Closes any existing dialogs (default true)
		 *
		 * <p>Note: to add buttons and listen for events on them, add  { label: "OK", triggered: okButton_triggeredHandler }</p>
		 * @return
		 */
		public static function showAlert( title:String, message:String = null, alertCloseFunction:Function = null, buttons:ListCollection =
			null, autoCloseDialog:Boolean = true ):Boolean {

			/*if ( autoCloseDialog )
				DialogHpr.hide( 0 );*/

			// If buttons don't exist, use defauilt OK button
			if ( !buttons || buttons.length == 0 )
				buttons = new ListCollection([{ label: "OK" }])

			const alert:Alert = Alert.show( message, title, buttons );

			if ( alertCloseFunction )
				alert.addEventListener( Event.CLOSE, alertCloseFunction );

			return true;
		}

		/**
		 *
		 * @param fault
		 * @param title
		 * @param alertCloseFunction
		 * @param buttons
		 * @param autoCloseDialog
		 */
		public static function showFault( fault:Fault, title:String = "Fault Error", alertCloseFunction:Function = null,
										  buttons:ListCollection = null, autoCloseDialog:Boolean = true ):void {

			var faultString:String = ( !fault ) ? "Fault Empty" : getFaultString( fault );

			showAlert( title, faultString, alertCloseFunction, buttons, autoCloseDialog )
		}

		/**
		 *
		 * @param fault
		 * @return
		 */
		public static function getFaultString( fault:Fault ):String {

			var faultMessage:String = "getFaultString N\A";

			// Build error message
			if ( fault && fault is Fault )
				faultMessage = "Code:\n" + fault.faultCode + "\n\nDetail: " + fault.faultString;

			return faultMessage;
		}
	}
}
