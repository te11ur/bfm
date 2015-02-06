package  te11ur.renderable.layout
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	import te11ur.renderable.components.BaseRenderable;
		
	public class BaseLayout
	{
		public var rect:Rectangle;
		public var ignoreInvisible:Boolean = true;
		public var dynamicSize:Boolean = false;
		public var justify:Boolean = false;
		public var trigger:Boolean = false;
		
		public var paddingTop:Number = 0;
		public var paddingBottom:Number = 0;
		public var paddingLeft:Number = 0;
		public var paddingRight:Number = 0;
		
		protected var _itemWidth:Number = 0;
		protected var _itemWidthFlag:Boolean = false;
		protected var _itemHeight:Number = 0;
		protected var _itemHeightFlag:Boolean = false;
		
		protected var _invisibleCount:uint = 0;
		protected var _renderer:BaseRenderable;
		protected var _container:DisplayObjectContainer;
		
		public var cycle:Boolean = true;
		
		
		public function BaseLayout()
		{
			rect = new Rectangle();
		}
		
		public function set itemWidth(value:Number):void
		{
			_itemWidth = value;
			_itemWidthFlag = true;
		}
		
		public function set itemHeight(value:Number):void
		{
			_itemHeight = value;
			_itemHeightFlag = true;
		}
		
		public function set renderer(value:BaseRenderable):void
		{
			_renderer = value;
		}
		
		public function get scrollHDeff():Number
		{
			return rect.height > 0 ? (_itemHeight + paddingTop) / rect.height : 1;
		}
		
		public function get scrollWDeff():Number
		{
			return rect.width > 0 ? (_itemWidth + paddingLeft) / rect.width : 1;
		}
		
		public function getRect():Rectangle
		{
			var rc:Rectangle = new Rectangle();
			if(_container.numChildren > 0) {
				var k:int = _container.numChildren - 1;
				do {
					var ds:BaseRenderable = _container.getChildAt(k) as BaseRenderable;
					if((ignoreInvisible && ds.visible) || !ignoreInvisible) {
						rc.x = ds.x < rc.x ? ds.x : rc.x;
						rc.y = ds.y < rc.y ? ds.y : rc.y;
						rc.width = (ds.explicitWidth) > rc.width ? (ds.explicitWidth) : rc.width;
						rc.height = (ds.explicitHeight) > rc.height ? (ds.explicitHeight) : rc.height;
					}
					k--;
				} while(k >= 0);
			}
			return rc;
		}
		
		final public function layouting(container:DisplayObjectContainer, item:BaseRenderable, index:uint):void
		{
			_container = container;
			preRender(item, index);
			
			if(item.visible || (!ignoreInvisible && !item.visible)) {
				postRender(item, index);
				calculate(item, index);
			}
			
			if(trigger && _renderer) {
				_renderer.layoutTrigger(item, index);
			}
		}
		
		protected function preRender(item:BaseRenderable, index:uint):void
		{
			item.index = index;
			
			if(index < 1) {
				_invisibleCount = 0;
			}
			
			if(!item.visible) {
				_invisibleCount++;
			}
			
			if(index < 1) {
				cycle = !cycle;
			}
		}
		
		protected function postRender(item:BaseRenderable, index:uint):void
		{
			
		}
		
		protected function calculate(item:BaseRenderable, index:uint):void
		{
			if(cycle) {
				var vsIndex:int = index - _invisibleCount;
				rect.x = item.x < rect.x || vsIndex < 1 ? item.x : rect.x;
				rect.y = item.y < rect.y || vsIndex < 1 ? item.y : rect.y;
				rect.width = (item.x + item.width) > rect.width || vsIndex < 1 ? (item.x + item.width) : rect.width;
				rect.height = (item.y + item.height) > rect.height || vsIndex < 1 ? (item.y + item.height) : rect.height;
				//trace(item.explicitHeight);
			} else {
				/*rect.x = 0;
				rect.y = 0;
				rect.width = 0;
				rect.height = 0;*/
			}
		}
		
		protected function getPreviousItem(index:uint):BaseRenderable
		{
			if(index > 0) {
				var k:int = index - 1;
				while(k >= 0){
					var r:BaseRenderable = _container.getChildAt(k) as BaseRenderable;
					if(r) {
						if(ignoreInvisible) {
							if(r.visible) {
								return r;
							}
						} else {
							return r;
						}
					}
					k--;
				}
			}
			return null;
		}
	}
}