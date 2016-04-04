/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.background;
import flash.filters.GlowFilter;
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import flash.display.Shape;
import flash.display.DisplayObject;
import org.aswing.GroundDecorator;
import org.aswing.Component;
import org.aswing.JProgressBar;
import org.aswing.StyleTune;
import org.aswing.StyleResult;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

/**
 * The barIcon decorator for ProgressBar.
 * @private
 */
class ProgressBarIcon implements GroundDecorator implements UIResource{
	
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
			if(bar.isIndeterminate()){
				percent = indeterminatePercent;
				indeterminatePercent += 0.1;
				if(indeterminatePercent > 1){
					indeterminatePercent = 0;
				}
			}else{
				percent = bar.getPercentComplete();
			}
			var verticle:Bool= (bar.getOrientation() == AsWingConstants.VERTICAL);
			shape.graphics.clear();
			var style:StyleTune = c.getStyleTune().mide;
			g = new Graphics2D(shape.graphics);
			var radius:Float= 0;
			var direction:Float;
			if(verticle)	{
				radius = Math.floor(b.width/2);
				direction = 0;
				b.height = Std.int(b.height *percent);
			}else{
				radius = Math.floor(b.height/2);
				direction = Math.PI/2;
				b.width  =Std.int(b.width * percent);
			}
			if(radius > style.round){
				radius = style.round;
			}
			if(b.width > 1){
				var result:StyleResult = new StyleResult(c.getMideground(), style);
				BasicGraphicsUtils.fillGradientRoundRect(g, b, result, direction);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, result, direction);
				if(b.width-radius*2 > 0){
					g.fillRectangle(new SolidBrush(c.getMideground().changeAlpha(0.3)), radius, b.height-2.5, b.width-radius*2, 1.5);
				}
				//var f :Array<BitmapFilter>= new Array<BitmapFilter>();
				//f.push(new GlowFilter(0x0, result.shadow, 1, 1, 8, 1, true));
				//shape.filters = f;
			}
		 
		}
	}
	
}