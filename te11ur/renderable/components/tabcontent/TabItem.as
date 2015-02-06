package te11ur.renderable.components.tabcontent
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import te11ur.display.TShape;
	import te11ur.renderable.ThemeManager;
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.components.InteractiveRenderable;
	import te11ur.renderable.components.content.Content;
	import te11ur.renderable.components.scrollcontent.ScrollContent;
	import te11ur.renderable.layout.AreaLayout;
	import te11ur.renderable.layout.stack.IStackLayoutRenderer;
	import te11ur.renderable.layout.tab.ITabLayoutItem;
	
	public class TabItem extends InteractiveRenderable implements ITabItem, ITabLayoutItem
	{		
		private var _type:String;
		private var _title:String = '';
		private var _text:TextField;
		private var _textFormat:TextFormat;
		private var _tabPlace:TShape;
		private var _tabBtnHeight:Number;
		private var _tabBtnWidth:Number;
		private var _tabBtnTextPadding:Number;
		private var _prevTabsWidth:Number;
		private var _tabGap:Number;
		protected var _content:BaseRenderable;
		private var _closeSprite:Sprite;
		
		public function TabItem(type:String, style:String='')
		{
			_type = type;
			super(style);
		}
		
		public function set title(value:String):void
		{
			_title = value;
			
			if(_text) {
				_text.text = _title;
			}
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function set active(value:Boolean):void
		{
			selected = value;
			_itemPlace.visible = value;
			_bgPlace.visible = value;
		}
		
		public function get active():Boolean
		{
			return _selected;
		}
		
		public function get tabSize():Rectangle
		{
			return new Rectangle(_tabPlace.x, _tabPlace.y, _tabPlace.width, _tabPlace.height);
		}
		
		public function set prevTabsWidth(value:Number):void
		{
			_prevTabsWidth = value;
		}
		
		public function get content():BaseRenderable
		{
			return _content;
		}
				
		override protected function determineColor():void
		{
			super.determineColor();
			
			if(_textFormat) {
				_textFormat.color = _activeTextColor;
				_textFormat.bold = _selected;
			}
				
			if(_text) {
				_text.setTextFormat(_textFormat);
			}
		}
		
		override public function render():void
		{	
			super.render();
			
			if(_text) {
				if(_tabPlace) {
					fillBg('tab');
					_tabPlace.x = _prevTabsWidth + _tabGap;
				}
				_text.x = _tabPlace.x + _tabBtnTextPadding;
				_text.y = (_tabBtnHeight - _text.height) / 2;
			}
			
			if(_closeSprite) {
				_closeSprite.visible = _over || _selected;
				_closeSprite.x = _tabPlace.x + _tabPlace.width - _closeSprite.width - _tabBtnTextPadding;
				_closeSprite.y = (_tabBtnHeight - _closeSprite.height) / 2;
			}
			
			_bgPlace.y = _tabBtnHeight;
			_itemPlace.y = _tabBtnHeight;
			layout.paddingBottom = _tabBtnHeight;
		}
		
		override public function destroy():void
		{	
			if(_tabPlace) {
				removeChild(_tabPlace);
			}
			
			if(_text) {
				removeChild(_text);
			}
			
			if(_closeSprite) {
				_closeSprite.removeEventListener(MouseEvent.CLICK, closeBtnMouseClickListener);
				removeChild(_closeSprite);
				
				if(_closeSprite.numChildren > 0) {
					_closeSprite.removeChildren(0, _closeSprite.numChildren - 1);
				}
			}
			
			super.destroy();
			
			_text = null;
			_tabPlace = null;
			_textFormat = null;
			_closeSprite = null;
			_content = null;
		}
		
		override protected function init():void
		{
			super.init();
			
			if(!_textFormat) {
				_textFormat = new TextFormat();
				_textFormat.color = _textColor;
				_textFormat.font = _defaultFontName;
				_textFormat.size = 13;
			}
			
			if(!_text) {
				_text = new TextField();
				_text.autoSize = TextFieldAutoSize.CENTER;
				_text.defaultTextFormat = _textFormat;
				_text.embedFonts = true;
				_text.mouseEnabled = false;
				_text.selectable = false;
				_text.text = _title;
				addChild(_text);
			}
			
			if(!_content) {
				_content = _type == TabItemContentType.SCROLL ? new ScrollContent('TabScrollContent') : new Content('TabContent');
				addRenderable(_content, true);
			}
			
			if(_closeSprite) {
				_closeSprite.addEventListener(MouseEvent.CLICK, closeBtnMouseClickListener, false, 0, true);
			}
			
			layout = new AreaLayout();
		}
		
		override protected function mouseClickListener(event:MouseEvent):void
		{
			super.mouseClickListener(event);
			
			if(_owner is IStackLayoutRenderer) {
				IStackLayoutRenderer(_owner).active = index;
			}
		}

		override protected function invalidateTheme():void
		{
			super.invalidateTheme();
						
			if(!_tabPlace) {
				_tabPlace = addChild(new TShape) as TShape;
			}
			
			if(!_closeSprite) {
				_closeSprite = addChild(new Sprite()) as Sprite;
				_closeSprite.buttonMode = true;
			}
			
			if(_closeSprite.numChildren > 0) {
				_closeSprite.removeChildren(0, _closeSprite.numChildren - 1);
			}
			
			var cls:Class = ThemeManager.theme.asset.getAssetIcon('close');
			if(cls) {
				_closeSprite.addChild(new cls());
			}
			
			_tabGap = "tabGap" in _styleObj ? _styleObj['tabGap'] : 5;
			_tabBtnHeight = "tabBtnHeight" in _styleObj ? _styleObj['tabBtnHeight'] : 20;
			_tabBtnWidth = "tabBtnWidth" in _styleObj ? _styleObj['tabBtnWidth'] : 40;
			_tabBtnTextPadding = "tabBtnTextPadding" in _styleObj ? _styleObj['tabBtnTextPadding'] : 10;
		}
		
		override protected function fillBg(place:String = 'bg'):void
		{
			if(place == 'bg') {
				_bgPlace.fill(explicitWidth, explicitHeight - _tabBtnHeight, _activeBgColor, _activeBgAlpha, _border, _activeBorderColor);
			} else if(place == 'tab') {
				_tabPlace.fill((_text.width > _tabBtnWidth ? _text.width : _tabBtnWidth) + 2 * _tabBtnTextPadding + (_closeSprite ? _closeSprite.width + _tabBtnTextPadding: 0), _tabBtnHeight, _selected ? _bgSelectedColor : _bgColor, _selected ? _bgSelectedAlpha : _bgAlpha);
			}			
		}
		
		private function closeBtnMouseClickListener(event:MouseEvent):void
		{
			_owner.childTrigger(this, 'close');
		}
	}
}