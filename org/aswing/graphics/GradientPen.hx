/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics;

		
import flash.display.Graphics;
import flash.geom.Matrix;
import flash.display.GradientType;

import flash.display.InterpolationMethod;
import flash.display.SpreadMethod;
/**
 * GradientPen to draw Gradient lines.
 * @see org.aswing.graphics.Graphics2D
 * @see org.aswing.graphics.IPen
 * @see org.aswing.graphics.Pen
 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#lineGradientStyle()
 * @author n0rthwood
 */		
class GradientPen implements IPen{
	
	private var pen:Pen;
	private var fillType:GradientType;
	private var colors:Array<Int>;
	private var alphas:Array<Dynamic>;
	private var ratios:Array<Dynamic>;
	private var matrix:Matrix;
	private var spreadMethod:SpreadMethod;
	private var interpolationMethod:InterpolationMethod;
	private var focalPointRatio:Float;

	public function new(pen:Pen,fillType:GradientType, colors:Array<Int>, alphas:Array<Dynamic>, ratios:Array<Dynamic>, ?matrix:Matrix = null, ?spreadMethod:SpreadMethod, ?interpolationMethod:InterpolationMethod, ?focalPointRatio:Float= 0){
		this.pen = pen;
		this.fillType = fillType;
		this.colors = colors;
		this.alphas = alphas;
		this.ratios = ratios;
		this.matrix = matrix;
		this.spreadMethod = spreadMethod;
		this.interpolationMethod = interpolationMethod;
		this.focalPointRatio = focalPointRatio;
	}
	
	public function getSpreadMethod():SpreadMethod{
		return this.spreadMethod;
	}
	
	/**
	 * 
	 */
	public function setSpreadMethod(spreadMethod:SpreadMethod):Void{
		this.spreadMethod=spreadMethod;
	}
	
	public function getInterpolationMethod():InterpolationMethod{
		return this.interpolationMethod;
	}
	
	/**
	 * 
	 */
	public function setInterpolationMethod(interpolationMethod:InterpolationMethod):Void{
		this.interpolationMethod=interpolationMethod;
	}
	
	public function getFocalPointRatio():Float{
		return this.focalPointRatio;
	}
	
	/**
	 * 
	 */
	public function setFocalPointRatio(focalPointRatio:Float):Void{
		this.focalPointRatio=focalPointRatio;
	}
	
	public function getFillType():GradientType{
		return fillType;
	}
	
	/**
	 * 
	 */
	public function setFillType(t:GradientType):Void{
		fillType = t;
	}
		
	public function getColors():Array<Int>{
		return colors;
	}
	
	/**
	 * 
	 */
	public function setColors(cs:Array<Int>):Void{
		colors = cs;
	}
	
	public function getAlphas():Array<Dynamic>{
		return alphas;
	}
	
	/**
	 * 
	 */
	public function setAlphas(alphas:Array<Dynamic>):Void{
		this.alphas = alphas;
	}
	
	public function getRatios():Array<Dynamic>{
		return ratios;
	}
	
	/**
	 * 
	 */
	public function setRatios(rs:Array<Dynamic>):Void{
		ratios = rs;		
	}
	
	public function getMatrix():Dynamic{
		return matrix;
	}
	
	/**
	 * 
	 */
	public function setMatrix(m:Matrix):Void{
		matrix = m;
	}
	
	/**
	 * 
	 */
	public function setTo(target:Graphics):Void{
		pen.setTo(target);
		//target.lineGradientStyle(fillType,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
	}
}