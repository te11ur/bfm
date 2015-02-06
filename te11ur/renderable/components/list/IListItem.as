package te11ur.renderable.components.list
{
	import te11ur.renderable.components.IRenderable;

	public interface IListItem extends IRenderable
	{
		function get value():Object;
		function get item():Object;		
		function set item(value:Object):void;
	}
}