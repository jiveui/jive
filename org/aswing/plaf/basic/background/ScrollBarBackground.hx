/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.background;
import flash.filters.GlowFilter;
import flash.filters.DropShadowFilter;
import flash.display.DisplayObject;
import flash.display.Shape; 
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import org.aswing.AsWingConstants;
import org.aswing.AsWingManager;
import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.Orientable;
import org.aswing.StyleTune;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;

/**
 * @private
 */
class ScrollBarBackground implements GroundDecorator implements UIResource{
	
	private var shape:Shape;
	
	public function new(){
		shape = new Shape();
	}

	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(Std.is(c,Orientable)&& c.isOpaque()){
			var bar:Orientable = AsWingUtils.as(c,Orientable)	;
			var verticle:Bool= (bar.getOrientation() == AsWingConstants.VERTICAL);
			shape.graphics.clear();
			var style:StyleTune = c.getStyleTune();
			g = new Graphics2D(shape.graphics);
			b = b.clone();
		 

			g.fillRoundRect(new SolidBrush(c.getBackground().changeAlpha(1)), b.x, b.y, b.width, b.height, style.round);
			var f :Array<BitmapFilter>= new Array<BitmapFilter>();
            f.push(new  GlowFilter(0x0, style.shadowAlpha, 5, 5, 1, 1, true));
			shape.filters = f;
			 
			shape.alpha = c.getBackground().getAlpha();
		}
	}
	
}