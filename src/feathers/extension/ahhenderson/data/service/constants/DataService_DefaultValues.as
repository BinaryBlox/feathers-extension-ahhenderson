package feathers.extension.ahhenderson.data.service.constants {

	import ahhenderson.core.util.dependency.arg.Arg;


	public class DataService_DefaultValues {

		public static const DEFAULT_FEMALE_HEIGHT:Number = 64;

		public static const DEFAULT_FEMALE_WEIGHT:Number = 120;

		public static const DEFAULT_MALE_HEIGHT:Number = 69; // Inches 

		public static const DEFAULT_MALE_WEIGHT:Number = 165; // 

		public static const DEFAULT_WEIGHT_METRIC:String = "lbs";

		public static const DEFAULT_HEIGHT_METRIC:String = "in";

		public static const MAP_HEIGHT_METRIC_VALUES:Vector.<Arg> =
			new Vector.<Arg>[ new Arg( "lbs", "Pounds" ), new Arg( "kg", "Kilograms" ), new Arg( "st", "Stones" )];

		public static const MAP_WEIGHT_METRIC_VALUES:Vector.<Arg> =
			new Vector.<Arg>[ new Arg( "in", "Inches" ), new Arg( "cm", "Centimeters" )];

		public static const DEFAULT_FEMALE_AGE:int = 30;

		public static const DEFAULT_MALE_AGE:int = 35;

		public static const DEFAULT_USER_TYPE:Number = 0;

		public static const DEFAULT_PROFILE_URL:String = "url/photo";

		public static const DEFAULT_PASSWORD:String = "Tony12345";

		public static const DEFAULT_STATE:String = "CA";

		public static const DEFAULT_CITY:String = "San Francisco";

		public static const DEFAULT_COUNTRY:String = "United States";

		public static const DEFAULT_COMMENT:String = "N/A";

		public static const DEFAULT_GENDER:String = "male";

		public static const DEFAULT_EMAIL:String = "example@gmail.com";

		public static const DEFAULT_MALE_FIRST_NAME:String = "Joe";

		public static const DEFAULT_FEMALE_FIRST_NAME:String = "Blow";

		public static const DEFAULT_MALE_LAST_NAME:String = "Mary";

		public static const DEFAULT_FEMALE_LAST_NAME:String = "Jane";

		public static const DEFAULT_USERNAME:String = "";

		public static const DEFAULT_ACTIVE_USER:Boolean = true;

		public static const DEFAULT_TIMEZONE:String = "-7";

		public static const DEFAULT_TAGLINE:String = "About me...";

		public static const EXCEPTION_ALERT_TITLE:String = "Ooops...";

		public static const EXCEPTION_ALERT_MESSAGE:String = "Something happened; please try logging in again.";
	}
}
