package te11ur.renderable.theme.black.styles.list
{
	import te11ur.renderable.theme.black.styles.InteractiveRenderableStyle;

	public class ListItemStyle extends InteractiveRenderableStyle
	{
		public var textField:String = 'text';
		public var iconField:String = 'icon';
		public var textMargin:Number = 10;
		
		public function ListItemStyle()
		{
			super();
			bgColor = 0x444444;
		}
	}
}