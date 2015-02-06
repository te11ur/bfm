package te11ur.renderable.components.anchor
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.components.content.Content;
	import te11ur.renderable.components.overlay.Overlay;
	import te11ur.renderable.components.overlay.OverlayPosition;
	import te11ur.renderable.layout.BaseLayout;

	public class Anchor extends Content
	{
		public var position:String = OverlayPosition.BOTTOM;
		public var destroed:Boolean = false;
		
		public function Anchor(style:String = '')
		{
			super(style);
		}
		
		override public function set owner(value:IRenderable):void
		{
			if(value is IAnchorOwner) {
				super.owner = value;
			}
		}
		
		override public function destroy():void
		{
			destroed = true;
			super.destroy();
		}
		
		override public function render():void
		{	
			super.render();
						
			if(position == OverlayPosition.GLOBAL_CENTER) {
				var overlay:Overlay = Overlay.I();
				x = (overlay.explicitWidth - explicitWidth) / 2;
				y = (overlay.explicitHeight - explicitHeight) / 2;
			} else {
				var ownerDO:DisplayObject = _owner as DisplayObject;
				var point:Point = ownerDO.localToGlobal(new Point(0, 0));
				switch(position) {
					case OverlayPosition.OVER:
						x = point.x;
						y = point.y;
						break;
					case OverlayPosition.TOP:
						x = point.x;
						y = point.y - explicitHeight;
						break;
					case OverlayPosition.BOTTOM:
						x = point.x;
						y = ownerDO.height + point.y;
						break;
					case OverlayPosition.LEFT:
						x = point.x - explicitWidth;
						y = point.y;
						break;
					case OverlayPosition.RIGHT:
						x = ownerDO.width + point.x;
						y = point.y;
						break;
				}
			}
		}
		
		override protected function init():void
		{
			super.init();
			
			layout = new BaseLayout();
			
			visible = false;
		}
	}
}