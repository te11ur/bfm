package te11ur.renderable.theme
{
	public interface IStyle
	{
		function get fontName():String;
		function getColor(state:String, subject:String = 'bg'):uint;
		function getAlpha(state:String, subject:String = 'bg'):Number;
		function getBorder(state:String, positon:String = 'top'):uint;
	}
}