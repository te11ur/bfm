package te11ur.renderable.components.list
{
	public interface IList
	{
		function get multySelect():Boolean;
		function set multySelect(value:Boolean):void;
		function get selectionList():Array;
		function reset():void;
	}
}