package te11ur.renderable.theme.black
{
	import te11ur.renderable.theme.IAsset;
	import te11ur.renderable.theme.ITheme;
	import te11ur.renderable.theme.black.styles.BaseRenderableStyle;
	import te11ur.renderable.theme.black.styles.InteractiveRenderableStyle;
	import te11ur.renderable.theme.black.styles.anchor.AnchorStyle;
	import te11ur.renderable.theme.black.styles.content.ContentStyle;
	import te11ur.renderable.theme.black.styles.list.ListItemStyle;
	import te11ur.renderable.theme.black.styles.list.ListStyle;
	import te11ur.renderable.theme.black.styles.overlay.OverlayStyle;
	import te11ur.renderable.theme.black.styles.scrollcontent.ScrollContentStyle;
	import te11ur.renderable.theme.black.styles.scrollcontent.ScrollPlaceStyle;
	import te11ur.renderable.theme.black.styles.scrollcontent.ScrollPointerStyle;
	import te11ur.renderable.theme.black.styles.scrollcontent.ScrollTrackStyle;
	import te11ur.renderable.theme.black.styles.window.WindowContentStyle;
	import te11ur.renderable.theme.black.styles.window.WindowStyle;
	import te11ur.renderable.theme.black.styles.window.WindowTitleStyle;
	
	public class BlackTheme implements ITheme
	{
		protected var _style:Object;
		protected var _asset:IAsset;
		
		public function BlackTheme()
		{
			_style = {
				'BaseRenderable': new BaseRenderableStyle,
				'InteractiveRenderable': new InteractiveRenderableStyle,
				'Content': new ContentStyle,
				'Anchor': new AnchorStyle,
				'List': new ListStyle,
				'ListItem': new ListItemStyle, 
				'Overlay': new OverlayStyle,
				'ScrollContent': new ScrollContentStyle,
				'ScrollPlace': new ScrollPlaceStyle,
				'ScrollPointer': new ScrollPointerStyle,
				'ScrollTrack': new ScrollTrackStyle,
				'Window': new WindowStyle,
				'WindowTitle': new WindowTitleStyle,
				'WindowContentStyle': new WindowContentStyle
			};
			
			_asset = new Asset();
		}
		
		public function get style():Object
		{
			return _style;
		}
		
		public function get asset():IAsset
		{
			return _asset;
		}
		
		public function destroy():void
		{
			if(_asset) {
				_asset.destroy();
			}
			
			_asset = null;
			_style = null;
		}
		
		public function clear():void
		{
		}
	}
}