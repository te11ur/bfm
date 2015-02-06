package te11ur.renderable.layout
{	
	import te11ur.renderable.components.BaseRenderable;

	public class AreaLayout extends BaseLayout
	{
		public function AreaLayout()
		{
			super();
		}
		
		override protected function postRender(item:BaseRenderable, index:uint):void
		{
			item.x = paddingLeft;
			item.y = paddingTop;
			item.explicitWidth = _renderer.explicitWidth > (paddingLeft + paddingRight) ? _renderer.explicitWidth - (paddingLeft + paddingRight) : 0;
			item.explicitHeight = _renderer.explicitHeight > (paddingTop + paddingBottom) ? _renderer.explicitHeight - (paddingTop + paddingBottom) : 0;
		}
	}
}