package feathers.extension.ahhenderson.controls {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.geom.Rectangle;
    import flash.net.URLRequest;
    import flash.system.ImageDecodingPolicy;
    import flash.system.LoaderContext;
    
 
    import ahhenderson.core.content.cache.helpers.MediaCacheHpr;
    import ahhenderson.core.content.enums.MediaContentType;
    import ahhenderson.core.util.ImageUtil;
    import feathers.extension.ahhenderson.util.DrawingUtils;
    
    import feathers.controls.ImageLoader;
    import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
    
    import starling.display.Image;
    import starling.textures.Texture;

    public class CustomImageLoader extends ImageLoader {
        public function CustomImageLoader() {
            super();
        }

		private static const LOADER_CONTEXT:LoaderContext = new LoaderContext(true);
		LOADER_CONTEXT.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
		
        private var _borderAlpha:Number = .6;

        private var _borderColor:uint = 0x000000;

        private var _borderThickness:Number = 2;

        private var _useCircleMask:Boolean;
		
		private var _defaultImageWidth:Number;
		
		private var _defaultImageHeight:Number;
		
		private var _imageGroupKey:String;
		 
		
		
		public function getImage():Image{
			
			if(!this._currentTexture)
				return null;
			
			return new Image(this._currentTexture);
		}

		public function get imageGroupKey():String
		{
			return _imageGroupKey;
		}

		public function set imageGroupKey(value:String):void
		{
			_imageGroupKey = value;
		}

		public function get defaultImageHeight():Number
		{
			return _defaultImageHeight;
		}

		public function set defaultImageHeight(value:Number):void
		{
			_defaultImageHeight = value;
		}

		public function get defaultImageWidth():Number
		{
			return _defaultImageWidth;
		}

		public function set defaultImageWidth(value:Number):void
		{
			_defaultImageWidth = value;
		}

        public function get borderAlpha():Number {
            return _borderAlpha;
        }

        public function set borderAlpha(value:Number):void {
            _borderAlpha = value;
        }

        public function get borderColor():uint {
            return _borderColor;
        }

        public function set borderColor(value:uint):void {
            _borderColor = value;
        }

        public function get borderThickness():Number {
            return _borderThickness;
        }

        public function set borderThickness(value:Number):void {
            _borderThickness = value;
        }

        public function get useCircleMask():Boolean {
            return _useCircleMask;
        }

        public function set useCircleMask(value:Boolean):void {
            _useCircleMask = value;
        }


        override protected function commitData():void {

			if(this._source is Texture)
			{
				this._lastURL = null;
				this._texture = Texture(this._source);
				this.refreshCurrentTexture();
				this._isLoaded = true;
			}
			else
			{
				const sourceURL:String = this._source as String;
				if(!sourceURL)
				{
					this._lastURL = sourceURL;
					this.refreshCurrentTexture();
					return;
				}
				
				if(sourceURL == this._lastURL)
				{
					//if it's not loaded yet, we'll come back later
					if(this._isLoaded)
					{
						this.refreshCurrentTexture();
					}
				}
				else
				{
					this._lastURL = sourceURL;
					
					// Item is already cached (only for bitmaps)
					var cacheId:String = sourceURL.toLowerCase();
					var imageKey:String = (this.imageGroupKey) ? cacheId + "#" + this.imageGroupKey: cacheId;
					
					if (MediaCacheHpr.cacheItemExists(imageKey, MediaContentType.MEDIA_TYPE__IMAGE_THUMB)) {
						
						// Process cached image.
						const bmpData:BitmapData = MediaCacheHpr.getCacheItem(imageKey,
							MediaContentType.MEDIA_TYPE__IMAGE_THUMB).bitmapData;
						
						trace("IMAGE Retreived from cache");
						processImage(new Bitmap(bmpData), true);
						
						//this.commitTexture();
						
						return;
					}
					
					if(this.loader)
					{
						this.loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, loader_completeHandler);
						this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
						this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
						try
						{
							this.loader.close();
						}
						catch(error:Error)
						{
							//no need to do anything in response
						}
					}
					else
					{
						this.loader = new Loader();
					}
					this.loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, loader_completeHandler);
					this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
					this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
					this.loader.load(new URLRequest(sourceURL), LOADER_CONTEXT);
				}
			}
			/*if(this._source is Texture)
			{
				this._lastURL = null;
				this._texture = Texture(this._source);
				this.refreshCurrentTexture();
				this._isLoaded = true;
			}
			else
			{
				const sourceURL:String = this._source as String;
				if(!sourceURL)
				{
					this._lastURL = null;
				}
				else if(sourceURL != this._lastURL)
				{
					this._lastURL = sourceURL;
					
					if(this.loader)
					{
						this.loader.removeEventListener(flash.events.Event.COMPLETE, loader_completeHandler);
						this.loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
						this.loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
						try
						{
							this.loader.close();
						}
						catch(error:Error)
						{
							//no need to do anything in response
						}
					}
					
					if(this.loader)
					{
						this.loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, loader_completeHandler);
						this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
						this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
						try
						{
							this.loader.close();
						}
						catch(error:Error)
						{
							//no need to do anything in response
						}
					}
					
					// Item is already cached (only for bitmaps)
					var cacheId:String = sourceURL.toLowerCase();
					var imageKey:String = (this.imageGroupKey) ? cacheId + "#" + this.imageGroupKey: cacheId;
					
					if (MediaHpr.cacheItemExists(imageKey, MediaContentType.MEDIA_TYPE__IMAGE_THUMB)) {
						
						// Process cached image.
						const bmpData:BitmapData = MediaHpr.getCacheItem(imageKey,
							MediaContentType.MEDIA_TYPE__IMAGE_THUMB).bitmapData;
						
						
						processImage(new Bitmap(bmpData), true);
						
						this.refreshCurrentTexture();
						
						return;
					}
					
					if(sourceURL.toLowerCase().lastIndexOf(ATF_FILE_EXTENSION) == sourceURL.length - 3)
					{
						if(this.loader)
						{
							this.loader = null;
						}
						if(!this.loader)
						{
							this.loader = new URLLoader();
							this.loader.dataFormat = URLLoaderDataFormat.BINARY;
						}
						this.loader.addEventListener(flash.events.Event.COMPLETE, rawDataLoader_completeHandler);
						this.loader.addEventListener(IOErrorEvent.IO_ERROR, rawDataLoader_errorHandler);
						this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, rawDataLoader_errorHandler);
						this.loader.load(new URLRequest(sourceURL));
						return;
					}
					else //not ATF
					{
						if(this.loader)
						{
							this.loader = null;
						}
						if(!this.loader)
						{
							this.loader = new Loader();
						}
						this.loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, loader_completeHandler);
						this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
						this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
						this.loader.load(new URLRequest(sourceURL), LOADER_CONTEXT);
					}
				}
				this.refreshCurrentTexture();*/
			 
			// Item exists, use cache
		/*	if (MediaHpr.cacheItemExists(this._data.thumbURL, MediaContentType.MEDIA_TYPE__IMAGE_THUMB)) {
				
				// Process cached image.
				const bmpData:BitmapData = MediaHpr.getCacheItem(this._data.thumbURL,
					MediaContentType.MEDIA_TYPE__IMAGE_THUMB).bitmapData;
				
				processImage(new Bitmap(bmpData), width, height, true);
				
				return;
			}*/
			
        }
		
		protected function processImage(bitmap:Bitmap, isCached:Boolean=false):void{
			this.cleanupTexture();
			var bitmapData:BitmapData;
			
			
			if (this.useCircleMask) {
				bitmapData = DrawingUtils.drawCircle(bitmap.height / 2, bitmap.bitmapData, this.borderColor, this.borderThickness, this.borderAlpha);
			} else {
				var rect:Rectangle = new Rectangle(0, 0, bitmap.width, bitmap.height);
				bitmapData = DrawingUtils.drawRectangle( FeathersApplicationManager.instance.theme.scaledResolution, rect, 0, bitmap.bitmapData, this.borderColor, this.borderThickness, this.borderAlpha);
				//bitmap.bitmapData;
			}
			
			//trace("Image width: " + bitmapData.width + " -- " + "Image height: " + bitmapData.height);
			
			if (this._delayTextureCreation) {
				this._pendingBitmapDataTexture = bitmapData;
			} else {
				this.replaceBitmapDataTexture(bitmapData); 
			}
		}
 
		 
		/**
		 * @private
		 */
		override protected function loader_completeHandler(event:flash.events.Event):void
		{
			if (!this.loader.content || (!(this.loader.content is Bitmap)))
				return;
			 
			var bitmap:Bitmap;
			
			if((this.defaultImageWidth > 0) && (this.defaultImageHeight > 0)){
				var imgBounds:Rectangle=new Rectangle(0,0, this.defaultImageWidth, this.defaultImageHeight);
				bitmap = new Bitmap(ImageUtil.scaleBitmapToRectangle(Bitmap(this.loader.content).bitmapData, imgBounds, true, true), "auto", true);
				
				// Draw boarder
				//DrawingUtils.drawRectangle( SystemModel.appDpiScale, imgBounds, 0, bitmap.bitmapData, this.borderColor, this.borderThickness, this.borderAlpha);
			}
			else
				bitmap = Bitmap(this.loader.content);
			
			
			var sourceURL:String  = (this._source as String).toLowerCase(); 
			var imageKey:String = (this.imageGroupKey) ? sourceURL + "#" + this.imageGroupKey: sourceURL;
			
			
			MediaCacheHpr.addCacheItem(imageKey, MediaContentType.MEDIA_TYPE__IMAGE_THUMB, sourceURL, bitmap.bitmapData);
			
			this.loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, loader_completeHandler);
			this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this.loader = null;
			
			// Process image
			processImage(bitmap);
		 
		}
       
       /* override protected function loader_completeHandler(event:flash.events.Event):void {
			
			if (!this.loader.content || (!(this.loader.content is Bitmap)))
				return;
			
            var bitmap:Bitmap;
			
			if((this.defaultImageWidth > 0) && (this.defaultImageHeight > 0)){
				var imgBounds:Rectangle=new Rectangle(0,0, this.defaultImageWidth, this.defaultImageHeight);
				bitmap = new Bitmap(ImageUtils.scaleBitmapToRectangle(Bitmap(this.loader.content).bitmapData, imgBounds, true, true), "auto", true);
				
				// Draw boarder
				//DrawingUtils.drawRectangle( SystemModel.appDpiScale, imgBounds, 0, bitmap.bitmapData, this.borderColor, this.borderThickness, this.borderAlpha);
			}
			else
				bitmap = Bitmap(this.loader.content);
			 
			 
			var sourceURL:String  = (this._source as String).toLowerCase(); 
			var imageKey:String = (this.imageGroupKey) ? sourceURL + "#" + this.imageGroupKey: sourceURL;
			
				
			MediaHpr.addCacheItem(imageKey, MediaContentType.MEDIA_TYPE__IMAGE_THUMB, sourceURL, bitmap.bitmapData);
			
			 
            this.loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, loader_completeHandler);
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
            this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
            this.loader = null;

			// Process image
			processImage(bitmap);
		 
        }*/
    }
}
