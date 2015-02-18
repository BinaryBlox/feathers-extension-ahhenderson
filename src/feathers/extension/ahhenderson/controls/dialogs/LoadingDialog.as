package feathers.extension.ahhenderson.controls.dialogs
{
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.extension.ahhenderson.controls.TitledTextBlock;
	import feathers.extension.ahhenderson.helpers.AssetHelper;
	import feathers.extension.ahhenderson.helpers.LayoutHelper;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.extension.ahhenderson.themes.helpers.UI_FactoryHelper;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.events.Event;
	
	public class LoadingDialog extends LayoutGroup implements IAnimatable
	{
		public function LoadingDialog()
		{
			super();
			
			addListeners();
		} 

		public function get loadingIcon():String
		{
			 
			return _loadingIcon;
		}

		public function set loadingIcon(value:String):void
		{
			if(_loadingIcon === value)
				return;
				 
			_loadingIcon = value;
			
			if(_imgLoadingIcon){
				_imgLoadingIcon.source = AssetHelper.getTexture(_loadingIcon);
				if(!contains(_imgLoadingIcon)){
					addChild(_imgLoadingIcon);
				}
			} 
		}

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			if(_title !== value){
				_title = value;

				if ( _ctrDialogText )
					_ctrDialogText.title = _title;
			}
		}

		public function get content():String
		{
			return _content;
		}

		public function set content(value:String):void
		{ 
			if(_content !== value){
				
				_content = value;
				
				if(_ctrDialogText)
					_ctrDialogText.content = _content;
			}
			 
		}

		override protected function draw():void {
			
			super.draw();
			 
			
			
			if(_ctrDialogText.maxWidth !== this.actualWidth)
				_ctrDialogText.maxWidth = this.actualWidth;
			
			if(_ctrDialogText.title !== this.title)
				_ctrDialogText.title = this.title;
			
			if(_ctrDialogText.content !== this.content)
				_ctrDialogText.content = this.content;  
			
			_imgLoadingIcon.validate();
			
			/*var pivotX:Number  =   _imgLoadingIcon.width  / 2.0;
			var pivotY:Number  =   _imgLoadingIcon.height  / 2.0;
			
			if(_imgLoadingIcon.pivotX !== pivotX)
				_imgLoadingIcon.pivotX = pivotX;
			
			if(_imgLoadingIcon.pivotY !== pivotY)
				_imgLoadingIcon.pivotY = pivotY;*/
			
			_imgLoadingIcon.alignPivot();
			
			//_imgLoadingIcon.pivotY = _imgLoadingIcon.height / 2.0;
			//_imgLoadingIcon.alignPivot();
		}
		
		override public function dispose():void{
			
			removeListeners();
			
			if(Starling.juggler.contains(this))
				Starling.juggler.remove(this);
			
			super.dispose();
		} 
		
		private var _content:String = "Loading...";
		
		private var _loadingIcon:String;
		
		private var _title:String;
		
		private var _ctrDialogText:TitledTextBlock;
		
		private var _imgLoadingIcon:ImageLoader;
		
		private function addListeners():void{
			
			addEventListener(Event.ADDED_TO_STAGE, startRotation);
			addEventListener(Event.REMOVED_FROM_STAGE, stopRotation);
			
		}
		
		private function removeListeners():void{
			
			removeEventListener(Event.ADDED_TO_STAGE, startRotation);
			removeEventListener(Event.REMOVED_FROM_STAGE, stopRotation);
		}
		
		/** Rotation speed. */
		private static const RAD_PER_SECOND:Number = 7;//Math.PI;
		
		override protected function initialize():void {
			
			super.initialize();
			
			this.layout = new AnchorLayout();
			   
			// Add Text block
			_ctrDialogText = new TitledTextBlock(); 
			_ctrDialogText.layoutData =new AnchorLayoutData( NaN, NaN, NaN, NaN, 0, 0 );
			
			_ctrDialogText.title = this.title;
			_ctrDialogText.content = this.content;
			 
			addChild( _ctrDialogText );
			  
			// Loading icon
			_imgLoadingIcon = UI_FactoryHelper.imageLoaderFactory();
			_imgLoadingIcon.layoutData = new AnchorLayoutData( NaN, NaN, 16*this.scaledResolution, NaN, 0, NaN );
			 
			(_imgLoadingIcon.layoutData as AnchorLayoutData).bottomAnchorDisplayObject = _ctrDialogText;
			
			if(_loadingIcon){
				_imgLoadingIcon.source = AssetHelper.getTexture(_loadingIcon);
				
				addChild(_imgLoadingIcon);
			}  
			 
		}
		
		/** Starts the loading image rotation. */
		public function startRotation(ev:Event=null):void { 
			Starling.juggler.add(this); 
			_imgLoadingIcon.rotation = 0;
		 
		}
		
		/** Stops the loading image rotation. */
		public function stopRotation(ev:Event=null):void {
			Starling.juggler.remove(this);  
		}

		
		/** Rotates. */
		public function advanceTime(elapsedTime:Number):void {
			
			trace("Advanced Time - Elapsed Time: ", elapsedTime.toString());
			//_imgLoadingIcon.rotation = deg2rad(45);
			
			_imgLoadingIcon.rotation += elapsedTime * RAD_PER_SECOND;
		}
	}
}