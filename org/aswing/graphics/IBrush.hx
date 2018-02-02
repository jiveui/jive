/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics;

	
import flash.display.Graphics;

/**
 * Brush to fill a closed area.<br>
 * Use it with a org.aswing.graphics.Graphics2D instance
 * @author paling
 */
interface IBrush{
	
	/**
	 * 
	 * This method will be called by Graphics2D autumaticlly.<br>
	 * It applys the fill paramters to the instance of flash.display.Graphics
	 * 
	 * @param target the instance of a flash.display.Graphics
	 */
	 function beginFill(target:Graphics):Void;
	
	/**
	 * 
	 * This method will be called by Graphics2D autumaticlly.<br>
	 * It marks the end of filling
	 * 
	 * @param target the instance of a flash.display.Graphics
	 */
	 function endFill(target:Graphics):Void;
}