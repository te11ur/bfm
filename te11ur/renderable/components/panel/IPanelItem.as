package te11ur.renderable.components.panel
{
	public interface IPanelItem extends IPanelEntity
	{
		function set title(value:String):void;
		function get title():String;
		function get noneExplicitWidth():Number;
		function set noneExplicitWidth(value:Number):void;
		function get noneExplicitHeight():Number;
		function set noneExplicitHeight(value:Number):void;
	}
}