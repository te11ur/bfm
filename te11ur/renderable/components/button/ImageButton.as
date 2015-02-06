package te11ur.renderable.components.button
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import te11ur.renderable.components.InteractiveRenderable;
	
	public class ImageButton extends InteractiveRenderable
	{
		public var toggle:Boolean = false;
		
		protected var _textMargin:Number;
		
		private var _bitmap:Bitmap;		
		private var _imageData:*;
		
		public function ImageButton(style:String='')
		{
			super(style);
		}
		
		public function set image(value:*):void
		{
			_imageData = value;
			applyData();
		}
		
		public function get image():*
		{
			return _imageData;
		}
		
		override public function render():void
		{				
			if(_bitmap) {
				_bitmap.x = (explicitWidth - _bitmap.width) / 2;
				_bitmap.y = (explicitHeight - _bitmap.height) / 2;
			}
			
			/*explicitWidth = (_bitmap.width > 70 ? _bitmap.width : 70) + 2 * _textMargin;
			explicitHeight = (_bitmap.height > 20 ? _bitmap.height : 20) + 2 * _textMargin;*/
			
			super.render();
		}
		
		override public function destroy():void
		{
			if(_bitmap) {
				removeChild(_bitmap);
			}
			
			_imageData = null;
			_bitmap = null;
			super.destroy();
		}
		
		override protected function mouseClickListener(event:MouseEvent):void
		{
			if(toggle) {
				super.mouseClickListener(event);
			}
			
			_owner.childTrigger(this, 'click');
		}
		
		override protected function init():void
		{
			super.init();
			
			if(!_bitmap) {
				_bitmap = addChild(new Bitmap()) as Bitmap;
				_bitmap.cacheAsBitmap = true;
				applyData();
			}
		}
		
		override protected function invalidateTheme():void
		{
			super.invalidateTheme();
			
			_textMargin = "textMargin" in _styleObj ? _styleObj['textMargin'] : 5;
			
		}
		
		private function applyData():void
		{
			if(_bitmap && _imageData) {
				if(_imageData is BitmapData) {
					_bitmap.bitmapData = _imageData as BitmapData;
				} else if(_imageData is Object) {
					_bitmap.bitmapData =(new _imageData() as Bitmap).bitmapData;
				}
			}
		}
	}
}