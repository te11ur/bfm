package te11ur.renderable.components.panel
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import te11ur.display.TSprite;
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.components.content.Content;
	import te11ur.renderable.components.window.WindowTitle;
	import te11ur.utils.ApplicationGlobals;
	
	public class PanelItem extends BaseRenderable implements IPanelItem
	{
		public var content:Content;
		public var fixed:Boolean = false;
		public var enableTitle:Boolean = true;
		
		private var _panelTitle:WindowTitle;
		private var _triceColor:uint;
		private var _triceSize:Number;
		private var _title:String = '';
		private var _entity:PanelItemEntity;
		private var _resizeFlag:Boolean = false;
		private var _dragFlag:Boolean = false;
		private var _type:String = PanelItemPosition.NONE;
		private var _trice:TSprite;
		
		private var _noneExplicitWidth:Number = 200;
		private var _noneExplicitHeight:Number = 200;
		
		public function PanelItem(style:String='')
		{
			super(style);
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
			_entity.visible = (_type != PanelItemPosition.NONE);
			_entity.type = PanelItemPosition.NONE;
		}
		
		public function get noneExplicitWidth():Number
		{
			return _noneExplicitWidth;
		}
		
		public function set noneExplicitWidth(value:Number):void
		{
			_noneExplicitWidth = value;;
		}
		
		public function get noneExplicitHeight():Number
		{
			return _noneExplicitHeight;
		}
		
		public function set noneExplicitHeight(value:Number):void
		{
			_noneExplicitHeight = value;
		}
		
		public function get resizeFlag():Boolean
		{
			return _resizeFlag;
		}
		
		public function get dragFlag():Boolean
		{
			return _dragFlag;
		}
		
		override public function set owner(value:IRenderable):void
		{
			super.owner = value;
			
			if(_entity) {
				BaseRenderable(_owner).addRenderable(_entity);
			}
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function set title(value:String):void
		{
			_title = value;
			
			if(_panelTitle) {
				_panelTitle.title = value;
			}
		}
		
		public function set hidden(value:Boolean):void
		{
			disable = value;
		}
		
		public function get hidden():Boolean
		{
			return _disable;
		}
		
		override public function destroy():void
		{			
			if(_panelTitle) {
				_panelTitle.removeEventListener(MouseEvent.MOUSE_DOWN, panelTitleMouseDownListener);
				_panelTitle.removeEventListener(MouseEvent.MOUSE_UP, panelTitleMouseUpListener);
				_panelTitle.removeEventListener(MouseEvent.MOUSE_UP, panelTitleMouseMoveListener);
			}
			
			ApplicationGlobals.topLevelApplication.removeEventListener(MouseEvent.MOUSE_UP, panelTitleMouseUpListener, true);
			
			if(_owner && _entity) {
				BaseRenderable(_owner).removeRenderable(_entity);
			}
			
			if(_trice) {
				_trice.removeEventListener(MouseEvent.CLICK, trickMouseClickListener);
				removeChild(_trice);
			}
			
			_trice = null;
			_entity = null;
			_owner = null;
			super.destroy();
		}
		
		override public function render():void
		{	
			super.render();
			
			if(_trice) {
				switch(_type) {
					case PanelItemPosition.TOP:
						_trice.fill(explicitWidth, _triceSize, _triceColor);
						_trice.x = 0;
						_trice.y = explicitHeight + _border - _triceSize;
						break;
					case PanelItemPosition.RIGHT:
						_trice.fill( _triceSize, explicitHeight, _triceColor);
						_trice.x = 0;
						_trice.y = 0;
						break;
					case PanelItemPosition.LEFT:
						_trice.fill( _triceSize, explicitHeight, _triceColor);
						_trice.x = explicitWidth + _border - _triceSize;
						_trice.y = 0;
						break;
					case PanelItemPosition.BOTTOM:
						_trice.fill(explicitWidth, _triceSize, _triceColor);
						_trice.x = _trice.y = 0;
						break;
					default:
						_trice.fill(3 * _triceSize, 3 *_triceSize, _triceColor);
						_trice.x = explicitWidth - 3 * _triceSize;;
						_trice.y = explicitHeight - 3 * _triceSize;
						break;
				}
			}
			
			if(!_disable) {
				var inV:Boolean = [PanelItemPosition.LEFT, PanelItemPosition.RIGHT].indexOf(_type) >= 0;
				var inH:Boolean = [PanelItemPosition.TOP, PanelItemPosition.BOTTOM].indexOf(_type) >= 0;
				
				_panelTitle.visible = enableTitle;
				
				if(_panelTitle) {
					if(_panelTitle.visible) {
						_panelTitle.explicitWidth = explicitWidth + _border - (inV ? _triceSize : 0);
						_panelTitle.x = (_type == PanelItemPosition.RIGHT) ? _triceSize : 0;
						_panelTitle.y = (_type == PanelItemPosition.BOTTOM) ? _triceSize : 0;
					}
				}
				
				if(content) {
					content.explicitHeight = (_panelTitle.visible ? explicitHeight - _panelTitle.explicitHeight : explicitHeight) - (inH ? _triceSize : 0);
					content.explicitWidth = explicitWidth - _border - (inV ? _triceSize : 0);
					content.x = _border + (_type == PanelItemPosition.RIGHT ? _triceSize : 0);
					content.y = (_panelTitle.visible ? _panelTitle.explicitHeight : 0) + _panelTitle.y;
				}
			}
		}
		
		override public function childTrigger(child:IRenderable, type:String = '', ...args):void
		{
			if(type == 'close') {
				_owner.childTrigger(this, 'close');
			}			
		}
		
		override protected function init():void
		{			
			super.init();
			
			if(!_entity) {
				_entity = new PanelItemEntity(this);
			}
			
			if(!_panelTitle) {
				_panelTitle = addRenderable(new WindowTitle()) as WindowTitle;
				_panelTitle.title = _title;
				_panelTitle.addEventListener(MouseEvent.MOUSE_DOWN, panelTitleMouseDownListener, false, 0, true);
				_panelTitle.addEventListener(MouseEvent.MOUSE_UP, panelTitleMouseUpListener, false, 0, true);
				_panelTitle.addEventListener(MouseEvent.MOUSE_MOVE, panelTitleMouseMoveListener, false, 0, true);
			}
			
			
			ApplicationGlobals.topLevelApplication.addEventListener(MouseEvent.MOUSE_UP, panelTitleMouseUpListener, true, 0, true);
			
			if(!content) {
				content = addRenderable(new Content()) as Content;
				content.interactive = false;
			}
			
			if(!_trice) {
				_trice = addChild(new TSprite()) as TSprite;
				_trice.buttonMode = true;
				_trice.addEventListener(MouseEvent.CLICK, trickMouseClickListener, false, 0, true);
			}
			
			explicitWidth = _noneExplicitWidth;
			explicitHeight = _noneExplicitHeight;
		}
		
		override protected function fillBg(place:String = 'bg'):void
		{
			if(place == 'bg') {
				if(!_disable) {
					_bgPlace.fill(explicitWidth, explicitHeight, _activeBgColor, _activeBgAlpha, _border, _activeBorderColor);
				}				
			}			
		}
		
		override protected function invalidateTheme():void
		{
			super.invalidateTheme();
			
			_triceSize = "triceSize" in _styleObj ? _styleObj['triceSize'] : 4;
			_triceColor = "triceColor" in _styleObj ? _styleObj['triceColor'] : 0xdddddd;
			//_bgDeactiveColor = "bgDeactiveColor" in _styleObj ? _styleObj.bgDeactiveColor : 0xefefef;
		}
		
		private function panelTitleMouseMoveListener(event:MouseEvent):void
		{
			if(_dragFlag) {
				
				var top:BaseRenderable = _owner as BaseRenderable;
				
				if(top) {
					var center:Point = new Point(x + explicitWidth / 2, y + explicitHeight / 2);
					var pos:String = PanelItemPosition.NONE;
					var ps:Number = Math.max(explicitWidth, explicitHeight);
					
					if(center.x < explicitWidth / 2) {
						ps = center.x;
						pos = PanelItemPosition.LEFT;
					} else if(center.y < explicitHeight / 2 && center.y < ps) {
						ps = center.y;
						pos = PanelItemPosition.TOP;
					} else if(center.x > top.explicitWidth - explicitWidth / 2 && (top.explicitWidth - center.x) < ps) {
						ps = top.explicitWidth - center.x;
						pos = PanelItemPosition.RIGHT;
					} else if(center.y > top.explicitHeight - explicitHeight / 2 && (top.explicitHeight - center.y) < ps) {
						ps = top.explicitHeight - center.y;
						pos = PanelItemPosition.BOTTOM;
					}
					
					_entity.type = pos;
					
					if(pos != PanelItemPosition.NONE) {
						_entity.explicitWidth = explicitWidth;
						_entity.explicitHeight = explicitHeight;
					}
				}
				event.updateAfterEvent();
			}
		}
		
		private function panelTitleMouseDownListener(event:MouseEvent):void
		{
			mouseEnabled = true;
			var top:BaseRenderable = _owner as BaseRenderable;
			
			if(top && !fixed) {
				_dragFlag = true;
				startDrag(false);
				top.swapRenderableToTop(this);
			}
		}
		
		private function panelTitleMouseUpListener(event:MouseEvent):void
		{
			if(_dragFlag) {
				type = _entity.type;
			}
			
			stopDrag();
			_dragFlag = false;
		}
		
		private function trickMouseClickListener(event:MouseEvent):void
		{
			_owner.childTrigger(this, 'hidden', _type, !_disable, _triceSize);
		}
	}
}