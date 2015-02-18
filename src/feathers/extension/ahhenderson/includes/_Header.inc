import feathers.controls.Header;
import feathers.extension.ahhenderson.enums.FeathersComponentPoolType;

protected var _header:Header;
		  
		protected var _title:String;
		
		public function get title():String {
			
			if ( _header )
				return _header.title;
			
			return null;
		}
		
		public function set title( value:String ):void {
			
			if ( _header && (_header.title != value) )
				_header.title = value;
			
		}
		
		protected function get header():Header {
			 
			return _header;
		}
		
		
		protected function initHeader(title:String=null, customStyleName:String=null):void{
		  
			_header = this.fmgr.pool.borrowObj(FeathersComponentPoolType.HEADER);
			_header.layoutData = new AnchorLayoutData( 0, 0, NaN, 0 );
			
			if(title){
				_title = title;
				_header.title = title;
			}
			
			if(customStyleName ){ 
				_header.styleNameList.add(customStyleName);
			}
			
			this.addChild(_header);
		
		}
		
		