/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;


import org.aswing.geom.IntDimension;
import flash.events.Event;

/**
 * The event for component resized.
 * @author paling
 */
class ResizedEvent extends AWEvent
{
	
	/**
     *  The <code>ResizedEvent.RESIZED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>resized</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getOldSize()</code></td><td>the old size</td></tr>
     *     <tr><td><code>getNewSize()</code></td><td>the new size</td></tr>
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
     *  @eventType resized
	 */
	inline public static var RESIZED:String= "resized";		
		
	private var oldSize:IntDimension;
	private var newSize:IntDimension;
	
	public function new(oldSize:IntDimension, newSize:IntDimension)
	{
		super(RESIZED, false, false);
		this.oldSize = oldSize.clone();
		this.newSize = newSize.clone();
	}
	
	override public function clone():Event{
		return new ResizedEvent(oldSize, newSize);
	}
	
	public function getOldSize():IntDimension{
		return oldSize.clone();
	}
	
	public function getNewSize():IntDimension{
		return newSize.clone();
	}
}