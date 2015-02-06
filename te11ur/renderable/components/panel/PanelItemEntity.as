package te11ur.renderable.components.panel
{
	import te11ur.renderable.components.BaseRenderable;
	
	public class PanelItemEntity extends BaseRenderable implements IPanelEntity
	{
		private var _type:String = PanelItemPosition.NONE;
		private var _panelItem:IPanelItem;
		
		public function PanelItemEntity(panelItem:IPanelItem, style:String='')
		{
			_panelItem = panelItem;
			super(style);
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
			/*if(_type == PanelItemPosition.NONE) {
				explicitWidth = 0;
				explicitHeight = 0;
			}*/
			
			visible = !(_type == PanelItemPosition.NONE);
		}
		
		public function get resizeFlag():Boolean
		{
			return false;
		}
		
		public function get dragFlag():Boolean
		{
			return false;
		}
		
		public function set hidden(value:Boolean):void
		{
			disable = value;
		}
		
		public function get hidden():Boolean
		{
			return _disable;
		}
		
		override protected function init():void
		{
			//visible = false;
			super.init();
		}
		
		override protected function fillBg(place:String = 'bg'):void
		{
			if(place == 'bg') {
				if(!_disable) {
					_bgPlace.fill(explicitWidth, explicitHeight, _activeBgColor, _activeBgAlpha, _border, _activeBorderColor);
				}				
			}			
		}
	}
}