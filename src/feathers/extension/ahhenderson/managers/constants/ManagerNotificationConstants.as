package feathers.extension.ahhenderson.managers.constants {

	import avmplus.getQualifiedClassName;


	public class ManagerNotificationConstants {

		public static const POPUP_CONTENT_CLOSE_END:String = uniqueConstant( "POPUP_CONTENT_CLOSE_END" );

		public static const POPUP_CONTENT_CLOSE_START:String = uniqueConstant( "POPUP_CONTENT_CLOSE_START" );

		public static const POPUP_CONTENT_ITEM_TRIGGERED:String = uniqueConstant( "POPUP_CONTENT_ITEM_TRIGGERED" );

		public static const POPUP_CONTENT_OPEN:String = uniqueConstant( "POPUP_CONTENT_OPEN" );

		private static function uniqueConstant( value:String ):String {

			return value + "_" + getQualifiedClassName( ManagerNotificationConstants )
		}
	}
}
