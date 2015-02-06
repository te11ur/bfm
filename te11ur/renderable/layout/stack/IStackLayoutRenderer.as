package te11ur.renderable.layout.stack
{

	public interface IStackLayoutRenderer
	{
		function get history():StackLayoutHistory;
		function set active(value:uint):void;
		function get active():uint;
		function next():void;
		function prev():void;
	}
}