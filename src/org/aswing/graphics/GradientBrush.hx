/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics;


import flash.display.InterpolationMethod;
import flash.display.SpreadMethod;
import org.aswing.graphics.IBrush;
import flash.display.Graphics;
import flash.geom.Matrix;
import flash.display.GradientType;

/**
 * GradientBrush encapsulate the fill paramters for flash.display.Graphics.beginGradientFill()
 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#beginGradientFill()
 * @author paling
 */
class GradientBrush implements IBrush{
	
	public static var LINEAR:GradientType= GradientType.LINEAR;
	public static var RADIAL:GradientType= GradientType.RADIAL;
 
	private var fillType:GradientType;
	private var colors:Array<Int>;
	private var alphas:Array<Dynamic>;
	private var ratios:Array<Dynamic>;
	private var matrix:Matrix;
	private var spreadMethod:SpreadMethod;
	private var interpolationMethod:InterpolationMethod;
	private var focalPointRatio:Float;
	
	/**
	 * Create a GradientBrush object<br>
	 * you can refer the explaination for the paramters from Adobe's doc
	 * to create a Matrix, you can use matrix.createGradientBox() from the matrix object itself
	 * 
	 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#beginGradientFill()
	 * @see http://livedocs.macromedia.com/flex/2/langref/flash/geom/Matrix.html#createGradientBox()
	 */
	public function new(fillType:GradientType, colors:Array<Int>, alphas:Array<Dynamic>, ratios:Array<Dynamic>, matrix:Matrix,
					?spreadMethod:SpreadMethod, ?interpolationMethod:InterpolationMethod, ?focalPointRatio:Float= 0){
		this.fillType = fillType;
		this.colors = colors;
		this.alphas = alphas;
		this.ratios = ratios;
		this.matrix = matrix;
		this.spreadMethod = spreadMethod;
		this.interpolationMethod = interpolationMethod;
		this.focalPointRatio = focalPointRatio;
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
	 * Pay attention that the value in the array should be between 0-1. if the value is greater than 1, 1 will be used, if the value is less than 0, 0 will be used
	 */
	public function setAlphas(alphas:Array<Dynamic>):Void{
		this.alphas = alphas;
	}
	
	public function getRatios():Array<Dynamic>{
		return ratios;
	}
	
	/**
	 * Ratios should be between 0-255, if the value is greater than 255, 255 will be used, if the value is less than 0, 0 will be used
	 */
	public function setRatios(ratios:Array<Dynamic>):Void{
		this.ratios = ratios;
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
	 * @inheritDoc 
	 */
	public function beginFill(target:Graphics):Void {
		target.beginGradientFill(fillType, cast(colors), alphas, ratios, matrix,
			spreadMethod, interpolationMethod, focalPointRatio);
	}
	
	/**
	 * @inheritDoc 
	 */
	public function endFill(target:Graphics):Void{
		target.endFill();
	}	
}