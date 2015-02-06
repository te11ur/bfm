package te11ur.renderable.theme.white.styles.tabcontent
{
	import te11ur.renderable.theme.white.styles.BaseRenderableStyle;
	
	public class TabItemStyle extends BaseRenderableStyle
	{
		public var tabGap:Number = 5;
		public var tabBtnHeight:Number = 30;
		public var tabBtnWidth:Number = 100;
		public var tabBtnTextPadding:Number = 10;
		
		public function TabItemStyle()
		{
			super();
			bgColor = 0xd0d0d0;
			colorStates['selected'][0] = 0x222222;
		}
	}
}