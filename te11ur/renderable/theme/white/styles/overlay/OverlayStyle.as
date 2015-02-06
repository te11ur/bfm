package te11ur.renderable.theme.white.styles.overlay
{
	import te11ur.renderable.theme.white.styles.BaseRenderableStyle;

	public class OverlayStyle extends BaseRenderableStyle
	{		
		public function OverlayStyle()
		{
			super();			
			bgColor = 0x777777;
			bgAlpha = 0.3;
			alphaStates['disable'][0] = -1;
		}
	}
}