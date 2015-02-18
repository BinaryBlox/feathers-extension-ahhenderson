package feathers.extension.ahhenderson.util
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import feathers.data.HierarchicalCollection;

	public class CollectionUtil
	{
		public function CollectionUtil()
		{
		}
		
		/**
		 * Returns a HierarchicalCollection based on grouping by search property.
		 * @param searchProperty 
		 * @param data
		 * @param sortProperty
		 * @param descending
		 * @return HierarchicalCollection
		 */
		public static function getHierarchicalCollection( searchProperty:String, data:ArrayCollection, sortProperty:String = null,
														  descending:Boolean = false ):HierarchicalCollection {
			
			if ( !data || !searchProperty )
				return null;
			
			// Sort by search property first
			if ( sortProperty != null ) {
				var itemSort:Sort = new Sort();
				var sortField:SortField = new SortField( sortProperty, false, descending );
				itemSort.fields = [ sortField ];
				data.sort = itemSort;
				data.refresh();
			}
			
			var parentValues:Array = data.toArray();
			var start:int
			var end:int;
			
			//start = getTimer();
			//trace("START: extractPropertyValuesFromCollection - ", start.toString());
			
			//var groupedHeaders:Array = ArrayUtils.extractPropertyValuesFromCollection(searchProperty, data).toArray();
			
			//end = getTimer()-start; 
			//trace("END: extractPropertyValuesFromCollection - ", end.toString());
			
			// Create hash of parent/Children
			var groupItem:Object;
			var hierarchicalData:Array = new Array();
			var childValues:Array;
			
			/*for(var i:int =0 ; i<data.length;i++){
			
			groupItem = new Object()
			groupItem.header = groupedHeaders[i];
			
			childValues = filterArrayByValue(searchProperty, groupedHeaders[i], parentValues);
			groupItem.children = childValues;
			
			hierarchicalData.push(groupItem);
			}*/
			
			start = getTimer();
			//trace( "START: getHierarchicalCollection - ", start.toString());
			
			var uniqueValues:Dictionary = new Dictionary();
			var groupKey:String;
			var groupSortValue:int = 0;
			var children:Array;
			
			for ( var i:int = 0; i < data.length; i++ ) {
				
				groupKey = data[ i ][ searchProperty ];
				
				// Check if item exists. 
				if ( uniqueValues[ groupKey ]) {
					
					groupItem = uniqueValues[ groupKey ];
					( groupItem.children as Array ).push( data[ i ]);
					
					//trace("Existing values added: ", groupKey)
					//(uniqueValues[groupKey].children as Array).push(data[i]);
				} else {
					//trace("New value  added: ", groupKey)
					groupItem = new Object();
					groupItem.header = groupKey;
					groupItem.sortValue = groupSortValue;
					
					groupSortValue++;
					
					childValues = new Array();
					childValues.push( data[ i ]);
					groupItem.children = childValues;
					
					uniqueValues[ groupKey ] = groupItem;
					
				}
			}
			
			for ( var dicKey:String in uniqueValues ) {
				hierarchicalData.push( uniqueValues[ dicKey ]);
			}
			
			//poets.sortOn("born", Array.NUMERIC); 
			if ( descending )
				hierarchicalData.sortOn( "sortValue", Array.NUMERIC, Array.DESCENDING );
			else
				hierarchicalData.sortOn( "sortValue", Array.NUMERIC );
			
			end = getTimer() - start;
			trace( "END: getHierarchicalCollection - ", end.toString());
			
			/*
			start = getTimer();
			trace("START: filter - ", start.toString());
			for(var i:int =0 ; i<groupedHeaders.length;i++){
			
			groupItem = new Object()
			groupItem.header = groupedHeaders[i];
			
			childValues = filterArrayByValue(searchProperty, groupedHeaders[i], parentValues);
			groupItem.children = childValues;
			
			hierarchicalData.push(groupItem);
			}
			
			end = getTimer()-start;
			trace("END: filter - ", end.toString());*/
			
			hierarchicalData.fixed = true;
			
			return new HierarchicalCollection( hierarchicalData );
			
		}
		
		/**
		 * Returns a HierarchicalCollection with a specified header and single list.
		 * 
		 * @param groupHeader The value to display for the single group header.
		 * @param data  array of data to add to the hiearchical collection
		 * @param sortProperty Field to sort by 
		 * @param descending sort direction, default asc.
		 * @param isInteger value is integer (default false)
		 * 
		 * @return HierarchicalCollection
		 */
		public static function getHierarchicalCollectionAsSingleList( groupHeader:String, data:Array, sortProperty:String = null,
																	  descending:Boolean = false, isInteger:Boolean=false ):HierarchicalCollection {
			
			if ( !data || !groupHeader )
				return null;
			
			if(sortProperty){
				
				if(descending){
					(isInteger) ? data.sortOn(sortProperty, Array.DESCENDING | Array.NUMERIC ) : data.sortOn(sortProperty, Array.DESCENDING);
				}
				else{
					(isInteger) ? data.sortOn(sortProperty, Array.NUMERIC ) : data.sortOn(sortProperty);
				}
			}
			
			
			return new HierarchicalCollection([{ header: groupHeader, children: data }]);
		}

	}
}