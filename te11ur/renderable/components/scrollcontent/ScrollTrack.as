package te11ur.renderable.components.scrollcontent
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.utils.ApplicationGlobals;

	public class ScrollTrack extends BaseRenderable implements IInternalScrollComponent
	{
		public var position:Number = 0;
		public var pointerExplicitHeight:Number = 0;
		
		private var _scrollPointer:ScrollPointer;
		
		public function ScrollTrack(style:String = '')
		{
			super(style);
		}
		
		override public function render():void
		{
			_scrollPointer.explicitHeight = pointerExplicitHeight;
			_scrollPointer.explicitWidth = explicitWidth;
			
			if(!_scrollPointer.isDraged) {
				_scrollPointer.y = position * (explicitHeight - _scrollPointer.explicitHeight)/ 100;
			}
			
			super.render();	
		}
		
		override public function destroy():void
		{
			(ApplicationGlobals.topLevelApplication as EventDispatcher).removeEventListener(MouseEvent.MOUSE_UP, pointerMouseUpListener);
			(ApplicationGlobals.topLevelApplication as EventDispatcher).removeEventListener(MouseEvent.MOUSE_MOVE, pointerMouseMoveListener);
			
			removeEventListener(MouseEvent.CLICK, trackMouseClickListener);
			
			if(_scrollPointer) {
				_scrollPointer.removeEventListener(MouseEvent.MOUSE_DOWN, pointerMouseDownListener);
				_scrollPointer.removeEventListener(MouseEvent.MOUSE_UP, pointerMouseUpListener);
				_scrollPointer.removeEventListener(MouseEvent.MOUSE_MOVE, pointerMouseMoveListener);
			}
			
			super.destroy();
			_scrollPointer = null;
		}
		
		override protected function init():void
		{
			super.init();
			
			if(!_scrollPointer) {
				_scrollPointer = addRenderable(new ScrollPointer()) as ScrollPointer;
				_scrollPointer.addEventListener(MouseEvent.MOUSE_DOWN, pointerMouseDownListener, false, 0, true);
				_scrollPointer.addEventListener(MouseEvent.MOUSE_UP, pointerMouseUpListener, false, 0, true);
				_scrollPointer.addEventListener(MouseEvent.MOUSE_MOVE, pointerMouseMoveListener, false, 0, true);
			}
			
			(ApplicationGlobals.topLevelApplication as EventDispatcher).addEventListener(MouseEvent.MOUSE_MOVE, pointerMouseMoveListener, false, 0, true);
			(ApplicationGlobals.topLevelApplication as EventDispatcher).addEventListener(MouseEvent.MOUSE_UP, pointerMouseUpListener, false, 0, true);
			
			addEventListener(MouseEvent.CLICK, trackMouseClickListener, false, 0, true);
		}
		
		override protected function fillBg(place:String = 'bg'):void
		{
			if(place == 'bg') {
				_bgPlace.fill(explicitWidth, explicitHeight, _activeBgColor, _activeBgAlpha, _border, _activeBorderColor);
			}			
		}
				
		private function trackMouseClickListener(event:MouseEvent):void
		{			
			calculateNewPosition();
		}
		
		private function pointerMouseDownListener(event:MouseEvent):void
		{
			_scrollPointer.isDraged = true;
			_scrollPointer.startDrag(false, new Rectangle(0, 0, 0, explicitHeight- _scrollPointer.explicitHeight));
		}
		
		private function pointerMouseUpListener(event:MouseEvent):void
		{
			if(_scrollPointer.isDraged) {
				_scrollPointer.stopDrag();
				calculateNewPosition();
				_scrollPointer.isDraged = false;
			}
		}
		
		private function pointerMouseMoveListener(event:MouseEvent):void
		{
			if(!_scrollPointer.isDraged) {
				return;
			}
			calculateNewPosition();		
		}
		
		private function calculateNewPosition():void
		{
			if(_owner is ScrollContent) {				
				ScrollContent(_owner).position = explicitHeight > 0 ? 100 * mouseY / explicitHeight : 0;
			}
		}
	}
}