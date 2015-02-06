package te11ur.renderable.components.alert
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import te11ur.renderable.components.button.Button;
	import te11ur.renderable.components.window.Window;
	
	public class Alert extends Window
	{
		protected var _textColor:uint;
		protected var _textOverColor:uint;
		protected var _textSelectedColor:uint;
		protected var _textMargin:Number;
		protected var _fontSize:Number;
		
		protected var _text:TextField;
		protected var _textFormat:TextFormat;
		
		private var _okButton:Button;
		
		private var _message:String = '';
		
		private static var _win:Alert;
		
		public function Alert(lock:*, style:String='')
		{
			super(style);
			
			if(lock != AlertWindowLock) {
				throw new Error('Singletone');
			}
		}
		
		public static function show(title:String, message:String, alertOwner:IAlertOwner = null):void
		{
			if(_win) {
				_win.hide();
			} else {
				_win = new Alert(AlertWindowLock);
			}
			
			if(alertOwner) {
				_win.show(alertOwner);
				_win.title = title;
				_win.message = message;
			}
		}
		
		public static function hide():void
		{
			if(_win) {
				_win.hide();
			}
		}	
		
		public function get message():String
		{
			return _message;
		}
		
		public function set message(value:String):void
		{
			_message = value;
			
			if(_text) {
				_text.text = _message;
			}
		}
		
		override public function render():void
		{	
			super.render();
			
			if(_text && _okButton) {
				
				_text.width = (_text.text.length < 100) ? 300 : 600;
				_text.y = (_windowTitle.visible ? _windowTitle.explicitHeight : 0) + _textMargin;
				_text.x = _border + _textMargin;
				_text.height = _fontSize * (_text.numLines + 3);
				
				_okButton.x = (explicitWidth - _okButton.explicitWidth) / 2;
				_okButton.y = _text.y+ _text.height+ _textMargin;
				
				explicitWidth = _text.width + 2 * (_border + _textMargin);
				explicitHeight = (_windowTitle.visible ? _windowTitle.explicitHeight : 0) + 2 * (_border + _textMargin) + (_text.y + _text.height);
			}
		}
		
		override public function destroy():void
		{
			if(_text) {
				removeChild(_text);
			}
			
			_text = null;
			super.destroy();
		}
		
		override protected function init():void
		{
			super.init();
			
			if(!_textFormat) {
				_textFormat = new TextFormat();
				_textFormat.color = _textColor;
				_textFormat.font = _defaultFontName;
				_textFormat.size = _fontSize;
				_textFormat.align = TextFormatAlign.CENTER;
			}
			
			if(!_text) {
				_text = new TextField();
				//_text.autoSize = TextFieldAutoSize.LEFT;
				_text.defaultTextFormat = _textFormat;
				_text.mouseEnabled = false;
				_text.embedFonts = true;
				_text.multiline = true;
				_text.wordWrap = true;
				_text.text = _message;
				addChild(_text);
			}
			
			if(!_okButton) {
				_okButton = addRenderable(new Button()) as Button;
				_okButton.text = 'OK';
			}
		}
		
		override protected function invalidateTheme():void
		{
			super.invalidateTheme();
			_textMargin = "textMargin" in _styleObj ? _styleObj['textMargin'] : 10;
			_fontSize = "fontSize" in _styleObj ? _styleObj['fontSize'] : 12;
		}
	}
}
class AlertWindowLock{}