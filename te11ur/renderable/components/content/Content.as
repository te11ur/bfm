package te11ur.renderable.components.content
{	
	import te11ur.renderable.components.InteractiveRenderable;

	public class Content extends InteractiveRenderable
	{
		public var dynamicSize:Boolean = true;
		public var itemListWidth:Number = 0;
		public var itemListHeight:Number = 0;		
		
		public function Content(style:String = '')
		{
			super(style);
		}
		
		override public function render():void
		{
			super.render();

			if(dynamicSize && _layout) {
				explicitWidth = _layout.rect.width;
				explicitHeight = _layout.rect.height;
			}
			
		}
	}
}