/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics;


import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import Type;

import org.aswing.ASColor;

/**
 * Pen encapsulate normal lineStyle properties. <br>
 * You can use pen to draw an ordinary shape. To draw gradient lines, refer to <code>org.aswing.graphics.GradientPen</code>
 * 
 * @see org.aswing.graphics.IPen
 * @see org.aswing.graphics.GradientPen
 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#lineStyle()
 * @author paling
 */
class Pen implements IPen{
	
	private var _thickness:Float;
	private var _color:ASColor;
	private var _pixelHinting:Bool;
	private var _scaleMode:LineScaleMode;
	private var _caps:CapsStyle;
	private var _joints:JointStyle;
	private var _miterLimit:Float;
	
	/**
	 * Create a Pen.
	 */
	public function new(color:ASColor,
				 ?thickness:Float=1, 
				 ?pixelHinting:Bool= false, 
				 ?scaleMode:LineScaleMode= null, 
				 ?caps:CapsStyle= null, 
				 ?joints:JointStyle= null, 
				 ?miterLimit:Float= 3){
				 	
		this._color = color;
		this._thickness = thickness;
		this._pixelHinting = pixelHinting;
		this._scaleMode = scaleMode;
		this._caps = caps;
		this._joints = joints;
		this._miterLimit = miterLimit;
		
	}
	
	public function getColor():ASColor{
		return _color;
	}
	
	/**
	 * 
	 */
	public function setColor(color:ASColor):Void{
		this._color=color;
	}
	
	public function getThickness():Float{
		return _thickness;
	}
	
	/**
	 * 
	 */
	public function setThickness(thickness:Float):Void{
		this._thickness=thickness;
	}
	
 	public function getPixelHinting():Bool{
 		return this._pixelHinting;
 	}
 	
 	/**
	 * 
	 */
 	public function setPixelHinting(pixelHinting:Bool):Void{
 		this._pixelHinting = pixelHinting;
 	}
	
	public function getScaleMode():LineScaleMode{
		return this._scaleMode;
	}
	
	/**
	 * 
	 */
	public function setScaleMode(scaleMode:LineScaleMode):Void{
		this._scaleMode =  scaleMode;
	}
	
	public function getCaps():CapsStyle{
		return this._caps;
	}
	
	/**
	 * 
	 */
	public function setCaps(caps:CapsStyle):Void{
		this._caps=caps;
	}
	
	public function getJoints():JointStyle{
		return this._joints;
	}
	
	/**
	 * 
	 */
	public function setJoints(joints:JointStyle):Void{
		this._joints=joints;
	}
	
	public function getMiterLimit():Float{
		return this._miterLimit;
	}
	
	/**
	 * 
	 */
	public function setMiterLimit(miterLimit:Float):Void{
		this._miterLimit = miterLimit;
		
	}
	
	/**
	 * @inheritDoc 
	 */
	public function setTo(target:Graphics):Void {
	//
 //lineStyle(?thickness : Float, color : Int = 0, alpha : Float = 1, pixelHinting : Bool = false, ?scaleMode : LineScaleMode, ?caps : CapsStyle, ?joints : JointStyle, miterLimit : Float = 3) : Void;
		target.lineStyle(_thickness, _color.getRGB(), _color.getAlpha(), _pixelHinting,_scaleMode,_caps,_joints,_miterLimit);
	}
}