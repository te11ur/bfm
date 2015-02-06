package te11ur.renderable.layout.stack
{

	public class StackLayoutHistory
	{
		private var _renderer:IStackLayoutRenderer;
		private var _history:Array = [];
		private var _pointer:int = -1;
		
		public function StackLayoutHistory(renderer:IStackLayoutRenderer)
		{
			_renderer = renderer;
		}
		
		public function up(index:uint):int
		{
			_pointer++;
			return step(index);
		}
		
		public function down():int
		{
			_pointer--;
			if(_pointer >= 0 && _pointer < _history.length - 1) {
				return step(_history[_pointer]);
			}
			return 0;
		}
		
		public function reset():void
		{
			_history = [];
			_pointer = -1;
		}
		
		private function step(index:uint):int
		{
			if(_pointer < _history.length - 1) {
				_history.splice(_pointer, 2, index);
			} else {
				_history.push(index);
			}
			
			_renderer.active = index;
			return index;
		}
	}
}