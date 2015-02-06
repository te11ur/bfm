package te11ur.renderable.components.overlay
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.components.anchor.Anchor;
	import te11ur.renderable.components.window.IWindow;
	import te11ur.renderable.components.window.IWindowOwner;

	public class Overlay extends BaseRenderable
	{
		private static var _instance:Overlay;
		
		public function Overlay(lock:*)
		{
			super();
			
			if(lock != OverlayLock) {
				throw new Error('Singletone');
			}
			
			disable = true;
		}
		
		public static function I():Overlay
		{
			if(!_instance) {
				_instance = new Overlay(OverlayLock);
			}
			
			return _instance;
		}
		
		public function showAnhor(anhor:Anchor, position:String = "bottom", closeAll:Boolean = true):void
		{
			anhor.position = position;
			
			var found:Boolean = false;
			for(var i:int = 0; i < _itemPlace.numChildren; i++) {
				var anc:Anchor = _itemPlace.getChildAt(i) as Anchor;
				if(anc) {
					if(anc == anhor) {
						anc.visible = true;
						found = true;
					} else if(closeAll) {
						anc.visible = false;
					}
				}
			}
			
			if(!found) {
				addRenderable(anhor);
				anhor.visible = true;
				found = true;
			}
			
			if(found) {
				if(anhor.position == OverlayPosition.GLOBAL_CENTER) {
					mouseEnabled = true;
					disable = false;
				}
			}
		}
		
		public function closeAnhor(anhor:Anchor = null):void
		{
			for(var i:int = 0; i < _itemPlace.numChildren; i++) {
				var anc:Anchor = _itemPlace.getChildAt(i) as Anchor;
				if(anc) {
					if(anc.destroed) {
						_itemPlace.removeChild(anc);
						continue;
					}
					
					if(!anhor || anc == anhor) {
						anc.visible = false;
					}
				}
			}
			
			deactivate();
		}
		
		public function showWindow(window:IWindow, windowOwner:IWindowOwner):void
		{
			var found:Boolean = false;
			
			for(var i:int = 0; i < _itemPlace.numChildren; i++) {
				var win:IWindow = _itemPlace.getChildAt(i) as IWindow;
				if(win) {
					if(win == window) {
						found = true;
						break;
					}
				}
			}
			
			if(!found) {
				addRenderable(window, true, windowOwner as IRenderable);
			}
			
			disable = false;
		}
		
		public function closeWindow(window:IWindow):void
		{			
			for(var i:int = 0; i < _itemPlace.numChildren; i++) {
				var win:IWindow = _itemPlace.getChildAt(i) as IWindow;
				if(win) {
					if(win == window) {
						removeRenderable(window);
						break;
					}
				}
			}
			deactivate();
		}
		
		override public function destroy():void
		{
			removeEventListener(MouseEvent.CLICK, overlayMouseClickListener);
			super.destroy();
		}
		
		override protected function init():void
		{
			super.init();
			
			mouseEnabled = false;
			
			addEventListener(MouseEvent.CLICK, overlayMouseClickListener, false, 0, true);
		}
		
		override protected function fillBg(place:String = 'bg'):void
		{
			if(place == 'bg') {
				_bgPlace.fill(explicitWidth, explicitHeight, _activeBgColor, _activeBgAlpha, _border, _activeBorderColor);
			}			
		}
		
		private function overlayMouseClickListener(event:MouseEvent):void
		{
			if(event.target == this) {
				closeAnhor();
			}
		}
		
		private function deactivate():void
		{
			for(var i:int = 0; i < _itemPlace.numChildren; i++) {
				var ds:DisplayObject = _itemPlace.getChildAt(i);
				if(ds.visible) {
					if(ds is Anchor) {
						if(Anchor(ds).position == OverlayPosition.GLOBAL_CENTER) {
							disable = false;
							mouseEnabled = true;
							return;
						}
					} else if(ds is IWindow) {
						disable = false;
						mouseEnabled = true;
						return;
					}
				}
			}
			disable = true;
			mouseEnabled = false;
		}
		
		override protected function invalidateTheme():void
		{
			super.invalidateTheme();
		}
		
		override protected function determineColor():void
		{
			super.determineColor();
		}
	}
}
class OverlayLock{}