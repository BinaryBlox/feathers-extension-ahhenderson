package feathers.extension.ahhenderson.helpers {

	import feathers.extension.ahhenderson.constants.FeathersExtLib_SessionPropertyKeys;


	public class ControlGroupHelper {
		public function ControlGroupHelper() {

		}
		
		include "_Helpers.inc";

		public static function setGroupState( controlGroup:String, state:String ):void {

			fmgr.session.addProperty(controlGroup, state );
			 
		}

		public static function getGroupState( controlGroup:String ):String {

			return fmgr.session.getProperty( controlGroup ) as String;
		}

		public static function setLastPage( pageNotificationId:String ):void {

			fmgr.session.addProperty( FeathersExtLib_SessionPropertyKeys.LAST_SHARED_CONTROL_GROUP_PAGE, pageNotificationId );

		}

		public static function getLastPage():String {

			return fmgr.session.getProperty( FeathersExtLib_SessionPropertyKeys.LAST_SHARED_CONTROL_GROUP_PAGE) as String;

		}
	}
}
