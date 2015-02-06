package te11ur.renderable.components.dropdown
{
	import te11ur.renderable.components.IRenderable;
	import te11ur.renderable.components.list.List;

	public class DropDown extends BaseDropDown
	{
		protected var _list:List;
		
		public function DropDown(style:String="")
		{
			super(style);
		}
		
		override public function set items(value:Array):void
		{
			if(_list) {
				_list.removeAllItems();
				_list.addAllItems(value);
			}			
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
				_list.selectionList = [];
				_list.reset();
			}
		}
		
		override protected function init():void
		{
			super.init();
			
			if(_anchor) {				
				if(!_list) {
					_list = _anchor.addRenderable(new List(_listStyle), true, this) as List;
					_list.multySelect = _multySelect;
				}
			}
			
		}
		
		override protected function selectionComplete(child:IRenderable):void
		{
			if(_list) {
				if(child == _list) {
					if(!_multySelect) {
						if(_owner) {
							_owner.childTrigger(this, 'selected', _list.selectionList);
						}						
						close();
					}
				} else {
					if(_multySelect) {
						if(_owner) {
							_owner.childTrigger(this, 'selected', _list.selectionList);
						}
					}					
				}
			}			
		}
	}
}