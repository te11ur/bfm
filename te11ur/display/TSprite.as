package te11ur.display
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	public class TSprite extends Sprite implements TGraphic
	{
		protected var _fillColor:uint = 0xffffff;
		protected var _fillAlpha:Number = 1;
		
		protected var _fillBorder:Number = 0;
		protected var _fillBorderColor:uint = 0x000000;
		
		public function TSprite()
		{
			super();
		}
		
		public function fill(fillWidth:int = 0, fillHeight:int = 0, fillColor:uint = 0xffffff, fillAlpha:Number = 1, fillBorder:Number = 0, fillBorderColor:uint = 0x000000):void
		{
			if(!visible || (fillWidth == width && fillHeight == height && fillColor == _fillColor && fillAlpha == fillAlpha && fillBorder == _fillBorder && fillBorderColor == _fillBorderColor)) {
				return;
			}
			
			trace('TSprite '+fillWidth+' '+width+' '+fillHeight+' '+height+' '+fillAlpha+' '+fillAlpha);
			_fillColor = fillColor;
			_fillAlpha = fillAlpha;
			
			_fillBorder = fillBorder;
			_fillBorderColor = fillBorderColor;
			
			var g:Graphics = graphics;
			
			g.clear();
			
			if(_fillBorder > 0) {
				g.lineStyle(_fillBorder, _fillBorderColor);
			}
			
			g.beginFill(fillColor, fillAlpha);
			g.drawRect(0, 0, fillWidth - _fillBorder, fillHeight - _fillBorder);
			g.endFill();
		}
	}
}