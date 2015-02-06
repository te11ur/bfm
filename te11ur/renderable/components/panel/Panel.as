package te11ur.renderable.components.panel
{	
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.layout.panel.PanelLayout;
	
	public class Panel extends BaseRenderable implements IPanel
	{
		public var destroyOnClose:Boolean = true;
		
		private var _panels:Array = [];
		
		public function Panel(style:String="")
		{
			super(style);
		}
		
		public function get panels():Array
		{
			return _panels;
		}
		
		override public function childTrigger(child:IRenderable, type:String = '', ...args):void
		{
			if(type == 'hidden') {
				switch(args[0]) {
					case PanelItemPosition.TOP:
						(_layout as PanelLayout).topHidden = (args[1] as Boolean);
						break;
					case PanelItemPosition.RIGHT:
						(_layout as PanelLayout).rightHidden = (args[1] as Boolean);
						break;
					case PanelItemPosition.LEFT:
						(_layout as PanelLayout).leftHidden = (args[1] as Boolean);
						break;
					case PanelItemPosition.BOTTOM:
						(_layout as PanelLayout).bottomHidden = (args[1] as Boolean);
						break;
					default:
						break;
				}
				(_layout as PanelLayout).trice = args[2];
			} else if(type == 'close') {
				removeRenderable(child);
			}
			
		}
		
		override public function addRenderable(rendereble:IRenderable, force:Boolean = false, childOwner:IRenderable = null):IRenderable
		{
			if(rendereble is IPanelEntity) {
				_panels.push(rendereble);
			}
			
			return super.addRenderable(rendereble, force, childOwner);
		}
		
		override public function removeRenderable(rendereble:IRenderable):IRenderable
		{
			if(rendereble is IPanelEntity) {
				var ind:int = _panels.indexOf(rendereble);
				
				if(ind >= 0) {
					_panels.splice(ind, 1);
				
					if(destroyOnClose) {
						rendereble.destroy();
					}
				}
			}
			return super.removeRenderable(rendereble);
		}
		
		override public function removeAllRenderable(from:uint = 0):void
		{
			for(var i:int = from; i < numRenderable; i++) {
				var ind:int = _panels.indexOf(getRenderableByIndex(i));
				if(ind >= 0) {		
					_panels.splice(ind, 1);
				}
			}
			super.removeAllRenderable(from);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			_panels = null;
		}
		
		override protected function init():void
		{
			super.init();
			
			layout = new PanelLayout();
		}		
	}
}