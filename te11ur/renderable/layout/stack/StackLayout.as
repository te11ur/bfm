package te11ur.renderable.layout.stack
{	
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.layout.BaseLayout;

	public class StackLayout extends BaseLayout
	{
		public var deactiveIsInvisible:Boolean = true;
		
		private var _stackLayoutRenderer:IStackLayoutRenderer
		
		public function StackLayout(st:IStackLayoutRenderer)
		{
			_stackLayoutRenderer = st
			super();
		}
		
		protected function get stackLayoutRenderer():IStackLayoutRenderer
		{
			return _stackLayoutRenderer ? _stackLayoutRenderer : _renderer is IStackLayoutRenderer ? _renderer as IStackLayoutRenderer : null;
		}
		
		override protected function preRender(item:BaseRenderable, index:uint):void
		{
			super.preRender(item, index);
			ignoreInvisible = false;
		}
		
		override protected function postRender(item:BaseRenderable, index:uint):void
		{
			if(stackLayoutRenderer) {
				if(index == stackLayoutRenderer.active) {
					item.visible = true;
					item.x = paddingLeft;
					item.y = paddingTop;
					item.explicitWidth = ((_itemWidth <= 2 * (paddingLeft + paddingRight)) ? _renderer.explicitWidth : _itemWidth) - paddingRight;
					item.explicitHeight = ((_itemHeight <= 2 * (paddingTop + paddingBottom)) ? _renderer.explicitHeight : _itemHeight) - paddingBottom;
				} else {
					item.visible = !deactiveIsInvisible;
				}
			}
		}
	}
}