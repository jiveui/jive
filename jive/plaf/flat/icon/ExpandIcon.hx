package jive.plaf.flat.icon;

import org.aswing.graphics.SolidBrush;
import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import org.aswing.Icon;
import flash.display.Shape;

class ExpandIcon implements Icon implements UIResource{
	
	private var shape:Shape;
	public var size:Int;
	public var color:ASColor;
    public var expanded:Bool;

	
	public function new(size:Int = 16, color:ASColor = null, expanded:Bool = false){
		if (null == color) color = ASColor.LIGHT_GRAY;
        this.size = size;
		this.color = color;
        this.expanded = expanded;
		shape = new Shape();
	}
	
	public function updateIcon(com:Component, g:Graphics2D, x:Int, y:Int) {
        shape.x = x;
        shape.y = y;

        x = 0;
        y = 0;

        var g:Graphics2D = new Graphics2D(shape.graphics);
        g.beginFill(new SolidBrush(color));
        g.moveTo(0,0);
        if (expanded) {
            g.lineTo(size,0);
            g.lineTo(size/2, 3*size/4);
        } else {
            g.lineTo(3*size/4, size/2);
            g.lineTo(0,size);
        }
        g.lineTo(0,0);
        g.endFill();
	}
	
	public function getIconHeight(c:Component):Int{
		return Std.int(size);
	}
	
	public function getIconWidth(c:Component):Int{
		return Std.int(size);
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
}