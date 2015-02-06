package te11ur.renderable.layout.menu
{
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.layout.BaseLayout;
	
	public class MenuLayout extends BaseLayout
	{
		public var stretch:Boolean = false;
		
		public function MenuLayout()
		{
			super();
		}
		
		override protected function preRender(item:BaseRenderable, index:uint):void
		{
			super.preRender(item, index);
		}
		
		override protected function postRender(item:BaseRenderable, index:uint):void
		{
			
		}
	}
}