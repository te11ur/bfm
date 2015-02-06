package te11ur.renderable.layout
{	
	import te11ur.renderable.components.BaseRenderable;

	public class TailLayout extends BaseLayout
	{
		public function TailLayout()
		{
			super();
		}
		
		override protected function preRender(item:BaseRenderable, index:uint):void
		{
			super.preRender(item, index);
			
			var vsIndex:int = index - _invisibleCount;
			
			if(vsIndex < 1) {
				_itemWidth = _itemWidth < 1 ? (_itemHeight < 0 ? 0 : _itemHeight) : _itemWidth;
				_itemHeight = _itemHeight < 1 ? _itemWidth : _itemHeight;
			}
		}
		
		override protected function postRender(item:BaseRenderable, index:uint):void
		{
			var vsIndex:int = index - _invisibleCount;
			
			if(dynamicSize) {
				//TODO: Сделать
			} else {
				
				var kt:Number = paddingLeft + paddingRight;
				var per:Number = Math.floor((_renderer.explicitWidth - kt)/ (kt + item.explicitWidth));
				
				if(per < 1) {
					per = 1;
				}
				
				if(justify) {
					var cp:Number = _renderer.explicitWidth - (per * (kt + item.explicitWidth) + kt);
					kt += cp / per;
				}
				
				item.x = (vsIndex % per) * (kt + item.explicitWidth) + kt;
				item.y = Math.ceil((vsIndex + 1) / per - 1) * (paddingTop + paddingBottom + item.explicitHeight) + paddingTop + paddingBottom;
				item.explicitWidth = _itemWidth;
				item.explicitHeight = _itemHeight;
			}
		}
	}
}