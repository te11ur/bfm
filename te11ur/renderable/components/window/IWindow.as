package te11ur.renderable.components.window
{
	import te11ur.renderable.components.IRenderable;

	public interface IWindow extends IRenderable
	{
		function get title():String;
		function set title(value:String):void;
		function show(windowOwner:IWindowOwner):void;
		function hide():void;
		function active():void;
		function deactive():void;
	}
}