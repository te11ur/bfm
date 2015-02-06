package te11ur.renderable.components.menu
{
	import te11ur.renderable.components.list.ListItem;
	
	public class MenuItem extends ListItem implements IMenuItem
	{
		public function MenuItem(item:Object, style:String='')
		{
			super(item, style);
		}
	}
}