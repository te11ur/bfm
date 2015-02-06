package te11ur.renderable.theme.black.styles.window
{	
	import te11ur.renderable.theme.black.styles.BaseRenderableStyle;

	public class WindowStyle extends BaseRenderableStyle
	{		
		public var bgDeactiveColor:uint = 0x999999;
		public var bgDeactiveAlpha:Number = 0.8;
		public var border:Number = 1;
		public var borderColor:uint = 0xffffff;
		
		public function WindowStyle() 
		{
			super();
			bgAlpha = 1;
		}
	}
}