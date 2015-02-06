package te11ur.renderable.components.window
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import te11ur.renderable.ThemeManager;
	import te11ur.renderable.components.InteractiveRenderable;
	
	public class WindowTitle extends InteractiveRenderable
	{		
		protected var _closeSprite:Sprite;
		protected var _text:TextField;
		protected var _textFormat:TextFormat;
		protected var _title:String = '';
		
		public function WindowTitle(style:String = '')
		{
			super(style);
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function set title(value:String):void
		{
			_title = value;
			
			if(_text) {
				_text.text = value;
			}
		}
		
		override public function render():void
		{	
			super.render();
			
			if(_closeSprite) {
				_closeSprite.x = explicitWidth - 2 * _closeSprite.width;
				_closeSprite.y = (explicitHeight - _closeSprite.height) / 2;
			}
			
			if(_text) {
				_text.x = 10;
				_text.y = (explicitHeight - _text.height) / 2;
				_text.visible = _text.width <= explicitWidth;
			}
		}
		
		override public function destroy():void
		{
			removeCloseBtn();
			
			if(_text) {
				removeChild(_text);
			}
			
			_text = null;
			_textFormat = null;
			super.destroy();
		}
				
		override protected function init():void
		{
			super.init();
			
			if(!_textFormat) {
				_textFormat = new TextFormat();
				_textFormat.color = _textColor;
				_textFormat.font = _defaultFontName;
				_textFormat.size = 12;
			}
			
			if(!_text) {
				_text = new TextField();
				_text.autoSize = TextFieldAutoSize.LEFT;
				_text.defaultTextFormat = _textFormat;
				_text.mouseEnabled = false;
				_text.embedFonts = true;
				_text.selectable = false;
				_text.text = _title;
				addChild(_text);
			}
		}
		
		override protected function invalidateTheme():void
		{
			super.invalidateTheme();
			
			removeCloseBtn();
			
			if(!_closeSprite) {
				var closeClass:Class = ThemeManager.theme.asset.getAssetIcon('close');
				
				if(closeClass) {
					_closeSprite = addChild(new Sprite()) as Sprite;
					_closeSprite.addChild(new closeClass());
					_closeSprite.buttonMode = true;
					_closeSprite.addEventListener(MouseEvent.CLICK, closeBtnClickListener, false, 0, true);
					addChild(_closeSprite);
				}
			}
			
			explicitHeight = "titleHeight" in _styleObj ? _styleObj['titleHeight'] : 30;
		}
		
		override protected function mouseClickListener(event:MouseEvent):void
		{
		}
		
		protected function closeBtnClickListener(event:MouseEvent):void
		{
			_owner.childTrigger(this, 'close');		
		}
		
		private function removeCloseBtn():void
		{
			if(_closeSprite) {
				_closeSprite.removeChildren(0, _closeSprite.numChildren - 1);
				_closeSprite.removeEventListener(MouseEvent.CLICK, closeBtnClickListener);
				removeChild(_closeSprite);
				_closeSprite = null;
			}
		}
	}
}