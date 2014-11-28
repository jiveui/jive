/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	/**
 * Dispatched when the viewport's state changed. the state is all about:
 * <ul>
 * <li>view position</li>
 * <li>verticalUnitIncrement</li>
 * <li>verticalBlockIncrement</li>
 * <li>horizontalUnitIncrement</li>
 * <li>horizontalBlockIncrement</li>
 * </ul>
 * </p>
 * 
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * A viewportable object can scrolled by <code>JScrollPane</code>, 
 * <code>JScrollBar</code> to view its viewed content in a visible area.
 * 
 * @see JScrollPane
 * @see JViewport
 * @see JList
 * @see JTextArea
 * 
 * @author paling
 */	
interface Viewportable{

	/**
	 * Returns the unit value for the Vertical scrolling.
	 */
    function getVerticalUnitIncrement():Int;
    
    /**
     * Return the block value for the Vertical scrolling.
     */
    function getVerticalBlockIncrement():Int;
    
	/**
	 * Returns the unit value for the Horizontal scrolling.
	 */
    function getHorizontalUnitIncrement():Int;
    
    /**
     * Return the block value for the Horizontal scrolling.
     */
    function getHorizontalBlockIncrement():Int;    
    
	/**
	 * Sets the unit value for the Vertical scrolling.
	 */
    function setVerticalUnitIncrement(increment:Int):Void;
    
    /**
     * Sets the block value for the Vertical scrolling.
     */
    function setVerticalBlockIncrement(increment:Int):Void;
    
	/**
	 * Sets the unit value for the Horizontal scrolling.
	 */
    function setHorizontalUnitIncrement(increment:Int):Void;
    
    /**
     * Sets the block value for the Horizontal scrolling.
     */
    function setHorizontalBlockIncrement(increment:Int):Void;       
    
    /**
     * Before JScrollPane analyse the scroll properties(call getExtentSize and getViewSize), 
     * it will call this method to set the size of viewport will be to test.
     * 
     * @param s the size to test
     */
    function setViewportTestSize(s:IntDimension):Void;
    
    /**
     * Returns the size of the visible part of the view in view logic coordinates.
     *
     * @return a <code>IntDimension</code> object giving the size of the view
     */
    function getExtentSize():IntDimension;
    
    /**
     * Returns the viewportable view's amount size if view all content in view logic coordinates.
     * Usually the view's preffered size.
     * @return the view's size.
     */
    function getViewSize():IntDimension;
    
    /**
     * Returns the view coordinates that appear in the upper left
     * hand corner of the viewport, or 0,0 if there's no view. in view logic coordinates.
     *
     * @return a <code>IntPoint</code> object giving the upper left coordinates
     */
    function getViewPosition():IntPoint;
    
    /**
     * Sets the view coordinates that appear in the upper left
     * hand corner of the viewport. in view logic coordinates.
     *
     * @param p  a <code>IntPoint</code> object giving the upper left coordinates
     * @param programmatic indicate if this is a programmatic change.
     */
    function setViewPosition(p:IntPoint, programmatic:Bool=true):Void;
    
    /**
     * Scrolls the view so that <code>IntRectangle</code>
     * within the view becomes visible. in view logic coordinates.
     * <p>
     * Note that this method will not scroll outside of the
     * valid viewport; for example, if <code>contentRect</code> is larger
     * than the viewport, scrolling will be confined to the viewport's
     * bounds.
     * @param contentRect the <code>IntRectangle</code> to display
     * @param programmatic indicate if this is a programmatic change.
     */
    function scrollRectToVisible(contentRect:IntRectangle, programmatic:Bool=true):Void;
    
	/**
	 * Add a listener to listen the viewpoat state change event.
	 * <p>
	 * When the viewpoat's state changed, the state is all about:
	 * <ul>
	 * <li>viewPosition
	 * </ul>
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */
	function addStateListener(listener:Dynamic -> Void, priority:Int=0, useWeakReference:Bool=false):Void;

	/**
	 * Removes a state listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */
	function removeStateListener(listener:Dynamic -> Void):Void;
	    
    /**
     * Return the component of the viewportable's pane which would added to displayed on the stage.
     * 
     * @return the component of the viewportable pane.
     */
    function getViewportPane():Component;
}