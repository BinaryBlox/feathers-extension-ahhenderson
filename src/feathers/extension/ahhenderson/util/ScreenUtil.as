
package feathers.extension.ahhenderson.util {
	import flash.events.TimerEvent;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	 
	import ahhenderson.core.util.CustomTimer;

	public class ScreenUtil {

		public static function addScreen( navigator:ScreenNavigator, id:String, screen:Object, events:Object = null, initializer:Object =
			null ):void {

			//initializer = injectDPIProperty( initializer );

			navigator.addScreen( id, new ScreenNavigatorItem( screen, events, initializer ));
		}

		private static function onTimerComplete( e:TimerEvent ):void {

			//DialogHpr.hide();

			if ( !( e.currentTarget is CustomTimer ))
				return;

			var displayTimer:CustomTimer = e.currentTarget as CustomTimer;

			( displayTimer.TimerData.navigator as ScreenNavigator ).showScreen( displayTimer.TimerData.id );

			displayTimer.removeEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			displayTimer = null;
		}

		public static function removeScreen( navigator:ScreenNavigator, id:String ):void {

			navigator.removeScreen( id );
		}

		public static function showScreen( navigator:ScreenNavigator, id:String, delay:int = 0 ):void {

			if ( delay > 0 ) {

				var displayTimer:CustomTimer = new CustomTimer( delay, 1 );
				displayTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete, false, 0, true );
				displayTimer.TimerData = new Object();
				displayTimer.TimerData.id = id;
				displayTimer.TimerData.navigator = id;

				displayTimer.start();

				return;
			}

			navigator.showScreen( id );
		}
	/*private static function injectDPIProperty( obj:Object ):Object {
		if ( obj && !obj.hasOwnProperty( "originalDPI" ))
			obj.originalDPI = AppMgr.instance.conf.layer.originalDPI;
		else {
			obj = new Object();
			obj.originalDPI = AppMgr.instance.conf.layer.originalDPI;
		}
		return obj;
	}*/
	}
}
