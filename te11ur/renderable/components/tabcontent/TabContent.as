package te11ur.renderable.components.tabcontent
{
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.layout.stack.IStackLayoutRenderer;
	import te11ur.renderable.layout.stack.StackLayoutHistory;
	import te11ur.renderable.layout.tab.TabLayout;
	
	public class TabContent extends BaseRenderable implements ITabContent, IStackLayoutRenderer
	{
		public var destroyOnClose:Boolean = true;
		private var _history:StackLayoutHistory;
		private var _active:uint = 0;
		
		public function TabContent(style:String='')
		{
			super(style);
		}
		
		public function get history():StackLayoutHistory
		{
			return _history;
		}
		
		public function set active(value:uint):void
		{
			if(value > _itemPlace.numChildren -1) {
				_active = _itemPlace.numChildren -1;
			} else {
				_active = value;
			}
		}
		
		public function get active():uint
		{
			return _active;
		}
		
		public function next():void
		{
			if(_active + 1 > _itemPlace.numChildren -1) {
				_active = 0;
			} else {
				_active++;
			}
		}
		
		public function prev():void
		{
			if(_active - 1 < 0) {
				_active = _itemPlace.numChildren -1;
			} else {
				_active--;
			}
		}
		
		override public function render():void
		{
			super.render();
			//_bgPlace.fill(explicitWidth, explicitHeight, _bgColor, 0);
		}
		
		override public function childTrigger(child:IRenderable, type:String = '', ...args):void
		{
			if(type == 'close') {
				
				removeRenderable(child);
				
				if(destroyOnClose) {
					child.destroy();
				}
				
				active = (child as TabItem).index;
			}
		}
		
		override public function destroy():void
		{
			_history = null;
			super.destroy();
		}
		
		override protected function init():void
		{
			super.init();
			
			if(!layout) {
				var tl:TabLayout = new TabLayout(this);
				tl.paddingTop = 1;
				tl.paddingRight = 1;
				tl.paddingBottom = 1;
				tl.paddingLeft = 1;
				layout = tl;
			}
			
			if(!_history) {
				_history = new StackLayoutHistory(this);
			}
		}
	}
}