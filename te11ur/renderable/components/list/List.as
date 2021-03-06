package te11ur.renderable.components.list
{
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.components.content.Content;
	import te11ur.renderable.layout.VListLayout;
	
	public class List extends Content implements IList
	{
		protected var _itemHeight:Number;
		private var _itemGap:Number;
		private var _multySelect:Boolean = false;
		private var _paddingRight:Number;
		private var _selectionList:Array = [];
		
		public function List(style:String = '')
		{
			super(style);
		}
		
		public function get multySelect():Boolean
		{
			return _multySelect;
		}
		
		public function set multySelect(value:Boolean):void
		{
			_multySelect = value;
		}
		
		public function get selectionList():Array
		{
			return _selectionList;
		}
		
		override public function childTrigger(child:IRenderable, type:String = '', ...args):void
		{
			if(_owner && type == 'click') {
				
				var selected:Boolean = args[0];
				var value:Object = args[1];
				var ind:int = selectionList.indexOf(value);
				
				if(selected) {
					if(ind < 0) {
						if(_multySelect) {
							selectionList.push(value);
						} else {
							_selectionList = [value];
						}
					}
				} else {
					if(ind >= 0) {
						selectionList.splice(ind, 1);
					}
				}
				
				reset();
				
				_owner.childTrigger(this, 'selected');
			}			
		}
		
		public function addAllItems(items:Array):void
		{
			for each(var item:Object in items) {
				addItem(item);
			}
		}
		
		public function addItem(item:Object):void
		{
			addRenderable(new ListItem(item), true);
		}
		
		public function removeAllItems():void
		{
			removeAllRenderable();
		}
		
		public function removeItem(item:Object):void
		{
			for(var i:int = 0; i < numRenderable; i++) {
				var li:IListItem = getRenderableByIndex(i) as IListItem;
				if(li) {
					if(li.item == item) {
						removeRenderable(li);
						li.destroy();
						break;
					}
				}
			}
		}
		
		public function reset():void
		{
			for(var i:int = 0; i < numRenderable; i++) {
				var lt:IListItem = (getRenderableByIndex(i) as IListItem);
				if(lt) {
					lt.selected = selectionList.indexOf(lt.value) >= 0;
				}
			}
		}
		
		override protected function init():void
		{
			super.init();
			
			var nl:VListLayout = new VListLayout();
			nl.itemHeight = _itemHeight;
			nl.paddingTop = _itemGap;
			nl.paddingRight = _paddingRight;
			nl.justify = true;
			layout = nl;
		}
		
		override protected function invalidateTheme():void
		{
			super.invalidateTheme();
			
			_itemHeight = "itemHeight" in _styleObj ? _styleObj['itemHeight'] : 20;
			_itemGap = "itemGap" in _styleObj ? _styleObj['itemGap'] : 0;
			_paddingRight = "paddingRight" in _styleObj ? _styleObj['paddingRight'] : 10;
		}
	}
}