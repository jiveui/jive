/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

	
/**
 * Any component that can be placed into a menu should implement this interface.
 * This interface is used by <code>MenuSelectionManager</code>
 * to handle selection and navigation in menu hierarchies.
 * 
 * @author paling
 */
interface MenuElement{
	
	/**
     * Call by the <code>MenuSelectionManager</code> when the
     * <code>MenuElement</code> is added or remove from 
     * the menu selection.
     */
    function menuSelectionChanged(isIncluded:Bool):Void;

    /**
     * This method should return an array containing the sub-elements for the receiving menu element
     *
     * @return an array of MenuElements
     */
    function getSubElements():Array<Dynamic>; //MenuElement[]
    
    /**
     * Precess the selection when key typed. 
     */
    function processKeyEvent(code:Int):Void;
    
    /**
     * Sets whether the menu element is in use.
     */
    function setInUse(b:Bool):Void;
    
    /**
     * Returns whether the menu element is in use or not.
     */
    function isInUse():Bool;
    
    /**
     * This method should return the Component used to paint the receiving element.
     * The returned component will be used to convert events and detect if an event is inside
     * a MenuElement's component.
     *
     * @return the Component value
     */
    function getMenuComponent():Component;	
}