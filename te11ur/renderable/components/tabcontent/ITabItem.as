package te11ur.renderable.components.tabcontent
{
	import te11ur.renderable.components.BaseRenderable;

	public interface ITabItem
	{
		function set title(value:String):void;
		function get title():String;
		function get content():BaseRenderable;
	}
}