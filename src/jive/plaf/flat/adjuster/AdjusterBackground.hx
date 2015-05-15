package jive.plaf.flat.adjuster;

import flash.display.DisplayObject;
import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.plaf.UIResource;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;

class AdjusterBackground implements GroundDecorator implements UIResource {

	public function new() {
	} 
	

	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle) {
		//var matrix: Matrix = new Matrix();
		//matrix.createGradientBox(b.width, b.height, Math.PI / 2, b.x, b.y);
		//var gBrush: GradientBrush = new GradientBrush(GradientBrush.LINEAR, [0xd9d9d9, 0xffffff], [1.0, 1.0], [0, 25 * 255 / 100], matrix);
		//g.fillRoundRect(gBrush, b.x-1, b.y-1, b.width+2, b.height+2, 5);
	}
	
	public function getDisplay(c:Component):DisplayObject {
		return null;
	}
	
}