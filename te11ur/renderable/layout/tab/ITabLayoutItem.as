package te11ur.renderable.layout.tab
{
	import flash.geom.Rectangle;

	public interface ITabLayoutItem
	{
		function set active(value:Boolean):void;
		function get active():Boolean;
		function get tabSize():Rectangle;
		function set prevTabsWidth(value:Number):void;
	}
}