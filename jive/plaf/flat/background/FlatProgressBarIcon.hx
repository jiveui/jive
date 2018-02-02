/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.plaf.flat.background;

import org.aswing.AsWingConstants;
import org.aswing.AsWingUtils;
import flash.display.Shape;
import flash.display.DisplayObject;
import org.aswing.GroundDecorator;
import org.aswing.Component;
import org.aswing.JProgressBar;
import org.aswing.StyleTune;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;

/**
 * The barIcon decorator for ProgressBar.
 * @private
 */
class FlatProgressBarIcon implements GroundDecorator implements UIResource{
	
	private var shape:Shape;
	private var indeterminatePercent:Float;
	
	public function new(){
		shape = new Shape();
		indeterminatePercent = 0;
	}

	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(Std.is(c,JProgressBar)){
			var bar:JProgressBar =AsWingUtils.as(c, JProgressBar);
			
			b = b.clone();
			var percent:Float;
			if(bar.isIndeterminate()) {
				percent = indeterminatePercent;
				indeterminatePercent += 0.01;
				if(indeterminatePercent > 1){
					indeterminatePercent = 0;
				}
			} else {
				percent = bar.getPercentComplete();
			}

			var verticle:Bool= (bar.getOrientation() == AsWingConstants.VERTICAL);
			shape.graphics.clear();

			var style:StyleTune = c.getStyleTune().mide;

			g = new Graphics2D(shape.graphics);
			var radius:Float= 0;

			if(verticle) {
				radius = Math.floor(b.width/2);
				b.height = Std.int(b.height * percent);
			} else {
				radius = Math.floor(b.height/2);
				b.width = Std.int(b.width * percent);
			}

            if(radius > style.round) {
				radius = style.round;
			}

			if(b.width > 1){
                g.fillRoundRect(new SolidBrush(c.mideground), b.x, b.y, b.width, b.height, radius);
			}
		 
		}
	}
	
}