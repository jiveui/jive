/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;

import flash.events.Event;
	
/**
 * The event for <code>JAttachPane</code>.
 * @see org.aswing.JAttachPane
 * @author paling
 */	
class AttachEvent extends AWEvent
{
	/**
     *  The <code>AttachEvent.ATTACHED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>attached</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
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
     *  @eventType attached
	 */
	inline public static var ATTACHED:String= "attached";
	
	public function new(type:String){
		super(type, false, false);
	}

	override public function clone():Event{
		return new AttachEvent(type);
	}	
}