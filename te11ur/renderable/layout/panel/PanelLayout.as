package te11ur.renderable.layout.panel
{	
	import te11ur.renderable.components.BaseRenderable;
	import te11ur.renderable.components.panel.IPanel;
	import te11ur.renderable.components.panel.IPanelEntity;
	import te11ur.renderable.components.panel.IPanelItem;
	import te11ur.renderable.components.panel.PanelItemPosition;
	import te11ur.renderable.layout.BaseLayout;
	
	public class PanelLayout extends BaseLayout
	{
		public var leftHidden:Boolean = false;
		public var rightHidden:Boolean = false;
		public var topHidden:Boolean = false;
		public var bottomHidden:Boolean = false;

		public var trice:Number = 0;
		
		private var _relations:Object;
		
		public function PanelLayout()
		{
			super();
		}
		
		override protected function preRender(item:BaseRenderable, index:uint):void
		{
			super.preRender(item, index);
			
			if(index < 1) {
				if(_renderer is IPanel) {
					
					var panels:Array = IPanel(_renderer).panels;
					_relations = {left: [], right: [], top: [], bottom: [], none: [], leftWidth:0, rightWidth: 0, topHeight: 0, bottomHeight:0};
					
					for each(var p:IPanelEntity in panels) {
						var pr:BaseRenderable = BaseRenderable(p);
						if(p.type == PanelItemPosition.NONE) {
							(_relations['none'] as Array).push(p);
						} else if(p.type == PanelItemPosition.LEFT) {
							if(pr.explicitWidth > _relations['leftWidth']) {
								_relations['leftWidth'] = pr.explicitWidth;
							}
							(_relations['left'] as Array).push(p);
						} else if(p.type == PanelItemPosition.RIGHT) {
							if(pr.explicitWidth > _relations['rightWidth']) {
								_relations['rightWidth'] = pr.explicitWidth;
							}
							(_relations['right'] as Array).push(p);
						} else if(p.type == PanelItemPosition.TOP) {
							if(pr.explicitHeight > _relations['topHeight']) {
								_relations['topHeight'] = pr.explicitHeight;
							}
							(_relations['top'] as Array).push(p);
						} else if(p.type == PanelItemPosition.BOTTOM) {
							if(pr.explicitHeight > _relations['bottomHeight']) {
								_relations['bottomHeight'] = pr.explicitHeight;
							}
							(_relations['bottom'] as Array).push(p);
						}
					}
				}
			}
		}
		
		override protected function postRender(item:BaseRenderable, index:uint):void
		{
			if(_renderer is IPanel && item is IPanelEntity) {
				var sp:IPanelEntity = IPanelEntity(item);
				var typeIndex:int = 0;
				var count:int = 0;
				var relationSize:Number = 0;
				
				if(sp.type == PanelItemPosition.NONE || sp.dragFlag) {
					
					sp.hidden = false;
					
					if(item is IPanelItem) {
						item.explicitHeight = IPanelItem(item).noneExplicitHeight;
						item.explicitWidth = IPanelItem(item).noneExplicitWidth;
					}
					
				} else if(sp.type == PanelItemPosition.LEFT) {
					
					typeIndex = (_relations['left'] as Array).indexOf(sp);
					sp.hidden = leftHidden;
					count = (_relations['left'] as Array).length;
					relationSize = _renderer.explicitHeight;
					
					item.explicitHeight = count > 1 ? Math.floor(relationSize / count) : relationSize;
					
					if(!sp.resizeFlag || !leftHidden) {
						item.explicitWidth = _relations['leftWidth'];
					}
					
					if(!sp.dragFlag) {
						item.x = (!leftHidden ? 0 : - item.explicitWidth + trice);
						item.y = typeIndex * Math.floor(relationSize / count);
					}
					
				} else if(sp.type == PanelItemPosition.RIGHT) {
					
					typeIndex = (_relations['right'] as Array).indexOf(sp);					
					sp.hidden = rightHidden;
					count = (_relations['right'] as Array).length;
					relationSize = _renderer.explicitHeight;
					
					item.explicitHeight = count > 1 ? Math.floor(relationSize / count) : relationSize;
					
					if(!sp.resizeFlag || !rightHidden) {
						item.explicitWidth = _relations['rightWidth'];
					}
					
					if(!sp.dragFlag) {
						item.x = _renderer.explicitWidth - (!rightHidden ? item.explicitWidth : trice);
						item.y = typeIndex * Math.floor(relationSize / count);
					}
					
				} else if(sp.type == PanelItemPosition.TOP) {
					
					typeIndex = (_relations['top'] as Array).indexOf(sp);
					sp.hidden = topHidden;
					count = (_relations['top'] as Array).length;
					relationSize = _renderer.explicitWidth - (!leftHidden ? _relations['leftWidth'] : 0) - (!rightHidden ? _relations['rightWidth'] : 0);
					
					item.explicitWidth = count > 1 ? Math.floor(relationSize / count) : relationSize;
					
					if(!sp.resizeFlag || !topHidden) {
						item.explicitHeight = _relations['topHeight'];
					}
					
					if(!sp.dragFlag) {
						item.x = (!leftHidden ? _relations['leftWidth'] : 0) + typeIndex * Math.floor(relationSize / count);
						item.y = (!topHidden ? 0 : - item.explicitHeight + trice);
					}
					
				} else if(sp.type == PanelItemPosition.BOTTOM) {
					
					typeIndex = (_relations['bottom'] as Array).indexOf(sp);
					sp.hidden = bottomHidden;
					count = (_relations['bottom'] as Array).length;
					relationSize = _renderer.explicitWidth - (!leftHidden ? _relations['leftWidth'] : 0) - (!rightHidden ? _relations['rightWidth'] : 0);
					item.explicitWidth = count > 1 ? Math.floor(relationSize / count) : relationSize;
					
					if(!sp.resizeFlag || !bottomHidden) {
						item.explicitHeight = _relations['bottomHeight'];
					}
					
					if(!sp.dragFlag) {
						item.x = (!leftHidden ? _relations['leftWidth'] : 0) + typeIndex * Math.floor(relationSize / count);
						item.y = _renderer.explicitHeight - (!bottomHidden ? item.explicitHeight : trice);
					}
				}
			}
		}
	}
}