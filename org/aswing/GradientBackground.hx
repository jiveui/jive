package org.aswing;


import flash.display.GradientType;
import flash.display.SpreadMethod;
import org.aswing.graphics.GradientBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.geom.IntRectangle;
import flash.display.DisplayObject;
import flash.geom.Matrix;
	import flash.display.Shape;
	import flash.display.InterpolationMethod;
import flash.display.SpreadMethod;

/**
 * A background decorator that paint a gradient color.
 * @author
 */
class GradientBackground implements GroundDecorator{
	
	private var brush:GradientBrush;
	private var direction:Float;
	private var shape:Shape;
	
	public function new(fillType:GradientType, colors:Array<Int>, alphas:Array<Dynamic>, ratios:Array<Dynamic>, direction:Float=0, 
					?spreadMethod:SpreadMethod, ?interpolationMethod:InterpolationMethod, ?focalPointRatio:Float= 0){
		this.brush = new GradientBrush(fillType, colors, alphas, ratios, new Matrix(), 
			spreadMethod, interpolationMethod, focalPointRatio);
		this.direction = direction;
		shape = new Shape();
	}
	
	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):Void{
		shape.graphics.clear();
		g = new Graphics2D(shape.graphics);
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(bounds.width, bounds.height, direction, bounds.x, bounds.y);    
		brush.setMatrix(matrix);
		g.fillRectangle(brush, bounds.x, bounds.y, bounds.width, bounds.height);
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
}