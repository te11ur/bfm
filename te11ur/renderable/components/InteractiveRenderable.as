package te11ur.renderable.components
{
	import flash.events.MouseEvent;

	public class InteractiveRenderable extends BaseRenderable
	{	
		private var _interactive:Boolean = false;
		
		public function InteractiveRenderable(style:String = '')
		{
			super(style);
		}
		
		public function set interactive(value:Boolean):void
		{
			if(_interactive != value) {
				_interactive = value;
				
				if(_interactive) {
					addEventListener(MouseEvent.ROLL_OUT, mouseRollOutListener, false, 0, true);
					addEventListener(MouseEvent.ROLL_OVER, mouseRollOverListener, false, 0, true);
					addEventListener(MouseEvent.CLICK, mouseClickListener, false, 0, true);
				} else {
					removeEventListener(MouseEvent.ROLL_OUT, mouseRollOutListener);
					removeEventListener(MouseEvent.ROLL_OVER, mouseRollOverListener);
					removeEventListener(MouseEvent.CLICK, mouseClickListener);
				}
			}			
		}
		
		public function get interactive():Boolean
		{
			return _interactive;
		}
		
		override public function destroy():void
		{			
			interactive = false;
			super.destroy();
		}
		
		protected function mouseRollOutListener(event:MouseEvent):void
		{
			over = false;
			event.preventDefault();
		}
		
		protected function mouseRollOverListener(event:MouseEvent):void
		{
			over = true;
			event.preventDefault();
		}
		
		protected function mouseClickListener(event:MouseEvent):void
		{
			selected = !_selected;
			event.preventDefault();
		}
		
		override protected function init():void
		{
			super.init();
			
			interactive = true;			
		}
		
		override protected function fillBg(place:String = 'bg'):void
		{
			if(place == 'bg') {
				_bgPlace.fill(explicitWidth, explicitHeight, _activeBgColor, _activeBgAlpha, _border, _activeBorderColor);
			}			
		}
	}
}