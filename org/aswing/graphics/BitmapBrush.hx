/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.graphics;

	import flash.display.Graphics;
	import flash.display.BitmapData;
	import flash.geom.Matrix;



/**
 * Encapsulate the fill parameter for flash.display.Graphics.beginBitmapFill()
 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#beginBitmapFill()
 * @author n0rthwood
 */
class BitmapBrush implements IBrush{
	
	private var _bitmapData:BitmapData;
	private var _matrix:Matrix;
	private var _repeat:Bool;
	private var _smooth:Bool;
	
	public function new(bitmap:BitmapData, ?matrix:Matrix = null, ?repeat:Bool= true, ?smooth:Bool= false){
		this._bitmapData=bitmap;
		this._matrix=matrix;
		this._repeat=repeat;
		this._smooth=smooth;
	}
	
	/**
	 * @inheritDoc 
	 */
	public function beginFill(target:Graphics):Void{
		target.beginBitmapFill(_bitmapData,_matrix,_repeat,_smooth);
	}
	
	/**
	 * @inheritDoc 
	 */
	public function endFill(target:Graphics):Void{
		target.endFill();
	}
	
	public function getBitmapData():BitmapData{
		return _bitmapData;
	}
	
	/**
	 *
	 */
	public function setBitmapData(bitmapData:BitmapData):Void{
		this._bitmapData = bitmapData;
	}
	
	public function getMatrix():Matrix{
		return _matrix;
	}
	
	/**
	 *
	 */
	public function setMatrix(matrix:Matrix):Void{
		this._matrix = matrix;
	}
	
	public function isRepeat():Bool{
		return _repeat;
	}
	
	/**
	 *
	 */
	public function setRepeat(repeat:Bool):Void{
		this._repeat = repeat;
	}
	
	public function isSmooth():Bool{
		return _smooth;
	}
	
	/**
	 *
	 */
	public function setSmooth(smooth:Bool):Void{
		this._smooth = smooth;
	}
	
}