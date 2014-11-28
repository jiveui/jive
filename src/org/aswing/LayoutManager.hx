/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
import org.aswing.geom.IntDimension;	
	
/** 
 * Defines an interface for classes that know how to layout Containers
 * based on a layout constraints object.
 *
 * @see Component
 * @see Container
 *
 * @author 	paling
 */
interface LayoutManager
{
    /**
     * Adds the specified component to the layout, using the specified
     * constraint object.
     * @param comp the component to be added
     * @param constraints  where/how the component is added to the layout.
     */
    function addLayoutComponent(comp:Component, constraints:Dynamic):Void;

    /**
     * Removes the specified component from the layout.
     * @param comp the component to be removed
     */
    function removeLayoutComponent(comp:Component):Void;

    /**
     * Calculates the preferred size dimensions for the specified 
     * container, given the components it contains.
     * @param target the container to be laid out
     *  
     * @see #minimumLayoutSize
     */
    function preferredLayoutSize(target:Container):IntDimension;

    /** 
     * Calculates the minimum size dimensions for the specified 
     * container, given the components it contains.
     * @param target the component to be laid out
     * @see #preferredLayoutSize
     */
    function minimumLayoutSize(target:Container):IntDimension;

    /** 
     * Calculates the maximum size dimensions for the specified container,
     * given the components it contains.
     * @param target the component to be laid out
     * @see #preferredLayoutSize
     */
    function maximumLayoutSize(target:Container):IntDimension;
    
    /** 
     * Lays out the specified container.
     * @param target the container to be laid out 
     */
    function layoutContainer(target:Container):Void;

    /**
     * Returns the alignment along the x axis.  This specifies how
     * the component would like to be aligned relative to other 
     * components.  The value should be a number between 0 and 1
     * where 0 represents alignment along the origin, 1 is aligned
     * the furthest away from the origin, 0.5 is centered, etc.
     */
    function getLayoutAlignmentX(target:Container):Float;

    /**
     * Returns the alignment along the y axis.  This specifies how
     * the component would like to be aligned relative to other 
     * components.  The value should be a number between 0 and 1
     * where 0 represents alignment along the origin, 1 is aligned
     * the furthest away from the origin, 0.5 is centered, etc.
     */
    function getLayoutAlignmentY(target:Container):Float;

    /**
     * Invalidates the layout, indicating that if the layout manager
     * has cached information it should be discarded.
     */
    function invalidateLayout(target:Container):Void;
}