/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.resizer;


import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;

/**
 * The strategy for DefaultResizer to count the new bounds of component would be resized to.
 * @author paling
 */
interface ResizeStrategy{
	
	/**
	 * Count and return the new bounds what the component would be resized to.
	 * @param origBounds the original bounds before resized
	 * @param minSize can be null, means (0, 1)
	 * @param maxSize can be null, means (very big)
	 * @param movedX 
	 * @param movedY 
	 */
	function getBounds(origBounds:IntRectangle, minSize:IntDimension, maxSize:IntDimension, movedX:Int, movedY:Int):IntRectangle;
}