/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * This interface represents the current state of the 
 * selection for any of the components that display a 
 * list of values with stable indices.  The selection is 
 * modeled as a set of intervals, each interval represents
 * a contiguous range of selected list elements.
 * The methods for modifying the set of selected intervals
 * all take a pair of indices, index0 and index1, that represent
 * a closed interval, i.e. the interval includes both index0 and
 * index1.
 * 
 * @see org.aswing.DefaultListSelectionModel
 * @author paling
 */
interface ListSelectionModel{

	/** 
     * Change the selection to be between index0 and index1 inclusive.
     * If this represents a change to the current selection, then
     * notify each ListSelectionListener. Note that index0 doesn't have
     * to be less than or equal to index1.  
     * 
     * @param index0 one end of the interval.
     * @param index1 other end of the interval.
     * @param programmatic indicate if this is a programmatic change.
     * @see #addListSelectionListener()
     */	
	function setSelectionInterval(index0:Int, index1:Int, programmatic:Bool=true):Void;
	
    /** 
     * Change the selection to be the set union of the current selection
     * and the indices between index0 and index1 inclusive.  If this represents 
     * a change to the current selection, then notify each 
     * ListSelectionListener. Note that index0 doesn't have to be less
     * than or equal to index1.  
     * 
     * @param index0 one end of the interval.
     * @param index1 other end of the interval.
     * @param programmatic indicate if this is a programmatic change.
     * @see #addListSelectionListener()
     */	
	function addSelectionInterval(index0:Int, index1:Int, programmatic:Bool=true):Void;

    /** 
     * Change the selection to be the set difference of the current selection
     * and the indices between index0 and index1 inclusive.  If this represents 
     * a change to the current selection, then notify each 
     * ListSelectionListener.  Note that index0 doesn't have to be less
     * than or equal to index1.  
     * 
     * @param index0 one end of the interval.
     * @param index1 other end of the interval.
     * @param programmatic indicate if this is a programmatic change.
     * @see #addListSelectionListener()
     */	
	function removeSelectionInterval(index0:Int, index1:Int, programmatic:Bool=true):Void;

    /**
     * Returns the first selected index or -1 if the selection is empty.
     */	
	function getMinSelectionIndex():Int;

    /**
     * Returns the last selected index or -1 if the selection is empty.
     */	
	function getMaxSelectionIndex():Int;

    /** 
     * Returns true if the specified index is selected.
     */	
	function isSelectedIndex(index:Int):Bool;

    /**
     * Return the first index argument from the most recent call to 
     * setSelectionInterval(), addSelectionInterval() or removeSelectionInterval().
     * The most recent index0 is considered the "anchor" and the most recent
     * index1 is considered the "lead".  Some interfaces display these
     * indices specially, e.g. Windows95 displays the lead index with a 
     * dotted yellow outline.
     * 
     * @see #getLeadSelectionIndex()
     * @see #setSelectionInterval()
     * @see #addSelectionInterval()
     */	
	function getAnchorSelectionIndex():Int;
 
    /**
     * Set the anchor selection index. 
     * 
     * @see #getAnchorSelectionIndex()
     */	
	function setAnchorSelectionIndex(index:Int):Void;	

    /**
     * Return the second index argument from the most recent call to 
     * setSelectionInterval(), addSelectionInterval() or removeSelectionInterval().
     * 
     * @see #getAnchorSelectionIndex()
     * @see #setSelectionInterval()
     * @see #addSelectionInterval()
     */
	function getLeadSelectionIndex():Int;

    /**
     * Set the lead selection index. 
     * 
     * @see #getLeadSelectionIndex()
     */
	function setLeadSelectionIndex(index:Int):Void;

    /**
     * Change the selection to the empty set.  If this represents
     * a change to the current selection then notify each ListSelectionListener.
     * 
     * @param programmatic indicate if this is a programmatic change.
     * @see #addListSelectionListener()
     */
	function clearSelection(programmatic:Bool=true):Void;	

    /**
     * Returns true if no indices are selected.
     */
	function isSelectionEmpty():Bool;
 
    /** 
     * Insert length indices beginning before/after index.  This is typically 
     * called to sync the selection model with a corresponding change
     * in the data model.
     * @param index the index.
     * @param length the length.
     * @param before whether before or after.
     * @param programmatic indicate if this is a programmatic change.
     */
    function insertIndexInterval(index:Int, length:Int, before:Bool, programmatic:Bool=true):Void;

    /** 
     * Remove the indices in the interval index0,index1 (inclusive) from
     * the selection model.  This is typically called to sync the selection
     * model width a corresponding change in the data model.
     * @param index the first index.
     * @param length the second index.
     * @param programmatic indicate if this is a programmatic change.
     */
    function removeIndexInterval(index0:Int, index1:Int, programmatic:Bool=true):Void;
 
    /**
     * Set the selection mode. The following selectionMode values are allowed:
     * <ul>
     * <li> <code>SINGLE_SELECTION</code> 
     *   Only one list index can be selected at a time.  In this
     *   mode the setSelectionInterval and addSelectionInterval 
     *   methods are equivalent, and only the second index
     *   argument (the "lead index") is used.</li>
     * <li> <code>MULTIPLE_SELECTION</code> 
     *   In this mode, there's no restriction on what can be selected.</li>
     * </ul>
     * 
     * @see #getSelectionMode()
     */
	function setSelectionMode(selectionMode:Int):Void;

    /**
     * Returns the current selection mode.
     * @return The value of the selectionMode property.
     * @see #setSelectionMode()
     */
	function getSelectionMode():Int;

    /**
     * Add a listener to the list that's notified each time a change
     * to the selection occurs.
     * @param listener the listener to be add.
     */  
	function addListSelectionListener(listener:Dynamic -> Void):Void;
	
	/**
	 * Removes a listener from the list selection listeners.
	 * @param listener the listener to be removed.
	 */
	function removeListSelectionListener(listener:Dynamic -> Void):Void;
	
}