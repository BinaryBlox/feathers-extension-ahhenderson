package feathers.extension.ahhenderson.ui.menu
{
	import ahhenderson.core.ui.layout.HorizontalAlign;
	
	import ahhenderson.core.collections.DictionaryList;
	
	public class MenuItemGroup  
	{
		public function MenuItemGroup(id:String)
		{
			 
			
			_id = id;
			
			_rightItems = new DictionaryList();
			
			_leftItems = new DictionaryList();
		}
		
		private var _id:String;
		
		private var _rightItems:DictionaryList;
		
		private var _leftItems:DictionaryList;
		
		public function get id():String
		{
			return _id;
		}

		 
		public function addItem(item:MenuItem):void{
			
			switch(item.placement){
				
				case HorizontalAlign.RIGHT:
					_rightItems.addItem(item);
					break;
				
				case HorizontalAlign.LEFT:
					_leftItems.addItem(item);
					break;
			}
		}
		
		public function itemExists(key:String):Boolean{
			
			if(_rightItems.itemExists(key))
				return true;
			
			if(_leftItems.itemExists(key))
				return true;
			
			return false;
			
		}
		
		public function purgeItems():void{
			
			_rightItems.purgeItems();
			_leftItems.purgeItems();
			
		}
		
		public function removeItem(item:MenuItem):void{
			 
			switch(item.placement){
				
				case HorizontalAlign.RIGHT:
					_rightItems.removeItem(item.key);
					break;
				
				case HorizontalAlign.LEFT:
					_leftItems.removeItem(item.key);
					break;
			}
		}
	}
}