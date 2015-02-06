package te11ur.renderable.components.list
{	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import te11ur.renderable.components.InteractiveRenderable;
	
	public class ListItem extends InteractiveRenderable implements IListItem
	{		
		protected var _item:Object= null;
		protected var _iconField:String;
		protected var _textField:String;
		protected var _valueField:String;
		protected var _textMargin:Number;
		
		protected var _icon:DisplayObject;
		private var _text:TextField;
		private var _textFormat:TextFormat;
		protected var _value:Object;
		
		public function ListItem(item:Object, style:String = '')
		{
			_item = item;
			super(style);
		}
		
		override public function set over(value:Boolean):void
		{	
			super.over = value;
		}
		
		public function get value():Object
		{
			return _value;
		}
		
		public function get item():Object
		{
			return _item;
		}
		
		public function set item(value:Object):void
		{
			_item = value;
			buildFields();
		}
		
		override public function render():void
		{	
			if(_icon) {
				_icon.x = _textMargin;
				_icon.y = (explicitHeight - _icon.height) / 2;
			}
			
			if(_text) {
				_text.x = _textMargin + (_icon ? _textMargin + _icon.width : 0);
				_text.y = (explicitHeight - _text.height) / 2;
			}
			
			if(_owner) {
				if(_selected) {
					if(IList(_owner).selectionList.indexOf(_value) < 0) {
						selected = false;
					}
				} else {
					if(IList(_owner).selectionList.indexOf(_value) >= 0) {
						selected = true;
					}
				}				
			}
			
			super.render();
		}
		
		override protected function determineColor():void
		{
			super.determineColor();
			
			if(_textFormat) {
				_textFormat.color = _activeTextColor;
			}
			
			if(_text) {
				_text.setTextFormat(_textFormat);
			}
		}
		
		override protected function init():void
		{
			super.init();
			buildFields();
		}
		
		override public function destroy():void
		{
			if(_icon) {
				removeChild(_icon);				
				if(_icon is Loader) {
					var l:Loader = _icon as Loader;
					l.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
					l.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
				}				
			}
			
			if(_text) {
				removeChild(_text);
			}
			
			_text = null;
			_icon = null;
			_value = null;
			_owner = null;
			_textFormat = null;
			
			super.destroy();
		}

		
		override protected function invalidateTheme():void
		{
			super.invalidateTheme();
			
			_textField = "textField" in _styleObj ? _styleObj['textField'] : 'text';
			_iconField = "iconField" in _styleObj ? _styleObj['iconField'] : 'icon';
			_valueField = "valueField" in _styleObj ? _styleObj['valueField'] : 'value';
			_textMargin = "textMargin" in _styleObj ? _styleObj['textMargin'] : 10;
		}
		
		override protected function mouseClickListener(event:MouseEvent):void
		{
			super.mouseClickListener(event);
			
			_owner.childTrigger(this, 'click', _selected, _value);
		}
		
		protected function buildFields():void
		{
			var buildedIcon:Boolean = false;
			
			if(_item) {
				if(_valueField in _item) {
					_value = _item[_valueField];
				}
				
				if(_iconField in _item) {
					if(_icon) {
						removeChild(_icon);
					}
					
					if(_item[_iconField] is Class) {
						_icon = addChild(new _item[_iconField]());
					} else if(_item[_iconField] is DisplayObject) {
						_icon = addChild(_item[_iconField]);
					} else if(_item[_iconField] is String) {
						_icon = addChild(new Loader());
						var l:Loader = _icon as Loader;
						l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
						l.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError, false, 0, true);
						l.load(new URLRequest(_item[_iconField]));
					}
					
					buildedIcon = true;
				}
				
				if(_item[_textField]) {
					
					var s:String = String(_item[_textField]);
					
					if(s.length > 0) {
						
						if(!_textFormat) {
							_textFormat = new TextFormat();
							_textFormat.color = _textColor;
							_textFormat.font = _defaultFontName;
							_textFormat.size = 12;
							_textFormat.rightMargin = 10;
						}
						
						if(!_text) {
							_text = new TextField();
							_text.autoSize = TextFieldAutoSize.LEFT;
							_text.defaultTextFormat = _textFormat;
							_text.embedFonts = true;
							_text.mouseEnabled = false;
							_text.selectable = false;
							_text.text = String(_item[_textField]);
							addChild(_text);
						}
					}
				}
			}
			
			if(!buildedIcon) {
				if(_icon) {
					removeChild(_icon);
				}
				_icon = null;
			}
		}
		
		private function onError(event:Event):void
		{
			trace('Error load icon');
		}
	}
}