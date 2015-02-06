package te11ur.renderable.components.panel
{
	public interface IPanelEntity
	{
		function get type():String;
		function set type(value:String):void;
		function get resizeFlag():Boolean;
		function get dragFlag():Boolean;
		function get hidden():Boolean;
		function set hidden(value:Boolean):void;
	}
}