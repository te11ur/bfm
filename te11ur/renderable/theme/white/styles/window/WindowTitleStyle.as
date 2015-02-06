package te11ur.renderable.theme.white.styles.window
{
	import te11ur.renderable.theme.white.styles.BaseRenderableStyle;

	public class WindowTitleStyle extends BaseRenderableStyle
	{
		public var titleHeight:Number = 30;
		
		public function WindowTitleStyle()
		{
			super();
			textColor = 0x555555;			
			bgColor = 0x999999;
			colorStates['over'][0] = 0;
		}
	}
}