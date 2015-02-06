package te11ur.display
{
	import flash.display.Graphics;

	public interface TGraphic
	{
		function get graphics():Graphics;
		function get width():Number;
		function get height():Number;
		function fill(fillWidth:int = 0, fillHeight:int = 0, fillColor:uint = 0xffffff, fillAlpha:Number = 1, fillBorder:Number = 0, fillBorderColor:uint = 0x000000):void;
	}
}