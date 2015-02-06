package te11ur.renderable.components.scrollcontent
{	
	import flash.display.DisplayObject;
	
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.layout.BaseLayout;

	public class ScrollPlace extends BaseRenderable implements IInternalScrollComponent
	{
		public var position:Number = 0;
		
		public function ScrollPlace(style:String = '')
		{
			super(style);
		}
		
		override public function render():void
		{
			super.render();
			
			//_bgPlace.fill(explicitWidth, explicitHeight, _bgColor, _bgAlpha);
			
			//_itemPlace.fill(explicitWidth, _layout.rect.height, _bgColor, 0);
			
			
			if(_layout.rect.height > explicitHeight) {
				_itemPlace.y = - (_layout.rect.height - explicitHeight) * position / 100;
			} else {
				_itemPlace.y = 0;
			}
		}
		
		override public function layoutTrigger(item:IRenderable, index:uint):void
		{
			var pt:Number = _itemPlace.y + (item as DisplayObject).y;
			(item as BaseRenderable).renderChild = (pt >= 0 && pt <= explicitHeight);
		}
		
		override protected function init():void
		{
			super.init();
						
			if(_itemPlace && _bgPlace) {
				_itemPlace.mask = _bgPlace;
			}
			
			if(!layout) {
				layout = new BaseLayout();
			}
		}
		
		override protected function fillBg(place:String = 'bg'):void
		{
			if(place == 'bg') {
				_bgPlace.fill(explicitWidth, explicitHeight, _activeBgColor, _activeBgAlpha, _border, _activeBorderColor);
			}			
		}
	}
}