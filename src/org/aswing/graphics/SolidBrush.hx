/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics;


import flash.display.Graphics;
import org.aswing.ASColor;
import org.aswing.graphics.IBrush;

/**
 * SolidBrush encapsulate fill parameters for flash.display.Graphics.beginFill()
 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#beginFill()
 * @author paling
 */
class SolidBrush implements IBrush{
	
	private var color:ASColor;
	
	public function new(color:ASColor){
		this.color = color;
	}
		
	public function getColor():ASColor{
		return color;
	}
	
	/**
	 * Sets the color
	 */
	public function setColor(color:ASColor):Void{		
		this.color = color;	
	}
	
	/**
	 * Begins fill
	 */
	public function beginFill(target:Graphics):Void{
		target.beginFill(color.getRGB(), color.getAlpha());
	}
	
	/**
	 * Ends fill
	 */
	public function endFill(target:Graphics):Void{
		target.endFill();
	}
}