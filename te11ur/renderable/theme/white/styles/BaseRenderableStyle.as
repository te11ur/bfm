package te11ur.renderable.theme.white.styles
{
	import te11ur.renderable.theme.IStyle;

	public class BaseRenderableStyle implements IStyle
	{
		/**
		 * ColorStates
		 * 'nameOfState': [bgColorDeff, textColorDeff, borderColorDeff]
		 */
		public var colorStates:Object = {
			'default': [0, 0, 0],
			'selected': [-(0x222222), 0x222222, -(0x222222)],
			'over': [-(0x111111), 0x111111, -(0x111111)],
			'overSelected': [-(0x252525), 0x252525, -(0x252525)],
			'disable': [-(0x111111), 0x444444, -(0x444444)]			
		};
		
		/**
		 * AlphaStates
		 * 'nameOfState': [bgAlphaDeff]
		 */
		public var alphaStates:Object = {
			'default': [0],
			'selected': [0],
			'over': [0],
			'overSelected': [0],
			'disable': [0]			
		};
		
		/**
		 * BorderStates
		 * 'nameOfState': [borderTopDeff, borderRightDeff, borderBottomDeff, borderLeftDeff]
		 */
		public var borderStates:Object = {
			'default': [0, 0, 0, 0],
			'selected': [0, 0, 0, 0],
			'over': [0, 0, 0, 0],
			'overSelected': [0, 0, 0, 0],
			'disable': [0, 0, 0, 0]
		};
		
		public var bgColor:uint = 0xffffff;
		public var textColor:uint = 0x111111;
		public var borderColor:uint = 0x000000;
		
		public var bgAlpha:Number = 1;
		
		public var border:uint = 0;
		
		public function get fontName():String
		{
			return "Verdana";
		}
		
		public function getColor(state:String, subject:String = 'bg'):uint
		{
			var sub:uint = 0;
			
			if(subject+'Color' in this) {
				sub = this[subject+'Color'] as uint;
			} else {
				return 0;
			}
			
			var st:String;
			var color:uint = sub;
			var prop:int = 0;
			
			if(state in colorStates) {
				st = state;
			} else if('default' in colorStates) {				
				st = 'default';
			}
			
			if(st) {
				switch(subject) {
					case 'bg':
						prop = colorStates[st][0];
						break;
					case 'text':
						prop = colorStates[st][1];
						break;
					case 'border':
						prop = colorStates[st][2];
						break;
				}
				
				if(sub + prop < 0) {
					color = 0;
				} else if(sub + prop > 0xffffff) {
					color = 0xffffff;
				} else {
					color = sub + prop;
				}
			}
			
			return color;
		}
		
		public function getAlpha(state:String, subject:String = 'bg'):Number
		{
			var sub:Number = 0;
			
			if(subject+'Alpha' in this) {
				sub = this[subject+'Alpha'] as Number;
			} else {
				return 0;
			}
			
			var st:String;
			var alpha:Number = sub;
			var prop:Number = 0;
			
			if(state in alphaStates) {
				st = state;
			} else if('default' in alphaStates) {				
				st = 'default';
			}
			
			if(st) {
				switch(subject) {
					case 'bg':
						prop = alphaStates[st][0];
						break;
				}
				
				if(sub + prop < 0) {
					alpha = 0;
				} else if(sub + prop > 1) {
					alpha = 1;
				} else {
					alpha = sub + prop;
				}
			}
			
			return alpha;
		}
		
		public function getBorder(state:String, positon:String = 'all'):uint
		{			
			var st:String;
			
			if(state in borderStates) {
				st = state;
			} else if('default' in borderStates) {				
				st = 'default';
			}
			
			var border:uint = border;
			var prop:int = 0;
			
			if(st) {
				switch(positon) {
					case 'top':
						prop = borderStates[st][0]
						break;
					case 'right':
						prop = borderStates[st][1]
						break;
					case 'bottom':
						prop = borderStates[st][2]
						break;
					case 'left':
						prop = borderStates[st][3]
						break;
					default:
						prop = 0;
						break;
				}
				
				if(border + prop < 0) {
					border = 0;
				} else if(border + prop > 30) {
					border = 30;
				} else {
					border = border + prop;
				}
			}
			
			return border;
		}
	}
}