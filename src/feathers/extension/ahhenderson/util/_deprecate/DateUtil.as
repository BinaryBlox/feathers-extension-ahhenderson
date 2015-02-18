package feathers.extension.ahhenderson.util._deprecate
{
	import feathers.data.ListCollection;
 
	public class DateUtil
	{ 
		public static const monthLabelsList:ListCollection = new ListCollection(
			[ 
				{ label: "January"},
				{ label: "February"},
				{ label: "March"},
				{ label: "April"},
				{ label: "May"},
				{ label: "June"},
				{ label: "July"},
				{ label: "August"},
				{ label: "September"},
				{ label: "October"},
				{ label: "November"},
				{ label: "December"}
			]); 
		
		public static const timeZoneLabelsList:ListCollection = new ListCollection(
			[ 
				{ label: "PT", value:0},
				{ label: "MT", value:1},
				{ label: "CT", value:2},
				{ label: "ET", value:3},
			]);
		
		 
		
	}
}