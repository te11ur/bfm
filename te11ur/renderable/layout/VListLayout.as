package te11ur.renderable.layout
{
	import flash.geom.Rectangle;
	
	import te11ur.renderable.components.BaseRenderable;
	
	public class VListLayout extends BaseLayout
	{
		public function VListLayout()
		{
			super();
		}
				
		override protected function preRender(item:BaseRenderable, index:uint):void
		{
			super.preRender(item, index);

			if(index < 1) {
				if(!_itemWidthFlag) {
					_itemWidth =  _renderer.explicitWidth;
				}
			}
			
			if(!_itemHeightFlag) {
				_itemHeight =  item.explicitHeight;
			}
		}
		
		override protected function postRender(item:BaseRenderable, index:uint):void
		{
			var vsIndex:int = index - _invisibleCount;
			var rec:Rectangle;
			
			item.x = paddingLeft;
			
			if(dynamicSize) {
				var prev:BaseRenderable = getPreviousItem(index);
				if(prev) {
					item.y = prev.y + prev.explicitHeight + paddingTop;
				} else {
					item.y = 0;
				}
				item.explicitHeight = _itemHeight;
			} else {
				item.y = vsIndex * (_itemHeight + paddingTop);
				item.explicitHeight = _itemHeight;
			}
				
			if(justify) {
				if(!cycle) {
					rec = getRect();
					item.explicitWidth = rec.width;
				} else {
					item.explicitWidth = _itemWidth;
				}
			} else {
				item.explicitWidth = _itemWidth;
			}
		}
	}
}