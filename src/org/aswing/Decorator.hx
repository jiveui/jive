/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.display.DisplayObject;

/**
 * Decorator for components, it return a display object to be the UI decorator.
 */
interface Decorator
{
	/**
	 * Returns the display object which is used as the component decorator.
	 * <p>
	 * For same component, this method must return same display object.
	 * </p>
	 * @param c the component which will use this decorator.
	 * @return the display object
	 */
	function getDisplay(c:Component):DisplayObject;
	
}