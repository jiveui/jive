/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;


import flash.events.Event;
import org.aswing.geom.IntPoint;

/**
 * The event for component moved.
 * @author paling
 */
class MovedEvent extends AWEvent
{

	/**
     *  The <code>MovedEvent.MOVED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>moved</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getOldLocation()</code></td><td>the old location</td></tr>
     *     <tr><td><code>getNewLocation()</code></td><td>the new location</td></tr>
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
     *  @eventType moved
	 */
	inline public static var MOVED:String= "moved";
		
	private var oldPos:IntPoint;
	private var newPos:IntPoint;
	
	public function new(oldPos:IntPoint, newPos:IntPoint){
		super(MOVED, false, false);
		this.oldPos = oldPos.clone();
		this.newPos = newPos.clone();
	}
	
	override public function clone():Event{
		return new MovedEvent(oldPos, newPos);
	}
	
	public function getOldLocation():IntPoint{
		return oldPos.clone();
	}
	
	public function getNewLocation():IntPoint{
		return newPos.clone();
	}
}