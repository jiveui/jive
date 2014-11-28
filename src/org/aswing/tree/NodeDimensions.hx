/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

import org.aswing.geom.IntRectangle;

/**
 * Used by <code>AbstractLayoutCache</code> to determine the size
 * and x origin of a particular node.
 * @author paling
 */
interface NodeDimensions {
	/**
	 * Returns, by reference in bounds, the size and x origin to
	 * place value at. The calling method is responsible for determining
	 * the Y location. If bounds is <code>null</code>, a newly created
	 * <code>IntRectangle</code> should be returned,
	 * otherwise the value should be placed in bounds and returned.
	 *
	 * @param value the <code>value</code> to be represented
	 * @param row row being queried
  	 * @param depth the depth of the row
	 * @param expanded true if row is expanded, false otherwise
	 * @param bounds  a <code>IntRectangle</code> containing the size needed
	 *		to represent <code>value</code>
   	 * @return a <code>IntRectangle</code> containing the node dimensions,
	 * 		or <code>null</code> if node has no dimension
	 */
	function countNodeDimensions(value:Dynamic, row:Int, depth:Int, expanded:Bool, bounds:IntRectangle):IntRectangle;
}