/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.graphics;

	
import flash.display.Graphics;	

/**
 * Pen to draw lines.<br>
 * Use it with a org.aswing.graphics.Graphics2D instance
 * @author n0rthwood
 */	
interface IPen{
	
	/**
	 *
	 * This method will be called by Graphics2D autumaticlly.<br>
	 * It will set the lineStyle to the instance of flash.display.Graphics 
	 * @param target the instance of graphics from a display object
	 */ 
	function setTo(target:Graphics):Void;
}