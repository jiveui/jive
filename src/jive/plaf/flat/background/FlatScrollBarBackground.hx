/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.plaf.flat.background;

import org.aswing.AsWingUtils;
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
class FlatScrollBarBackground implements GroundDecorator implements UIResource{
	
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
			g = new Graphics2D(shape.graphics);
			b = b.clone();
            g.fillRoundRect(new SolidBrush(c.background), b.x, b.y, b.width, b.height, c.styleTune.round);
		}
	}
	
}