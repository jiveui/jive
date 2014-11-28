/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;


import flash.events.Event;

/**
 * The event for list and table selection change.
 * @see org.aswing.JList
 * @see org.aswing.JTable
 * @see org.aswing.ListSelectionModel
 * @author paling
 */
class SelectionEvent extends InteractiveEvent{
		
	/**
     *  The <code>SelectionEvent.LIST_SELECTION_CHANGED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>listSelectionChanged</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>isProgrammatic()</code></td><td>True means this event is fired by 
     * 		the programmatic reason, false means user mouse/keyboard interaction reason.</td></tr>
     *     <tr><td><code>getFirstIndex()</code></td><td>the first changed index.</td></tr>
     *     <tr><td><code>getLastIndex()</code></td><td>the last changed index.</td></tr>
     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *       event listener that handles the event. For example, if you use
     *       <code>comp.addEventListener()</code> to register an event listener,
     *       comp is the value of the <code>currentTarget</code>. </td></tr>
     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *       it is not always the Object listening for the event.
     *       Use the <code>currentTarget</code> property to always access the
     *       Object listening for the event.</td></tr>
     *  </table>
     *
     *  @eventType listSelectionChanged
	 */
	inline public static var LIST_SELECTION_CHANGED:String= "listSelectionChanged";
	
	/**
     *  The <code>SelectionEvent.ROW_SELECTION_CHANGED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>rowSelectionChanged</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>isProgrammatic()</code></td><td>True means this event is fired by 
     * 		the programmatic reason, false means user mouse/keyboard interaction reason.</td></tr>
     *     <tr><td><code>getFirstIndex()</code></td><td>the first changed index.</td></tr>
     *     <tr><td><code>getLastIndex()</code></td><td>the last changed index.</td></tr>
     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *       event listener that handles the event. For example, if you use
     *       <code>comp.addEventListener()</code> to register an event listener,
     *       comp is the value of the <code>currentTarget</code>. </td></tr>
     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *       it is not always the Object listening for the event.
     *       Use the <code>currentTarget</code> property to always access the
     *       Object listening for the event.</td></tr>
     *  </table>
     *
     *  @eventType rowSelectionChanged
	 */
	inline public static var ROW_SELECTION_CHANGED:String= "rowSelectionChanged";	
	
	/**
     *  The <code>SelectionEvent.COLUMN_SELECTION_CHANGED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>listSelectionChanged</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>isProgrammatic()</code></td><td>True means this event is fired by 
     * 		the programmatic reason, false means user mouse/keyboard interaction reason.</td></tr>
     *     <tr><td><code>getFirstIndex()</code></td><td>the first changed index.</td></tr>
     *     <tr><td><code>getLastIndex()</code></td><td>the last changed index.</td></tr>
     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *       event listener that handles the event. For example, if you use
     *       <code>comp.addEventListener()</code> to register an event listener,
     *       comp is the value of the <code>currentTarget</code>. </td></tr>
     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *       it is not always the Object listening for the event.
     *       Use the <code>currentTarget</code> property to always access the
     *       Object listening for the event.</td></tr>
     *  </table>
     *
     *  @eventType columnSelectionChanged
	 */
	inline public static var COLUMN_SELECTION_CHANGED:String= "columnSelectionChanged";	
			
	private var firstIndex:Int;
	private var lastIndex:Int;
	
	public function new(type:String, firstIndex:Int, lastIndex:Int, programmatic:Bool){
		super(type, programmatic);
		this.firstIndex = firstIndex;
		this.lastIndex = lastIndex;
	}
	
	/**
	 * Returns the first changed index(the begin).
	 * @returns the first changed index.
	 */
	public function getFirstIndex():Int{
		return firstIndex;
	}
	
	/**
	 * Returns the last changed index(the end).
	 * @returns the last changed index.
	 */
	public function getLastIndex():Int{
		return lastIndex;
	}
	
	override public function clone():Event{
		return new SelectionEvent(type, firstIndex, lastIndex, isProgrammatic());
	}
}