/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import flash.display.DisplayObject;
/**
 * Interface describing an object capable of rendering a border around the edges of a component.
 * <p>
 * You can either return a display object to be the border or just return null and paint the border 
 * in <code>updateBorder</code> method use the component g(Graphics).
 * </p>
 */
interface Border extends Decorator
{
	 
	/**
	 * Updates the border.
	 * @param c the component which owns the border.
	 * @param g the graphics of the component, you can paint picture onto it.
	 * @param b the bounds of the border should be.
	 */
	function updateBorder(c:Component, g:Graphics2D, b:IntRectangle):Void;
	
	/**
	 * Returns the insets of the border.
	 * @param c the component which owns the border.
	 * @param b the bounds of the border should be.
	 */
	function getBorderInsets(c:Component, b:IntRectangle):Insets;	
}