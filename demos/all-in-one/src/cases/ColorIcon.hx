package cases;

	import org.aswing.graphics.Graphics2D;
	import org.aswing.Icon;
	import org.aswing.Component;
	import flash.display.DisplayObject;
	import org.aswing.ASColor;
	import org.aswing.graphics.SolidBrush;
	import flash.display.Shape;
	import org.aswing.AsWingUtils;
	class ColorIcon implements Icon
	{
		private var color:ASColor;
		private var width:Int;
		private var height:Int;
		private var shape:Shape;
		
		public function new(color:ASColor, width:Int, height:Int){
			shape = new Shape();
			this.color = color;
			this.width = width;
			this.height = height;
		}
		
		public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int):Void{
			shape.graphics.clear();
			g = new Graphics2D(shape.graphics);
			g.fillRectangle(new SolidBrush(color), x, y, width, height);
		}
		
		public function getIconHeight(com:Component):Int{
			return height;
		}
		
		public function getIconWidth(com:Component):Int{
			return width;
		}
		
		public function getDisplay(com:Component):DisplayObject
		{
			return shape;
		}
		 
	}