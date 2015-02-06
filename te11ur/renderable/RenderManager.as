package te11ur.renderable
{
	import flash.utils.Timer;

	public class RenderManager
	{
		private static var _instance:RenderManager;
		
		public var timer:Timer;
		
		public function RenderManager(lock:*)
		{
			if(lock != RenderManagerLock) {
				throw new Error('Singletone');
			}
		}
		
		public static function I():RenderManager
		{
			if(!_instance) {
				_instance = new RenderManager(RenderManagerLock);
			}
			
			return _instance;
		}
		
		public function init(ms:uint = 100):void
		{
			reset(ms);
		}
				
		public function reset(ms:uint = 100):void
		{
			if(timer) {
				timer.stop();
				timer.delay = ms;
			} else {
				timer = new Timer(ms);
			}
			timer.start();
		}
	}
}

class RenderManagerLock{}