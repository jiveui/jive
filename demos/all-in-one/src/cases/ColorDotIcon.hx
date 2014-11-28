package cases;

	import org.aswing.graphics.Graphics2D;
	import org.aswing.Icon;
	import org.aswing.Component;
	import org.aswing.ASColor;
	import org.aswing.graphics.SolidBrush;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import org.aswing.AsWingUtils;
	class ColorDotIcon implements Icon
	{
		
		private var size:Int;
		private var color:ASColor;
		private var shape:Sprite;
		
		public function new(size:Int=20, color:ASColor=null){
			shape = new Sprite();
			this.size = size;
			if(color == null) color = ASColor.RED;
			this.color = color;
		}
		
		public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int):Void{
			shape.graphics.clear();
			g = new Graphics2D(shape.graphics);
			g.fillCircle(new SolidBrush(color), x+size/2, y+size/2, size/2);
		}
		
		public function getIconHeight(com:Component):Int{
			return size;
		}
		
		public function getIconWidth(com:Component):Int{
			return size;
		}
		
		public function getDisplay(com:Component):DisplayObject
		{
			return shape;
		}
		 
	}