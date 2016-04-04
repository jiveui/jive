/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.Component;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import flash.display.DisplayObject;
/**
 * Decorator for background or foreground of a components.
 * <p>
 * You can either return a display object to be the decorator or just return null and paint  
 * in <code>updateDecorator</code> method use the component g(Graphics).
 * <p>
 * (Maybe it is not good to paint on the component graphics for foreground decorator since component graphics 
 * is not on top of component children)
 */
interface GroundDecorator extends Decorator
{
	 
	/**
	 * Updates the decorator.
	 * @param c the component which owns the ground decorator.
	 * @param g the graphics of the component, you can paint picture onto it.
	 * @param b the bounds of the component can be decorated.
	 */
	function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void;

}