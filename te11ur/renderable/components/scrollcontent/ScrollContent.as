package te11ur.renderable.components.scrollcontent
{
	import flash.events.MouseEvent;
	
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.layout.BaseLayout;

	public class ScrollContent extends BaseRenderable
	{
		protected var _scrollSpeed:uint;
		protected var _scrollSize:Number;
		
		protected var _scrollPlace:ScrollPlace;
		protected var _scrollTrack:ScrollTrack;
		private var _position:Number = 0;
		
		public function ScrollContent(style:String = '')
		{
			super(style);
		}
		
		public function get scrollPlace():ScrollPlace
		{
			return _scrollPlace;
		}
		
		override public function get numRenderable():int
		{
			return _scrollPlace.numRenderable;
		}
		
		override public function addRenderable(rendereble:IRenderable, force:Boolean = false, childOwner:IRenderable = null):IRenderable
		{
			if(rendereble is IInternalScrollComponent) {
				return super.addRenderable(rendereble, force, childOwner);
			}
			
			return _scrollPlace.addRenderable(rendereble, force, childOwner);
		}
		
		override public function removeAllRenderable(from:uint = 0):void
		{			
			_scrollPlace.removeAllRenderable(from);
		}
		
		override public function removeRenderable(rendereble:IRenderable):IRenderable
		{
			if(rendereble is IInternalScrollComponent) {
				return super.removeRenderable(rendereble);
			}
			
			return _scrollPlace.removeRenderable(rendereble);
		}
		
		override public function getRenderableByName(name:String):IRenderable
		{
			return _scrollPlace.getRenderableByName(name);
		}
		
		override public function getRenderableByIndex(index:int):IRenderable
		{
			return _scrollPlace.getRenderableByIndex(index);
		}
		
		public function set position(value:Number):void
		{
			if(value > 100) {
				value = 100;
			}
			
			if(value < 0) {
				value = 0;
			}
			
			_position = value;
			
			if(_scrollPlace) {
				_scrollPlace.position = _position;
			}
			
			if(_scrollTrack) {
				_scrollTrack.position = _position;
			}			
			
			owner.childTrigger(this, 'scroll');
		}
		
		public function get position():Number
		{
			return _position;
		}
		
		override public function set layout(value:BaseLayout):void
		{
			if(_scrollPlace) {
				value.renderer = _scrollPlace;
				value.trigger = true;
				_scrollPlace.layout = value;
			}
		}
		
		override public function render():void
		{
			
			if(_scrollPlace) {
				_scrollPlace.explicitWidth = explicitWidth;
				_scrollPlace.explicitHeight = explicitHeight;
			}
			
			if(_scrollTrack) {
				
				_scrollTrack.explicitWidth = _scrollSize;
				
				_scrollTrack.x = explicitWidth - _scrollTrack.explicitWidth;
				
				_scrollTrack.visible = (_scrollPlace.layout.rect.height > _scrollPlace.explicitHeight);
				
				_scrollTrack.pointerExplicitHeight = Math.round(_scrollSize);
				
				_scrollTrack.explicitHeight = explicitHeight;
				
				if(_scrollPlace.layout.rect.height > 0) {
					_scrollTrack.pointerExplicitHeight = Math.round(_scrollPlace.explicitHeight * _scrollTrack.explicitHeight / _scrollPlace.layout.rect.height);
					if(_scrollTrack.pointerExplicitHeight < _scrollSize) {
						_scrollTrack.pointerExplicitHeight = _scrollSize;
					}
				}
				
			}
			
			if(_scrollPlace && _scrollTrack) {
				_scrollPlace.explicitWidth -= _scrollTrack.visible ? _scrollTrack.explicitWidth : 0;
			}
			
			super.render();
		}
		
		override public function destroy():void
		{
			removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelListener);

			super.destroy();
			
			_scrollPlace = null;
			_scrollTrack = null;
		}
		
		override protected function init():void
		{
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelListener, false, 0, true);
			
			super.init();
			
			if(!_scrollPlace) {
				_scrollPlace = addRenderable(new ScrollPlace()) as ScrollPlace;
			}
			
			if(!_scrollTrack) {
				_scrollTrack = addRenderable(new ScrollTrack()) as ScrollTrack;
			}
		}
		
		override protected function invalidateTheme():void
		{
			super.invalidateTheme();
			
			_scrollSpeed = "scrollSpeed" in _styleObj ? _styleObj['scrollSpeed'] : 2;
			_scrollSize = "scrollSize" in _styleObj ? _styleObj['scrollSize'] : 10;
		}

		override protected function fillBg(place:String = 'bg'):void
		{
			if(place == 'bg') {
				_bgPlace.fill(explicitWidth, explicitHeight, _activeBgColor, _activeBgAlpha, _border, _activeBorderColor);
			}			
		}	
		
		private function mouseWheelListener(event:MouseEvent):void
		{
			//if(!event.isDefaultPrevented()) {
				position += (event.delta > 0 ? -1 : 1) * 100 *  _scrollSpeed * _scrollPlace.layout.scrollHDeff;
				//event.stopPropagation();
			//}			
		}
	}
}