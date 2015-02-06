package te11ur.renderable.theme.white
{	
	import te11ur.renderable.theme.IAsset;
	import te11ur.renderable.theme.ITheme;
	import te11ur.renderable.theme.white.styles.BaseRenderableStyle;
	import te11ur.renderable.theme.white.styles.anchor.AnchorStyle;
	import te11ur.renderable.theme.white.styles.button.ButtonStyle;
	import te11ur.renderable.theme.white.styles.content.ContentStyle;
	import te11ur.renderable.theme.white.styles.list.ListItemStyle;
	import te11ur.renderable.theme.white.styles.list.ListStyle;
	import te11ur.renderable.theme.white.styles.list.ScrollListStyle;
	import te11ur.renderable.theme.white.styles.overlay.OverlayStyle;
	import te11ur.renderable.theme.white.styles.panel.PanelItemEntityStyle;
	import te11ur.renderable.theme.white.styles.panel.PanelItemStyle;
	import te11ur.renderable.theme.white.styles.panel.PanelStyle;
	import te11ur.renderable.theme.white.styles.scrollcontent.ScrollContentStyle;
	import te11ur.renderable.theme.white.styles.scrollcontent.ScrollPlaceStyle;
	import te11ur.renderable.theme.white.styles.scrollcontent.ScrollPointerStyle;
	import te11ur.renderable.theme.white.styles.scrollcontent.ScrollTrackStyle;
	import te11ur.renderable.theme.white.styles.tabcontent.TabContentStyle;
	import te11ur.renderable.theme.white.styles.tabcontent.TabItemStyle;
	import te11ur.renderable.theme.white.styles.tabcontent.TabScrollContentStyle;
	import te11ur.renderable.theme.white.styles.window.WindowContentStyle;
	import te11ur.renderable.theme.white.styles.window.WindowStyle;
	import te11ur.renderable.theme.white.styles.window.WindowTitleStyle;
	
	public class WhiteTheme implements ITheme
	{		
		[Embed(source="../../../../../assets/fonts/Verdana.TTF", embedAsCFF="true", fontName="Verdana", mimeType="application/x-font")]
		public var verdana_font:Class;
		
		protected var _style:Object;
		protected var _asset:IAsset;
		
		public function WhiteTheme()
		{			
			_style = {
				'BaseRenderable': new BaseRenderableStyle,
				/*'InteractiveRenderable': new InteractiveRenderableStyle,*/
				'Content': new ContentStyle,
				'Anchor': new AnchorStyle,
				'List': new ListStyle,
				'ScrollList': new ScrollListStyle,
				'ListItem': new ListItemStyle, 
				'Overlay': new OverlayStyle,
				'ScrollContent': new ScrollContentStyle,
				'ScrollPlace': new ScrollPlaceStyle,
				'ScrollPointer': new ScrollPointerStyle,
				'ScrollTrack': new ScrollTrackStyle,
				'Window': new WindowStyle,
				'WindowTitle': new WindowTitleStyle,
				'WindowContent': new WindowContentStyle,
				'TabItem': new TabItemStyle,
				'TabContent': new TabContentStyle,
				'TabScrollContent': new TabScrollContentStyle,
				'PanelItem': new PanelItemStyle,
				'Panel': new PanelStyle,
				'PanelItemEntity': new PanelItemEntityStyle,
				'Button': new ButtonStyle
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