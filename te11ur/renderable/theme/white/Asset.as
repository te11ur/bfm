package te11ur.renderable.theme.white
{
	import te11ur.renderable.theme.IAsset;
	
	public class Asset implements IAsset
	{
		[Embed(source="../../../../../assets/icons/16x16/17.png")]
		public var _closeIcon16x16:Class;
		
		[Embed(source="../../../../../assets/icons/16x16/17.png")]
		public var _closeIcon32x32:Class;
		
		[Embed(source="../../../../../assets/icons/16x16/17.png")]
		public var _closeIcon64x64:Class;
		
		public function Asset()
		{
			_closeIcon16x16;
			_closeIcon32x32;
			_closeIcon64x64;
		}
		
		public function getAssetIcon(name:String, size:String='16x16'):Class
		{
			if("_"+name+"Icon"+size in this) {
				return this["_"+name+"Icon"+size];
			}
			
			return null;
		}
		
		public function getAssetImage(name:String):Class
		{
			return null;
		}
		
		public function destroy():void
		{
			for each(var k:String in this) {
				if(this[k] is Class) {
					this[k] = null;
				}
			}
		}
		
		public function clear():void
		{
		}
	}
}