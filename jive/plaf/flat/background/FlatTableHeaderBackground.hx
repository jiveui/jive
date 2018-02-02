/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.plaf.flat.background;


import flash.display.DisplayObject;
import flash.display.Shape; 
import flash.filters.BitmapFilterType;
import flash.geom.Matrix;
import org.aswing.graphics.Pen;

import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

/**
 * @private
 */
class FlatTableHeaderBackground implements GroundDecorator implements UIResource{
	
	private var shape:Shape;
	
	public function new(){
		shape = new Shape();
	}

	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		shape.graphics.clear();
		if(c.isOpaque()){
			g = new Graphics2D(shape.graphics);
			g.drawLine(new Pen(c.mideground), b.x, b.y + b.height-1, b.x + b.width, b.y + b.height-1);
		}
		shape.visible = c.isOpaque();
	}
	
}