package jive.plaf.flat.background;

import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.Component;
import flash.geom.Matrix;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Pen;
import org.aswing.ASColor;
import org.aswing.graphics.SolidBrush;

/**
 * ...
 * @author Nick Grebenshikov
 */

class FlatTableBackground extends org.aswing.plaf.basic.background.TableBackground {

	public function new() {
		super();
	}
	
	override public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void {
		shape.graphics.clear();
		if(c.isOpaque()){
			g = new Graphics2D(shape.graphics);
			b = b.clone();
		}
		shape.visible = c.isOpaque();
	}
}