/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import flash.events.IEventDispatcher;

/**
 * A model that supports at most one indexed selection.
 * @author paling
 */
interface SingleSelectionModel
{
	
    /**
     * Returns the model's selection.
     *
     * @return  the model's selection, or -1 if there is no selection
     * @see     #setSelectedIndex()
     */
    function getSelectedIndex():Int;

    /**
     * Sets the model's selected index to <I>index</I>.
     *
     * Notifies any listeners if the model changes.
     *
     * @param index an int specifying the model selection.
     * @param programmatic indicate if this is a programmatic change.
     * @see   #getSelectedIndex()
     * @see   #addChangeListener()
     */
    function setSelectedIndex(index:Int, programmatic:Bool=true):Void;

    /**
     * Clears the selection (to -1).
     * @param programmatic indicate if this is a programmatic change.
     */
    function clearSelection(programmatic:Bool=true):Void;

    /**
     * Returns true if the selection model currently has a selected value.
     * @return true if a value is currently selected
     */
    function isSelected():Bool;

	/**
	 * Adds a listener to listen the Model's state change event.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */
	function addStateListener(listener:Dynamic -> Void, priority:Int = 0, useWeakReference:Bool = false):Void;
	/**
	 * Removes a state listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.InteractiveEvent#STATE_CHANGED
	 */	
	 function removeStateListener(listener:Dynamic -> Void):Void;
}