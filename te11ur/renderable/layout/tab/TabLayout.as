package te11ur.renderable.layout.tab
{	
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.layout.stack.IStackLayoutRenderer;
	import te11ur.renderable.layout.stack.StackLayout;
	
	public class TabLayout extends StackLayout
	{		
		private var _tabWidthCounter:Number = 0;
		
		public function TabLayout(st:IStackLayoutRenderer)
		{
			super(st);
		}
		
		override protected function postRender(item:BaseRenderable, index:uint):void
		{			
			if(index - _invisibleCount < 1) {
				_tabWidthCounter = 0;
			}
			
			if(stackLayoutRenderer && item is ITabLayoutItem) {
				item.x = paddingLeft;
				item.y = paddingTop;
				item.explicitWidth = ((_itemWidth <= 2 * (paddingLeft + paddingRight)) ? _renderer.explicitWidth : _itemWidth) - paddingRight;
				item.explicitHeight = ((_itemHeight <= 2 * (paddingTop + paddingBottom)) ? _renderer.explicitHeight : _itemHeight) - paddingBottom;
				
				var tabItem:ITabLayoutItem = ITabLayoutItem(item);
				tabItem.active = (index == stackLayoutRenderer.active);
				tabItem.prevTabsWidth = _tabWidthCounter;
				_tabWidthCounter = tabItem.tabSize.width + tabItem.tabSize.x;
			}
		}
	}
}