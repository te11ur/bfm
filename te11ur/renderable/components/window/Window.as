package te11ur.renderable.components.window
{	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.components.overlay.Overlay;
	import te11ur.renderable.components.scrollcontent.ScrollContent;
	
	public class Window extends BaseRenderable implements IWindow
	{
		private static var _windowStack:Array = [];
		
		public var dragOnOverlay:Boolean = true;
		
		/*protected var _border:Number;
		protected var _borderColor:uint;
		private var _bgDeactiveColor:uint;
		private var _bgDeactiveAlpha:Number;*/
		
		protected var _windowTitle:WindowTitle;
		protected var _content:BaseRenderable;
		private var _firstDrag:Boolean = false;
		private var _title:String = '';

		public function Window(style:String = '')
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
			
			if(_windowTitle) {
				_windowTitle.title = value;
			}
		}
		
		public function get content():BaseRenderable
		{
			if(!_content) {
				_content = addRenderable(new ScrollContent('WindowContentStyle')) as ScrollContent;
			}
			
			return _content;
		}
		
		public function show(windowOwner:IWindowOwner):void
		{
			visible = true;
			Overlay.I().showWindow(this, windowOwner);
			active();
		}
		
		public function hide():void
		{
			visible = false;
			Overlay.I().closeWindow(this);
			owner.childTrigger(this);
		}
		
		public function active():void
		{
			for each(var w:IWindow in _windowStack) {
				if(w != this) {
					w.deactive();
				}
			}
			
			if(_windowTitle) {
				_windowTitle.selected = true;
			}
			
			Overlay.I().swapRenderableToTop(this);
			disable = false;
		}
		
		public function deactive():void
		{
			if(_windowTitle) {
				_windowTitle.selected = false;
			}
			
			disable = true;
		}
		
		override public function render():void
		{	
			super.render();
			
			if(_windowTitle) {
				_windowTitle.explicitWidth = explicitWidth + _border;
			}
			
			if(_content) {
				_content.explicitHeight = _windowTitle.visible ? explicitHeight - _windowTitle.explicitHeight : explicitHeight;
				_content.explicitWidth = explicitWidth - _border;
				_content.y = _windowTitle.visible ? _windowTitle.explicitHeight : 0;
				_content.x = _border;
			}
			
			//_bgPlace.fill(explicitWidth, explicitHeight, _active ? _bgColor : _bgDeactiveColor, _active ? _bgAlpha : _bgDeactiveAlpha, _border, _borderColor);
			
			if(!_firstDrag) {
				var overlay:Overlay = Overlay.I();
				x = (overlay.explicitWidth - explicitWidth) / 2;
				y = (overlay.explicitHeight - explicitHeight) / 2;
			}
		}
		
		override public function destroy():void
		{
			if(_windowTitle) {
				_windowTitle.removeEventListener(MouseEvent.MOUSE_DOWN, windowTitleMouseDownListener);
				_windowTitle.removeEventListener(MouseEvent.MOUSE_UP, windowTitleMouseUpListener);
			}
			
			var ind:int = _windowStack.indexOf(this);
			
			if(ind >= 0) {
				_windowStack.splice(ind, 1);
			}
			
			super.destroy();
		}
		
		override public function childTrigger(child:IRenderable, type:String = '', ...args):void
		{
			hide();
		}
		
		override protected function init():void
		{
			visible = false;
			
			super.init();
			
			explicitHeight = 200;
			explicitWidth = 200;
			
			if(!_windowTitle) {
				_windowTitle = addRenderable(new WindowTitle()) as WindowTitle;
				_windowTitle.title = _title;
				_windowTitle.addEventListener(MouseEvent.MOUSE_DOWN, windowTitleMouseDownListener, false, 0, true);
				_windowTitle.addEventListener(MouseEvent.MOUSE_UP, windowTitleMouseUpListener, false, 0, true);
			}
			
			var ind:int = _windowStack.indexOf(this);
			
			if(ind < 0) {
				_windowStack.push(this);
			}
		}
		
		override protected function fillBg(place:String = 'bg'):void
		{			
			if(place == 'bg') {
				_bgPlace.fill(explicitWidth, explicitHeight, _activeBgColor, _activeBgAlpha, _border, _activeBorderColor);
			}	
		}
		
		/*override protected function invalidateTheme():void
		{
			super.invalidateTheme();
			
			_bgDeactiveColor = "bgDeactiveColor" in _styleObj ? _styleObj['bgDeactiveColor'] : 0xefefef;
			_bgDeactiveAlpha = "bgDeactiveAlpha" in _styleObj ? _styleObj['bgDeactiveAlpha'] : 1;
			_border = "border" in _styleObj ? _styleObj['border'] : 1;
			_borderColor = "borderColor" in _styleObj ? _styleObj['borderColor'] : 0x000000;
		}*/
		
		private function windowTitleMouseDownListener(event:MouseEvent):void
		{
			active();
			_firstDrag = true;
			mouseEnabled = true;
			startDrag(false, dragOnOverlay ? new Rectangle(0, 0, Overlay.I().explicitWidth - explicitWidth, Overlay.I().explicitHeight - explicitHeight) : null);
		}
		
		private function windowTitleMouseUpListener(event:MouseEvent):void
		{
			stopDrag();
		}
	}
}