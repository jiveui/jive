package jive.plaf.flat.icon;
	
import flash.display.DisplayObject;
import org.aswing.graphics.Pen;
import org.aswing.plaf.UIResource;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import org.aswing.Icon;
import flash.display.Shape;

class PlusIcon implements Icon implements UIResource{
	
	private var shape:Shape;
	private var width:Float;
	private var height:Float;
	private var color:ASColor;
	
	public function new(size:Float, color:ASColor){
		this.width = size;
		this.height = size;
		this.color = color;
		shape = new Shape();
		var x:Int = 0;
		var y:Int = 0;
		var g:Graphics2D = new Graphics2D(shape.graphics);
		var pen: Pen = new Pen(color, 2);
		var halfSize: Float = size / 2;
		g.drawLine(pen, 0, halfSize, size, halfSize);
		g.drawLine(pen, halfSize, 0, halfSize, size);
	}	
	
	public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int) {
		shape.x = x;
		shape.y = y;
	}
	
	public function getIconHeight(c:Component):Int{
		return Std.int(height);
	}
	
	public function getIconWidth(c:Component):Int{
		return Std.int(width);
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
}