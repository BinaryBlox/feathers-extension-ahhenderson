package feathers.extension.ahhenderson.controls {
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;
	import feathers.layout.VerticalLayout;
	import feathers.skins.IStyleProvider;
	 

	public class TitledTextBlock extends LayoutGroup {

		public static const TITLED_TEXT_BLOCK_ITEM_RENDERER:String="TITLED_TEXT_BLOCK_ITEM_RENDERER";
		
		 
		
		/**
		 * The default <code>IStyleProvider</code> for all <code>ToggleButton</code>
		 * components. If <code>null</code>, falls back to using
		 * <code>Button.globalStyleProvider</code> instead.
		 *
		 * @default null
		 * @see feathers.core.FeathersControl#styleProvider
		 * @see feathers.controls.Button#globalStyleProvider
		 */
		public static var globalStyleProvider:IStyleProvider;

		public function TitledTextBlock() {

			super();
		}
		 
		private var _fmgr:FeathersApplicationManager;
		
		private var _content:String = new String();

		private var _contentFormat:ElementFormat;

		private var _lblContent:Label;

		private var _lblTitle:Label;

		private var _title:String;

		private var _titleFormat:ElementFormat;

		private var _verticalLayout:VerticalLayout;

		private var _wordWrapContent:Boolean = true;

		public function get fmgr():FeathersApplicationManager
		{
			if(!_fmgr)
				_fmgr = FeathersApplicationManager.instance;
			
			return _fmgr;
		}

		public function get content():String {

			return _content;
		}

		public function set content( value:String ):void {

			_content = value;

			if ( _lblContent && _lblContent.text != value )
				_lblContent.text = this.content;
		}

		public function get contentFormat():ElementFormat {

			return _contentFormat;
		}

		public function set contentFormat( value:ElementFormat ):void {

			_contentFormat = value;
		}

		public function get title():String {

			return _title;
		}

		public function set title( value:String ):void {

			_title = value;

			if ( _lblTitle && _lblTitle.text != value )
				_lblTitle.text = this.title;
		}

		public function get titleFormat():ElementFormat {

			return _titleFormat;
		}

		public function set titleFormat( value:ElementFormat ):void {

			_titleFormat = value;
		}

		public function get verticalLayout():VerticalLayout {

			if ( !_verticalLayout ) {
				_verticalLayout = new VerticalLayout();
				_verticalLayout.firstGap = 10 * this.scaledResolution;
				_verticalLayout.lastGap = 10 * this.scaledResolution;
				_verticalLayout.gap = 10 * this.scaledResolution;
				_verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
				_verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			}

			return _verticalLayout;
		}

		public function set verticalLayout( value:VerticalLayout ):void {

			_verticalLayout = value;

			if ( this.layout )
				this.layout = _verticalLayout;
		}

		public function get wordWrapContent():Boolean {

			return _wordWrapContent;
		}

		public function set wordWrapContent( value:Boolean ):void {

			_wordWrapContent = value;
		}

		/**
		 * @private
		 */
		override protected function get defaultStyleProvider():IStyleProvider {

			return TitledTextBlock.globalStyleProvider;
		}

		override protected function draw():void {

			super.draw();

			if ( _titleFormat && _lblTitle.textRendererProperties.elementFormat != _titleFormat)
				_lblTitle.textRendererProperties.elementFormat = _titleFormat;

			_lblTitle.text = this.title;
			_lblTitle.validate();

			//_lblContentBlock.layoutData = new VerticalLayoutData(100, 50);

			if ( _contentFormat  && _lblContent.textRendererProperties.elementFormat != _contentFormat)
				_lblContent.textRendererProperties.elementFormat = _contentFormat;

			_lblContent.text = this.content;
			_lblContent.maxWidth = this.actualWidth;
			_lblContent.validate();

		}

		override protected function initialize():void {

			this.layout = this.verticalLayout;

			this.touchable=false;
			
			_lblTitle = new Label();
			 
			/*_lblTitle.iconId = ThemeConstants.ICON_BUTTON_FILTER_1;
			_lblTitle.firstGap=15;
			_lblTitle.padding = 5;
			_lblTitle.iconBounds = new Rectangle(0, 0, 30, 30);*/
			_lblTitle.text = this.title;

			this.addChild( _lblTitle );

			_lblContent = new Label();
			_lblContent.text = this.content;

			// Wordwrap
			_lblContent.textRendererProperties.wordWrap = this.wordWrapContent;

			this.addChild( _lblContent );

		}
		 
		 
		
	}
}
