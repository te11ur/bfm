package te11ur.renderable.theme.black.styles.window
{
	import te11ur.renderable.theme.black.styles.InteractiveRenderableStyle;

	public class WindowTitleStyle extends InteractiveRenderableStyle
	{
		public var windowTitleHeight:Number = 20;
		
		public function WindowTitleStyle()
		{
			super();
			textColor = 0x000000;
			textOverColor = 0x000000;
			textSelectedColor = 0x555555;
			
			bgColor = 0xffffff;
			bgOverColor = 0xffffff;
			bgSelectedColor = 0xeeeeee;
		}
	}
}