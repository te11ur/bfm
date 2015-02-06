package te11ur.renderable.components.menu
{
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.components.IRenderable;
	
	public class Manu extends BaseRenderable implements IMenu
	{
		public function Manu(style:String='')
		{
			super(style);
		}		
		
		override public function childTrigger(child:IRenderable, type:String = '', ...args):void
		{
			
		}
		
		public function addAllItems(items:Array):void
		{
			for each(var item:Object in items) {
				addItem(item);
			}
		}
		
		public function addItem(item:Object):void
		{
			addRenderable(new MenuItem(item));
		}
		
		public function removeAllItems():void
		{
			removeAllRenderable();
		}
		
		public function removeItem(item:Object):void
		{
			for(var i:int = 0; i < numRenderable; i++) {
				var li:IMenuItem = getRenderableByIndex(i) as IMenuItem;
				if(li) {
					if(li.item == item) {
						removeRenderable(li);
						li.destroy();
						break;
					}
				}
			}
		}
	}
}