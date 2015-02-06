package te11ur.renderable.components.dropdown
{
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.components.list.ScrollList;

	public class ScrollDropDown extends BaseDropDown
	{
		public var visibleItems:uint = 5;
		
		protected var _list:ScrollList;
		
		public function ScrollDropDown(style:String='')
		{
			super(style);
		}
		
		override public function set items(value:Array):void
		{
			if(_list) {
				_list.selectionList.splice(0, _list.selectionList.length);
				_list.removeAllItems();
				_list.addAllItems(value);
			}			
		}
		
		override public function get selectionList():Array
		{
			return /*_list ? */_list.selectionList/* : _selectionList*/;
		}
		
		override public function set multySelect(value:Boolean):void
		{
			super.multySelect = value;
			
			if(_list) {
				_list.multySelect = _multySelect;
			}
		}
		
		override public function get count():int
		{
			return _list.numRenderable;
		}
		
		override public function reset():void
		{
			super.reset();
			
			if(_list) {
				_list.reset();
			}
		}
		
		override public function render():void
		{
			if(_list) {
				var listHeight:Number = (_list.numRenderable > visibleItems ? visibleItems : _list.numRenderable) * _list.itemHeight;
				
				_list.explicitHeight = listHeight;
				_list.explicitWidth = explicitWidth;
			
				if(_anchor) {
					_anchor.explicitHeight = listHeight;
					_anchor.explicitWidth = explicitWidth;
				}
			}
			
			super.render();			
		}
		
		override protected function init():void
		{
			super.init();
						
			if(_anchor && !_list) {
				_list = _anchor.addRenderable(new ScrollList(_listStyle), true, this) as ScrollList;
				_list.multySelect = _multySelect;
			}			
		}
		
		override protected function selectionComplete(child:IRenderable):void
		{
			if(_list) {
				if(child == _list) {
					
					if(_owner) {
						_owner.childTrigger(this, 'selected', _list.selectionList);
					}
					if(!_multySelect) {						
						close();
					}
				}/* else {
					if(_multySelect) {
						if(_owner) {
							_owner.childTrigger(this, 'selected', _list.selectionList);
						}
					}					
				}*/
			}			
		}
	}
}