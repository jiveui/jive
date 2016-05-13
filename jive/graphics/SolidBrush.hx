/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive.graphics;


import flash.display.Graphics;
import jive.graphics.IBrush;
import jive.Color;

/**
 * SolidBrush encapsulate fill parameters for flash.display.Graphics.beginFill()
 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#beginFill()
 * @author paling
 */
class SolidBrush implements IBrush{
	
	private var color:Color;
	
	public function new(color:Color){
		this.color = color;
	}
		
	public function getColor():Color{
		return color;
	}
	
	/**
	 * Sets the color
	 */
	public function setColor(color:Color):Void{		
		this.color = color;	
	}
	
	/**
	 * Begins fill
	 */
	public function beginFill(target:Graphics):Void{
		target.beginFill(color.rgb, color.alpha);
	}
	
	/**
	 * Ends fill
	 */
	public function endFill(target:Graphics):Void{
		target.endFill();
	}
}