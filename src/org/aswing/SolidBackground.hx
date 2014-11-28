/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import flash.display.DisplayObject;
import org.aswing.graphics.SolidBrush;
import flash.display.Shape;

/**
 * A background decorator that paint a solid color.
 * @author
 */
class SolidBackground implements GroundDecorator{
	
	private var color:ASColor;
	private var shape:Shape;
	
	public function new(color:ASColor){
		this.color = color;
		shape = new Shape();
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
		shape.graphics.clear();
		g = new Graphics2D(shape.graphics);
		g.fillRectangle(new SolidBrush(color), bounds.x, bounds.y, bounds.width, bounds.height);	
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
}