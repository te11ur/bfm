package te11ur.renderable.layout
{
	import flash.geom.Rectangle;
	
	import te11ur.renderable.components.BaseRenderable;
	
	public class HListLayout extends BaseLayout
	{
		public function HListLayout()
		{
			super();
		}
		
		override protected function preRender(item:BaseRenderable, index:uint):void
		{
			super.preRender(item, index);
			
			if(index < 1) {
				if(!_itemHeightFlag) {
					_itemHeight =  _renderer.explicitHeight;
				}
			}
			
			if(!_itemWidthFlag) {
				_itemWidth =  item.explicitWidth;
			}
		}
		
		override protected function postRender(item:BaseRenderable, index:uint):void
		{
			var vsIndex:int = index - _invisibleCount;
			var rec:Rectangle;
			
			item.y = paddingTop;
			
			if(dynamicSize) {
				var prev:BaseRenderable = getPreviousItem(index);
				if(prev) {
					item.x = prev.x + prev.explicitWidth + paddingLeft;
				} else {
					item.x = 0;
				}
				item.explicitWidth = _itemWidth;
				
			} else {
				item.x = vsIndex * (_itemWidth + paddingLeft);
				item.explicitWidth = _itemWidth;
			}
			
			if(justify) {
				if(!cycle) {
					rec = getRect();
					item.explicitHeight = rec.height;
				} else {
					item.explicitHeight = _itemHeight;
				}
			} else {
				item.explicitHeight = _itemHeight;
			}
		}
	}
}