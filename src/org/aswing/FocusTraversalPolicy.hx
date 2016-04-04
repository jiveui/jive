/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * A FocusTraversalPolicy defines the order in which Components with a
 * particular focus cycle root are traversed in a Container.
 * <p>
 * The core responsibility of a FocusTraversalPolicy is to provide algorithms
 * determining the next and previous Components to focus when traversing
 * forward or backward in a UI. Each FocusTraversalPolicy must also provide
 * algorithms for determining the default Components in a
 * traversal cycle. The default Component is the first
 * to receive focus when traversing down into a new focus traversal cycle.
 * if the next/previous searched null to be returned, it means can't found a 
 * component to be focused.
 * </p>
 *
 */	
interface FocusTraversalPolicy{
	
    /**
     * Returns the Component that should receive the focus after c.
     *
     * @param c the focus position used to count next
     * @return the Component that should receive the focus after c, or
     *         null if no Component can be found in this policy
     */	
	function getComponentAfter(c:Component):Component;
	
    /**
     * Returns the Component that should receive the focus before c.
     *
     * @param c the focus position used to count previous
     * @return the Component that should receive the focus before c, or
     *         null if no Component can be found in this policy
     */	
	function getComponentBefore(c:Component):Component;
	
    /**
     * Returns the default Component to focus in the specifield container. 
     * This Component will be the first to receive focus when traversing down into 
     * this container.
     * @param container the cirle root container
     * @return the default Component in the container, 
     *         or null if no Component can be found
     */	
	function getDefaultComponent(container:Container):Component;
}