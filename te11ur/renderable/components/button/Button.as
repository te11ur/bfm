package te11ur.renderable.components.button
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import te11ur.renderable.components.InteractiveRenderable;
	
	public class Button extends InteractiveRenderable
	{
		public var toggle:Boolean = false;
		
		protected var _textField:TextField;
		protected var _textFormat:TextFormat;
		protected var _textMargin:Number;
		
		private var _text:String = '';
		
		public function Button(style:String="")
		{
			super(style);
		}
		
		public function get text():String
		{
			return _text;	
		}
		
		public function set text(value:String):void
		{
			_text = value;
			
			if(_textField) {
				_textField.text = _text;
			}
		}
		
		override public function render():void
		{				
			if(_textField) {
				_textField.x = (explicitWidth - _textField.width) / 2;
				_textField.y = (explicitHeight - _textField.height) / 2;
			}
			
			explicitWidth = (_textField.width > 70 ? _textField.width : 70) + 2 * _textMargin;
			explicitHeight = (_textField.height > 20 ? _textField.height : 20) + 2 * _textMargin;
			
			super.render();
		}
		
		override public function destroy():void
		{
			if(_textField) {
				removeChild(_textField);
			}
			
			_textField = null;
			super.destroy();
		}	
		
		override protected function determineColor():void
		{
			super.determineColor();
			
			if(_textFormat) {
				_textFormat.color = _activeTextColor;
				_textFormat.bold = _selected;
			}
			
			if(_textField) {
				_textField.setTextFormat(_textFormat);
			}
		}
		
		override protected function mouseClickListener(event:MouseEvent):void
		{
			if(toggle) {
				super.mouseClickListener(event);
			}
			
			_owner.childTrigger(this);
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
			
			if(!_textField) {
				_textField = new TextField();
				_textField.autoSize = TextFieldAutoSize.CENTER;
				_textField.defaultTextFormat = _textFormat;
				_textField.embedFonts = true;
				_textField.mouseEnabled = false;
				_textField.selectable = false;
				_textField.wordWrap = false;
				_textField.text = _text;
				addChild(_textField);
			}
		}
		
		override protected function invalidateTheme():void
		{
			super.invalidateTheme();
			
			_textMargin = "textMargin" in _styleObj ? _styleObj['textMargin'] : 5;			
		}
	}
}