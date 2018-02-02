/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.background;


import flash.display.DisplayObject;
import flash.display.Shape;

import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.StyleTune;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

/**
 * @private
 */
class ToolTipBackground implements GroundDecorator implements UIResource{
	
	private var shape:Shape;
	
	public function new(){
		shape = new Shape();
	}

	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
    	shape.visible = c.isOpaque();
    	if(c.isOpaque()){
    		shape.graphics.clear();
    		g = new Graphics2D(shape.graphics);
			var cc:ASColor = c.getBackground();
			var bc:ASColor = c.getMideground();
			var tune:StyleTune = c.getStyleTune();
			g.beginFill(new SolidBrush(bc));
			var r:Float= tune.round;
			b = new IntRectangle(0, 0,  c.getWidth(), c.getHeight());
			if(r < 1){
				g.rectangle(b.x, b.y, b.width, b.height);
			}else{
				BasicGraphicsUtils.drawRoundRect(g, b.x, b.y, b.width, b.height, r);
			}
			g.endFill();
			g.beginFill(new SolidBrush(cc));
			r -= 0.5;
			b.grow(-1, -1);
			if(r < 1){
				g.rectangle(b.x, b.y, b.width, b.height);
			}else{
				BasicGraphicsUtils.drawRoundRect(g, b.x, b.y, b.width, b.height, r);
			}
			g.endFill();
    	}		
	}
	
}