package te11ur.renderable.components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	import te11ur.display.TShape;
	import te11ur.display.TSprite;
	import te11ur.renderable.ThemeManager;
	import te11ur.renderable.layout.BaseLayout;
	import te11ur.renderable.theme.IStyle;
	import te11ur.renderable.theme.white.styles.BaseRenderableStyle;

	public class BaseRenderable extends Sprite implements IRenderable
	{
		public var renderChild:Boolean = true;
		public var index:uint = 0;
		public var explicitWidth:Number = 0;
		public var explicitHeight:Number = 0;
		
		protected var _owner:IRenderable;
		/*public var layoutData:Object = {};*/
		protected var _layout:BaseLayout = null;
		
		protected var _depthIndex:uint = 0;
		protected var _bgPlace:TShape;
		protected var _itemPlace:TSprite;
		
		private var _stack:Array = [];
		private var _themeIndecator:uint = 0;
		
		protected var _style:String = '';
		protected var _styleObj:IStyle;
		
		/**
		 * Styles
		 */
		protected var _defaultFontName:String;
		protected var _bgColor:uint;
		protected var _bgSelectedColor:uint;
		protected var _bgOverColor:uint;
		protected var _bgOverSelectedColor:uint;
		protected var _bgDisableColor:uint;
		
		protected var _bgAlpha:Number;
		protected var _bgSelectedAlpha:Number;
		protected var _bgOverAlpha:Number;
		protected var _bgOverSelectedAlpha:Number;
		protected var _bgDisableAlpha:Number;
		
		protected var _border:Number;
		
		protected var _borderLeft:Number;
		protected var _borderTop:Number;
		protected var _borderRight:Number;
		protected var _borderBottom:Number;
		
		protected var _borderSelectedLeft:Number;
		protected var _borderSelectedTop:Number;
		protected var _borderSelectedRight:Number;
		protected var _borderSelectedBottom:Number;
		
		protected var _borderOverLeft:Number;
		protected var _borderOverTop:Number;
		protected var _borderOverRight:Number;
		protected var _borderOverBottom:Number;
		
		protected var _borderOverSelectedLeft:Number;
		protected var _borderOverSelectedTop:Number;
		protected var _borderOverSelectedRight:Number;
		protected var _borderOverSelectedBottom:Number;
		
		protected var _borderDisableLeft:Number;
		protected var _borderDisableTop:Number;
		protected var _borderDisableRight:Number;
		protected var _borderDisableBottom:Number;
		
		protected var _borderColor:uint;
		
		protected var _borderSelectedColor:uint;
		protected var _borderOverColor:uint;
		protected var _borderOverSelectedColor:uint;
		protected var _borderDisableColor:uint;				
		
		protected var _textColor:uint;
		protected var _textSelectedColor:uint;
		protected var _textOverColor:uint;
		protected var _textOverSelectedColor:uint;
		protected var _textDisableColor:uint;
		
		protected var _activeTextColor:uint = 0;
		protected var _activeBgColor:uint = 0;
		protected var _activeBgAlpha:Number = 0;
		protected var _activeBorderColor:uint = 0;
		
		protected var _activeBorderLeft:Number;
		protected var _activeBorderTop:Number;
		protected var _activeBorderRight:Number;
		protected var _activeBorderBottom:Number;
		
		/**
		 * States
		 */
		protected var _selected:Boolean = false;
		protected var _over:Boolean = false;
		protected var _disable:Boolean = false;
		
		
		public function BaseRenderable(style:String = '')
		{
			_style = style;
			super();
			init();
		}
		
		public function set selected(value:Boolean):void
		{
			if(_disable) {
				return;
			}
			
			if(_selected != value) {
				_selected = value;
				determineColor();
			}			
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set over(value:Boolean):void
		{
			if(_disable) {
				return;
			}
			
			if(_over != value) {
				_over = value;
				determineColor();
			}
		}
		
		public function get over():Boolean
		{
			return _over;
		}
		
		public function set disable(value:Boolean):void
		{
			if(_disable != value) {
				_disable = value;
				
				if(_disable) {
					_selected = _over = false;
				}
				determineColor();
			}
		}
		
		public function get disable():Boolean
		{
			return _disable;
		}
		
		public function set layout(value:BaseLayout):void
		{
			if(value) {
				value.renderer = this;
			}
			
			_layout = value;
		}
		
		public function get layout():BaseLayout
		{
			return _layout;
		}
		
		public function set depthIndex(value:uint):void
		{
			_depthIndex = value;
			
			if(!_itemPlace) {
				return;
			}
			
			for(var i:int = 0; i < _itemPlace.numChildren; i++)
			{
				var rs:IRenderable = _itemPlace.getChildAt(i) as IRenderable;
				if(rs) {
					rs.depthIndex = _depthIndex + 1;
				}				
			}
		}
		
		public function get depthIndex():uint
		{
			return _depthIndex;
		}		
		
		public function set owner(value:IRenderable):void
		{
			_owner = value;
		}
		
		public function get owner():IRenderable
		{
			if(!_owner) {
				if(parent is Sprite) {
					if(parent.parent is IRenderable) {
						_owner = IRenderable(parent.parent);
					}
				}
			}
			
			if(!_owner) {
				return this;
			}
			
			return _owner;
		}
		
		public function get upper():IRenderable
		{
			return _owner ? _owner.owner : this;
		}
		
		public function isUpper():Boolean
		{
			return upper == this;
		}
		
		public function hasOwner():Boolean
		{
			return owner != this;
		}
		
		
		public function childTrigger(child:IRenderable, type:String = '', ...args):void
		{
			
		}
		
		public function layoutTrigger(item:IRenderable, index:uint):void
		{
			
		}
		
		public function addRenderable(rendereble:IRenderable, force:Boolean = false, childOwner:IRenderable = null):IRenderable
		{
			if(force) {
				rendereble.depthIndex = _depthIndex + 1;
				_itemPlace.addChild(rendereble as DisplayObject);
				(rendereble as BaseRenderable).index = _itemPlace.numChildren - 1;
			} else {
				_stack.push(rendereble);
			}
			
			rendereble.owner = childOwner ? childOwner : this;
			
			return rendereble;
		}
		
		public function removeRenderable(rendereble:IRenderable):IRenderable
		{
			return _itemPlace.removeChild(rendereble as DisplayObject) as IRenderable;
		}
		
		public function removeAllRenderable(from:uint = 0):void
		{
			_stack = [];
			
			for(var i:int = from; i < _itemPlace.numChildren; i++)
			{
				(_itemPlace.getChildAt(i) as IRenderable).destroy();
			}
			
			if(_itemPlace.numChildren > from) {
				_itemPlace.removeChildren(from, _itemPlace.numChildren - 1);
			}
		}
		
		public function desposeRenderable(rendereble:IRenderable):void
		{
			var ch:IRenderable = removeRenderable(rendereble);
			ch.destroy();
		}
		
		public function getRenderableByName(name:String):IRenderable
		{
			return _itemPlace.getChildByName(name) as IRenderable;
		}
		
		public function getRenderableByIndex(index:int):IRenderable
		{
			return _itemPlace.getChildAt(index) as IRenderable;
		}
		
		public function getRenderableIndex(rendereble:IRenderable):int
		{
			return _itemPlace.getChildIndex(rendereble as DisplayObject);
		}
		
		public function get numRenderable():int
		{
			return _itemPlace.numChildren;
		}
		
		public function swapRenderableToTop(rendereble:IRenderable):void
		{
			_itemPlace.swapChildrenAt(getRenderableIndex(rendereble), numRenderable - 1);
		}
		
		public function render():void
		{	
			if(ThemeManager.indecator > _themeIndecator) {
				invalidateTheme();
			}
			
			if(renderChild && _itemPlace) {
				for(var i:int = 0; i < _itemPlace.numChildren; i++)
				{
					var item:BaseRenderable = _itemPlace.getChildAt(i) as BaseRenderable;
					
					if(item) {
						if(layout) {
							layout.layouting(_itemPlace, item, i);
						}
						
						if(item.visible) {
							item.stack();
							item.render();
						}
					}
					
				}
			}
			
			fillBg();
		}
		
		public function stack():void
		{
			var i:uint = 100;
			
			while(_stack.length > 0 && i > 0) {
				var rendereble:IRenderable = _stack.shift() as IRenderable;
				rendereble.depthIndex = _depthIndex + 1;
				_itemPlace.addChild(rendereble as DisplayObject);
				i--;
			}
		}
		
		public function destroy():void
		{
			if(layout) {
				layout = null;
			}
			
			removeAllRenderable();
			
			if(_itemPlace) {
				removeChild(_itemPlace);
				_itemPlace = null;
			}
			
			if(_bgPlace) {
				removeChild(_bgPlace);
				_bgPlace = null;
			}
			
			_style = null;
			_owner = null;
		}
		
		public function clear():void
		{
			
		}
		
		protected function init():void
		{
			cacheAsBitmap = true;
			
			
			if(!_bgPlace) {
				_bgPlace = addChild(new TShape()) as TShape;
			}
			
			if(!_itemPlace) {
				_itemPlace = addChild(new TSprite()) as TSprite;
			}
			
			/*if(!layout) {
				layout = new BaseLayout();
			}*/
			
			invalidateTheme();
			determineColor();
		}
		
		protected function invalidateTheme():void
		{
			_themeIndecator = ThemeManager.indecator;
			
			if(!(_style in ThemeManager.theme.style)) {
				_style = getQualifiedClassName(this).split('::')[1]; 
			}
			
			if(!(_style in ThemeManager.theme.style)) {
				_style = getQualifiedSuperclassName(this).split('::')[1]; 
			}
			
			if(!(_style in ThemeManager.theme.style)) {
				_styleObj = new BaseRenderableStyle();
			} else {
				_styleObj = ThemeManager.theme.style[_style] as IStyle;
			}
			
			if(!_styleObj) {
				_styleObj = new BaseRenderableStyle();
			}
			_defaultFontName = _styleObj.fontName;
			
			_bgColor = _styleObj.getColor('default');
			_bgSelectedColor = _styleObj.getColor('selected');
			_bgOverColor = _styleObj.getColor('over');
			_bgOverSelectedColor = _styleObj.getColor('overSelected');
			_bgDisableColor = _styleObj.getColor('disable');
			
			_bgAlpha = _styleObj.getAlpha('default');
			_bgSelectedAlpha = _styleObj.getAlpha('selected');
			_bgOverAlpha = _styleObj.getAlpha('over');
			_bgOverSelectedAlpha = _styleObj.getAlpha('overSelected');
			_bgDisableAlpha = _styleObj.getAlpha('disable');
			
			_borderColor = _styleObj.getColor('default', 'border');
			_borderSelectedColor = _styleObj.getColor('selected', 'border');
			_borderOverColor = _styleObj.getColor('over', 'border');
			_borderOverSelectedColor = _styleObj.getColor('overSelected', 'border');
			_borderDisableColor = _styleObj.getColor('disable', 'border');
			
			_textColor = _styleObj.getColor('default', 'text');
			_textSelectedColor = _styleObj.getColor('selected', 'text');
			_textOverColor = _styleObj.getColor('over', 'text');
			_textOverSelectedColor = _styleObj.getColor('overSelected', 'text');
			_textDisableColor = _styleObj.getColor('disable', 'text');
			
			_border = _styleObj.getBorder('default');
			
			_borderLeft = _styleObj.getBorder('default', 'left');
			_borderTop = _styleObj.getBorder('default', 'top');
			_borderRight = _styleObj.getBorder('default', 'right');
			_borderBottom = _styleObj.getBorder('default', 'bottom');
			
			_borderSelectedLeft = _styleObj.getBorder('selected', 'left');
			_borderSelectedTop = _styleObj.getBorder('selected', 'top');
			_borderSelectedRight = _styleObj.getBorder('selected', 'right');
			_borderSelectedBottom = _styleObj.getBorder('selected', 'bottom');
			
			_borderOverLeft = _styleObj.getBorder('over', 'left');
			_borderOverTop = _styleObj.getBorder('over', 'top');
			_borderOverRight = _styleObj.getBorder('over', 'right');
			_borderOverBottom = _styleObj.getBorder('over', 'bottom');
			
			_borderOverSelectedLeft = _styleObj.getBorder('overSelected', 'left');
			_borderOverSelectedTop = _styleObj.getBorder('overSelected', 'top');
			_borderOverSelectedRight = _styleObj.getBorder('overSelected', 'right');
			_borderOverSelectedBottom = _styleObj.getBorder('overSelected', 'bottom');
			
			_borderDisableLeft = _styleObj.getBorder('disable', 'left');
			_borderDisableTop = _styleObj.getBorder('disable', 'top');
			_borderDisableRight = _styleObj.getBorder('disable', 'right');
			_borderDisableBottom = _styleObj.getBorder('disable', 'bottom');
			
		}
		
		protected function determineColor():void
		{			
			if(_disable) {
				_activeTextColor = _textDisableColor;
				_activeBgColor = _bgDisableColor;
				_activeBgAlpha = _bgDisableAlpha;
				_activeBorderColor = _borderDisableColor;
				
				_activeBorderLeft = _borderDisableLeft;
				_activeBorderTop = _borderDisableTop;
				_activeBorderRight = _borderDisableRight;
				_activeBorderBottom = _borderDisableBottom;
			}
			
			if(_selected || _over) {
				if(_selected && _over) {
					_activeTextColor = _textOverSelectedColor;
					_activeBgColor = _bgOverSelectedColor;
					_activeBgAlpha = _bgOverSelectedAlpha;
					_activeBorderColor = _borderOverSelectedColor;
					
					_activeBorderLeft = _borderOverSelectedLeft;
					_activeBorderTop = _borderOverSelectedTop;
					_activeBorderRight = _borderOverSelectedRight;
					_activeBorderBottom = _borderOverSelectedBottom;
				} else if(_over) {
					_activeTextColor = _textOverColor;
					_activeBgColor = _bgOverColor;
					_activeBgAlpha = _bgOverAlpha;
					_activeBorderColor = _borderOverColor;
					
					_activeBorderLeft = _borderOverLeft;
					_activeBorderTop = _borderOverTop;
					_activeBorderRight = _borderOverRight;
					_activeBorderBottom = _borderOverBottom;
				} else if(_selected) {
					_activeTextColor = _textSelectedColor;
					_activeBgColor = _bgSelectedColor;
					_activeBgAlpha = _bgSelectedAlpha;
					_activeBorderColor = _borderSelectedColor;
					
					_activeBorderLeft = _borderSelectedLeft;
					_activeBorderTop = _borderSelectedTop;
					_activeBorderRight = _borderSelectedRight;
					_activeBorderBottom = _borderSelectedBottom;
				}
			}
			
			if(!_disable && !_selected && !_over) {
				_activeTextColor = _textColor;
				_activeBgColor = _bgColor;
				_activeBgAlpha = _bgAlpha;
				_activeBorderColor = _borderColor;
				
				_activeBorderLeft = _borderLeft;
				_activeBorderTop = _borderTop;
				_activeBorderRight = _borderRight;
				_activeBorderBottom = _borderBottom;
			}
		}
		
		protected function fillBg(place:String = 'bg'):void
		{
			
		}
	}
}