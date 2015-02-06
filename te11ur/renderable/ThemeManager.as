package te11ur.renderable
{
	import te11ur.renderable.theme.ITheme;
	import te11ur.renderable.theme.white.WhiteTheme;

	public class ThemeManager
	{
		private static var _indecator:uint = 0;
		private static var _theme:ITheme;
		
		public static function get indecator():uint
		{
			return _indecator;
		}
		
		public static function get theme():ITheme
		{
			if(!_theme) {
				_theme = new WhiteTheme();
			}
			
			return _theme;
		}
		
		public static function set theme(value:ITheme):void
		{
			if(value) {
				_indecator++;
				_theme = value;
			}
		}
	}
}