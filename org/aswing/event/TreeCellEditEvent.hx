/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;


import org.aswing.tree.TreePath;
import flash.events.Event;

/**
 * The event for tree cell editing.
 * @author paling
 */
class TreeCellEditEvent extends AWEvent{

	/**
     *  The <code>TreeCellEditEvent.EDITING_STARTED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>treeCellEditingStarted</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getPath()</code></td><td>the path be edit</td></tr>
     *     <tr><td><code>getOldValue()</code></td><td>the old value</td></tr>
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
     *  @eventType treeCellEditingStarted
	 */
	inline public static var EDITING_STARTED:String= "treeCellEditingStarted";	
	
	/**
     *  The <code>TreeCellEditEvent.EDITING_CANCELED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>treeCellEditingCanceled</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getPath()</code></td><td>the path be edit</td></tr>
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
     *  @eventType treeCellEditingCanceled
	 */
	inline public static var EDITING_CANCELED:String= "treeCellEditingCanceled";
	
	/**
     *  The <code>TreeCellEditEvent.EDITING_STOPPED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>treeCellEditingStopped</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getPath()</code></td><td>the path be edit</td></tr>
     *     <tr><td><code>getOldValue()</code></td><td>the old value</td></tr>
     *     <tr><td><code>getNewValue()</code></td><td>the new value edited</td></tr>
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
     *  @eventType treeCellEditingStopped
	 */
	inline public static var EDITING_STOPPED:String= "treeCellEditingStopped";
	
	private var path:TreePath;
	private var oldValue:Dynamic;
	private var newValue:Dynamic;
		
	public function new(type:String, path:TreePath, oldValue:Dynamic=null, newValue:Dynamic=null){
		super(type, bubbles, cancelable);
		this.oldValue = oldValue;
		this.newValue = newValue;
	}
		
	public function getPath():TreePath{
		return path;
	}
	
	public function getOldValue():Dynamic{
		return oldValue;
	}
	
	public function getNewValue():Dynamic{
		return newValue;
	}
	
	override public function clone():Event{
		return new TreeCellEditEvent(type, path, oldValue, newValue);
	}
}