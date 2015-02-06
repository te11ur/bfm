package te11ur.renderable.components.dropdown
{
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.components.InteractiveRenderable;
	import te11ur.renderable.components.anchor.Anchor;
	import te11ur.renderable.components.anchor.IAnchorOwner;
	import te11ur.renderable.components.list.IList;
	import te11ur.renderable.components.overlay.Overlay;
	import te11ur.renderable.components.overlay.OverlayPosition;
	
	public class BaseDropDown extends InteractiveRenderable implements IList, IAnchorOwner
	{
		public var resetOnClose:Boolean = false;
		public var overlayPosition:String = OverlayPosition.BOTTOM;
		public var openOnOver:Boolean = true;
		
		protected var _listStyle:String = '';
		
		protected var _open:Boolean = false;
		protected var _anchor:Anchor;
		protected var _multySelect:Boolean = false;
		protected var _selectionList:Array = [];
		
		public function BaseDropDown(style:String='')
		{
			super(style);
		}
		
		public function set items(value:Array):void
		{			
		}
		
		public function get multySelect():Boolean
		{
			return _multySelect;
		}
		
		public function set multySelect(value:Boolean):void
		{
			_multySelect = value;
		}
		
		public function get count():int
		{
			return 0;
		}		
		
		public function get selectionList():Array
		{
			return _selectionList;
		}
		
		public function open():void
		{
			if(_anchor && !_open && count > 0) {
				Overlay.I().showAnhor(_anchor, overlayPosition, false);
				_open = true;
			}
		}
		
		public function close():void
		{
			if(_anchor && _open) {
				Overlay.I().closeAnhor(_anchor);
				_open = false;
				if(resetOnClose) {
					reset();
				}				
			}
		}
		
		public function reset():void
		{
		}
		
		override public function render():void
		{	
			super.render();
			
			if(_anchor && !_disable) {
				var ind:Boolean = openOnOver ? _over : _selected;
				if(!_open && ind) {
					open();
				} else if(_open && !_over && !_anchor.over) {
					selectionComplete(this);
					close();
					selected = false;
				}				
			}
		}
		
		override public function childTrigger(child:IRenderable, type:String = '', ...args):void
		{
			if(type == 'selected') {
				selectionComplete(child);
			}
		}
		
		override public function destroy():void
		{
			if(_anchor) {
				_anchor.destroy();
			}
			
			_anchor = null;
			super.destroy();
		}
		
		override protected function init():void
		{
			super.init();
			
			if(!_anchor) {
				_anchor = new Anchor();
				_anchor.owner = this;
			}			
		}
		
		protected function selectionComplete(child:IRenderable):void
		{			
		}
	}
}