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
class GradientBackground implements GroundDecorator implements bindx.IBindable {
	
	private var brush:GradientBrush;
	public var direction:Float;
	private var shape:Shape;
	
	public var fillType(get, set): GradientType;
	private function get_fillType(): GradientType { return brush.getFillType(); }
	private function set_fillType(v: GradientType): GradientType {
	    brush.setFillType(v);
	    return v;
	}

	public var colors(get, set): Array<Int>;
	private function get_colors(): Array<Int> { return brush.getColors(); }
	private function set_colors(v: Array<Int>): Array<Int> {
	    brush.setColors(v);
	    return v;
	}

	public var alphas(get, set): Array<Dynamic>;
	private function get_alphas(): Array<Dynamic> { return brush.getAlphas(); }
	private function set_alphas(v: Array<Dynamic>): Array<Dynamic> {
	    brush.setAlphas(v);
	    return v;
	}

	public var ratios(get, set): Array<Dynamic>;
	private function get_ratios(): Array<Dynamic> { return brush.getRatios(); }
	private function set_ratios(v: Array<Dynamic>): Array<Dynamic> {
	    brush.setRatios(v);
	    return v;
	}


	public function new(?fillType:GradientType, ?colors:Array<Int>, ?alphas:Array<Dynamic>, ?ratios:Array<Dynamic>, direction:Float=0,
					?spreadMethod:SpreadMethod, ?interpolationMethod:InterpolationMethod, focalPointRatio:Float= 0){
		if (fillType == null) fillType = GradientType.LINEAR;
		if (colors == null) colors = [];
		if (ratios == null) ratios = [];
		if (alphas == null) alphas = [];
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