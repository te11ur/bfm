package te11ur.renderable.theme.white.styles.button
{
	import te11ur.renderable.theme.white.styles.BaseRenderableStyle;
	
	public class ButtonStyle extends BaseRenderableStyle
	{
		public function ButtonStyle()
		{
			super();
			bgColor = 0xdddddd;
			colorStates['over'][0] = -0x0c0c0c;
			colorStates['selected'][0] = -0x0c0c0c;
			border = 1;
		}
	}
}