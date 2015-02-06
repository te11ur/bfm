package te11ur.renderable.components
{
	import te11ur.core.IDestroyable;
	import te11ur.renderable.layout.BaseLayout;

	public interface IRenderable extends IDestroyable
	{
		function set layout(value:BaseLayout):void;
		function get layout():BaseLayout;
		function set depthIndex(value:uint):void;
		function get depthIndex():uint;
		function get numRenderable():int;
		function set owner(value:IRenderable):void;
		function get owner():IRenderable;
		function get upper():IRenderable;		
		function set selected(value:Boolean):void;
		function get selected():Boolean;
		function set over(value:Boolean):void;
		function get over():Boolean;
		function set disable(value:Boolean):void;
		function get disable():Boolean;
		function isUpper():Boolean;
		function hasOwner():Boolean;
		function childTrigger(child:IRenderable, type:String = '', ...args):void;
		function layoutTrigger(item:IRenderable, index:uint):void;
		function getRenderableByIndex(index:int):IRenderable;
		function getRenderableIndex(rendereble:IRenderable):int;		
		function addRenderable(rendereble:IRenderable, force:Boolean = false, childOwner:IRenderable = null):IRenderable;
		function removeRenderable(rendereble:IRenderable):IRenderable;
		function desposeRenderable(rendereble:IRenderable):void
		function removeAllRenderable(from:uint = 0):void;
		function getRenderableByName(name:String):IRenderable;
		function swapRenderableToTop(rendereble:IRenderable):void;
		function render():void;
		function stack():void;
	}
}