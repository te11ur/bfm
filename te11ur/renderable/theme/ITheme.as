package te11ur.renderable.theme
{
	import te11ur.core.IDestroyable;

	public interface ITheme extends IDestroyable
	{
		function get style():Object;
		function get asset():IAsset;
	}
}