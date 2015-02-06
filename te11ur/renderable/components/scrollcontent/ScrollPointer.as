package te11ur.renderable.components.scrollcontent
{	
	import te11ur.renderable.components.InteractiveRenderable;

	public class ScrollPointer extends InteractiveRenderable
	{
		public var isDraged:Boolean = false;
		
		public function ScrollPointer(style:String = '')
		{
			super(style);
		}
	}
}