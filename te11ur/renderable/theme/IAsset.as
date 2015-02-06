package te11ur.renderable.theme
{
	import te11ur.core.IDestroyable;

	public interface IAsset extends IDestroyable
	{
		function getAssetIcon(name:String, size:String = '16x16'):Class;
		function getAssetImage(name:String):Class;
	}
}