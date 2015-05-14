package jive.plaf.flat.accordion;

import flash.geom.Matrix;
import org.aswing.ASColor;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.SolidBrush;
import org.aswing.GroundDecorator;
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import flash.display.DisplayObject;

/**
 * ...
 * @author Nick Grebenshikov
 */

class AccordionItemBackground implements GroundDecorator {

	public function new() {}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void {
		g.clear();
		g.fillRectangle(new SolidBrush(new ASColor(0xfafafa)), b.x-c.getInsets().left, b.y-c.getInsets().top, b.width + c.getInsets().getMarginWidth(), b.height +  c.getInsets().getMarginHeight());
		//var matrix:Matrix = new Matrix();
		//matrix.createGradientBox(b.width + c.getInsets().getMarginWidth(), 5, Math.PI / 2, 0, 0);
		//var gBrush: GradientBrush = new GradientBrush(GradientBrush.LINEAR, [0xd5d5d5, 0xd5d5d5], [1.0, 0.0], [0x0, 0xff], matrix);
		//g.fillRectangle(gBrush, 0, 0, b.width + c.getInsets().getMarginWidth(), 5);
	}
	
	public function getDisplay(c:Component):DisplayObject {
		return null;
	}
	
}