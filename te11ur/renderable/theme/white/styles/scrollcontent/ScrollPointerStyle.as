package te11ur.renderable.theme.white.styles.scrollcontent
{
	import te11ur.renderable.theme.white.styles.BaseRenderableStyle;

	public class ScrollPointerStyle extends BaseRenderableStyle
	{
		public function ScrollPointerStyle()
		{
			super();
			bgColor = 0x444444;
			colorStates['over'][0] = -0x333333;
			colorStates['selected'][0] = -0x333333;
		}
	}
}