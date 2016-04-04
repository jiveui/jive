/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import flash.display.DisplayObject;
/**
 * A small fixed size picture, typically used to decorate components. 
 * <p>
 * You can either return a display object to be the icon or just return null and paint the picture 
 * in <code>updateIcon</code> method use the component g(Graphics).
 * </p>
 * But, you'd better to return a display object here, because if you just paint graphics 
 * to the target component graphics, there's a situation that your painted graphics maybe 
 * not eyeable, that is when the component has a background decorator with a display object, 
 * it will cover this graphics. If you return a display object here, it will be no problem of this case.
 */
interface Icon extends Decorator
{	
			 
	/**
	 * Returuns the icon width.
	 * <p>
	 * For same component param, this method must return same value.
	 * </p>
	 * @param c the component which owns the icon.
	 * @return the width of the icon.
	 */
	function getIconWidth(c:Component):Int;
	
	/**
	 * Returns the icon height.
	 * <p>
	 * For same component param, this method must return same value.
	 * </p>
	 * @param c the component which owns the icon.
	 * @return the height of the icon.
	 */
	function getIconHeight(c:Component):Int;
	
	/**
	 * Updates the icon.
	 * @param c the component which owns the icon.
	 * @param g the graphics of the component, you can paint picture onto it.
	 * @param x the x coordinates of the icon should be.
	 * @param y the y coordinates of the icon should be.
	 */
	function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void;	
	 
}