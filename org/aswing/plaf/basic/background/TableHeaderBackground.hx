/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.background;


import flash.display.DisplayObject;
import flash.display.Shape; 
import flash.filters.BitmapFilterType;
import flash.geom.Matrix;

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
class TableHeaderBackground implements GroundDecorator implements UIResource{
	
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
			var cl:ASColor = c.getBackground();
			var turn:StyleTune = c.getStyleTune();
			var style:StyleResult = new StyleResult(cl, turn);
			var matrixB:IntRectangle = b.clone();
			var graphicB:IntRectangle = b.clone();
			graphicB.height += Std.int(style.round * 2);

			BasicGraphicsUtils.fillGradientRoundRect(g, graphicB, style, Math.PI/2, false, matrixB);

			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(b.width, b.height, Math.PI/2, b.x, b.y);
			g.fillRoundRect(new GradientBrush(
					GradientBrush.LINEAR, 
					[0xFFFFFF, 0xFFFFFF], 
					[0.2, 0.04], 
					[0, 255], 
					matrix
				), 
				b.x, b.y, b.width, b.height / 2 - 1, style.round, style.round, 0, 0);
			#if(flash9)
			shape.filters = [new flash.filters.BevelFilter(1, 90, 0xFFFFFF, style.shadow, 0x0, style.shadow, 1, 1, 1, 1, BitmapFilterType.INNER)];
			#end
		}
		shape.visible = c.isOpaque();
	}
	
}