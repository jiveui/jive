/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.border;


import org.aswing.graphics.GradientPen;
import org.aswing.ASColor;
	import org.aswing.Border;
	import org.aswing.Component;
	import org.aswing.Insets;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.geom.IntRectangle;
	import flash.display.DisplayObject;
	/**
 * A border that draw a line at one side of a component.
 * @author paling
 */
class SideLinesBorder extends DecorateBorder
{
	
    /**
     * The west side constraint (left of component).
     */
    inline public static var WEST: Int = 1;

    /**
     * The north side constraint (top of component).
     */
    inline public static var NORTH: Int = 2;

    /**
     * The east side constraint (right side of component).
     */
    inline public static var EAST: Int = 4;

    /**
     * The south side constraint (bottom of component).
     */
    inline public static var SOUTH: Int = 8;

	public var side: Int;

	public var color: ASColor;
	public var thickness: Float;
	public var isShadow: Bool;
	
	/**
	 * SideLineBorder(interior:Border, side:Number, color:ASColor, thickness:Number) <br>
	 * SideLineBorder(interior:Border, side:Number, color:ASColor) <br>
	 * SideLineBorder(interior:Border, side:Number) <br>
	 * SideLineBorder(interior:Border) <br>
	 * SideLineBorder() <br>
	 * <p>
	 * @param interior interior border. Default is null;
	 * @param side the side of the line. Must be one of bottom value:
	 * <ul>
	 *   <li>#NORTH
	 *   <li>#SOUTH
	 *   <li>#EAST
	 *   <li>#WEST
	 * </ul>
	 * .Default is NORTH.
	 * @param color the color of the border. Default is ASColor.BLACK
	 * @param thickness the thickness of the border. Default is 1
	 */
	public function new(interior:Border=null, side:Int=NORTH, color:ASColor=null, thickness:Float=1) {
		super(interior);
		if (color == null) color = ASColor.BLACK;
		
		this.side = side;
		this.color = color;
		this.thickness = thickness;
	}

	override public function updateBorderImp(com:Component, g:Graphics2D, b:IntRectangle):Void{
 		var pen:Pen = new Pen(color, thickness);
 		var x1:Float = 0, x2:Float = 0, y1:Float = 0, y2:Float = 0;

 		if (side & SOUTH == SOUTH) {
 			x1 = b.x;
 			y1 = b.y + b.height - if (isShadow) thickness else thickness/2;
 			x2 = b.x + b.width;
 			y2 = y1;

			if (isShadow)
				drawShadowLine(g, x1, x2, y1, y2, SOUTH)
			else
				g.drawLine(pen, x1, y1, x2, y2);
 		}
		if (side & EAST == EAST) {
 			x1 = b.x + b.width - if (isShadow) thickness else (thickness/2);
 			y1 = b.y;
 			x2 = x1;
 			y2 = b.y + b.height;

			if (isShadow)
				drawShadowLine(g, x1, x2, y1, y2, EAST)
			else
				g.drawLine(pen, x1, y1, x2, y2);
 		}
		if (side & NORTH == NORTH) {
 			x1 = b.x;
 			y1 = b.y + if (isShadow) thickness else thickness/2;
 			x2 = b.x + b.width;
 			y2 = y1;

			if (isShadow)
				drawShadowLine(g, x1, x2, y1, y2, NORTH)
			else
				g.drawLine(pen, x1, y1, x2, y2);
		}
		if (side & WEST == WEST) {
			x1 = b.x + if (isShadow) thickness else thickness/2;
			y1 = b.y;
			x2 = x1;
			y2 = b.y + b.height;

			if (isShadow)
				drawShadowLine(g, x1, x2, y1, y2, WEST)
			else
				g.drawLine(pen, x1, y1, x2, y2);
		}
	}

	private function drawShadowLine(g: Graphics2D, x1: Float, x2: Float, y1: Float, y2: Float, direction: Int): Void {
		var count: Int = Std.int(this.thickness);
		for (i in 0...count) {
			var alpha: Float = (this.color.getAlpha() / count) * (count - i);
			var pen: Pen = new Pen(new ASColor(this.color.getRGB(), alpha), 1);
			if (direction == EAST) {
				if (side & NORTH != NORTH && side & SOUTH != SOUTH) // normal line
					g.drawLine(pen, x1 + i, y1, x2 + i, y2)
				else // pyramid line on top and bottom
					g.drawLine(pen, x1 + i, y1 + count - i, x2 + i, y2 - count + i);
				// TODO pyramid line only on top and only on bottom
			}
			if (direction == NORTH) {
				if (side & WEST != WEST && side & EAST != EAST) // normal line
					g.drawLine(pen, x1, y1 - i, x2, y2 - i);
				else if (side & WEST != WEST && side & EAST == EAST) // pyramid line on right
					g.drawLine(pen, x1 - 1, y1 - i, x2 - count + i - 1, y2 - i);
				// TODO pyramid line on right and on left and ring
			}
			if (direction == SOUTH) {
				if (side & WEST != WEST && side & EAST != EAST) // normal line
					g.drawLine(pen, x1, y1 + i, x2, y2 + i);
				else if (side & WEST != WEST && side & EAST == EAST)
					g.drawLine(pen, x1 - 1, y1 + i, x2 - count + i - 1, y2 + i);
				// TODO pyramid line on right and on left and ring
			}
			if (direction == WEST) {
				if (side & NORTH != NORTH && side & SOUTH != SOUTH) // normal line
					g.drawLine(pen, x1 - i, y1, x2 - i, y2);
				// TODO all pyramid lines
			}
		}
	}
    
    override public function getBorderInsetsImp(c:Component, bounds:IntRectangle):Insets{
    	var i:Insets = new Insets();
 		if (side & SOUTH== SOUTH) {
 			i.bottom = Std.int(thickness);
 		}
		if (side & EAST == EAST) {
 			i.right = Std.int(thickness);
 		}
		if(side & WEST == WEST){
 			i.left = Std.int(thickness);
 		}
		if (side & NORTH == NORTH) {
 			i.top = Std.int(thickness);
 		}
    	return i;
    }   
     
	override public function getDisplayImp():DisplayObject
	{
		return null;
	}
	
	public function getColor():ASColor {
		return color;
	}

	public function setColor(color:ASColor):Void{
		this.color = color;
	}

	public function getThickness():Float{
		return thickness;
	}

	public function setThickness(thickness:Float):Void{
		this.thickness = thickness;
	}

	public function getSide():Float{
		return side;
	}

	public function setSide(side:Float):Void{
		this.side = Std.int(side);
	}
}