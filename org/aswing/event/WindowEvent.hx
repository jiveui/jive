/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;


import flash.events.Event;

/**
 * The event for window.
 * @see org.aswing.JWindow
 * @author paling
 */
class WindowEvent extends InteractiveEvent{

	/**
     *  The <code>WindowEvent.WINDOW_ACTIVATED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>windowActived</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>isProgrammatic()</code></td><td>True means this event is fired by 
     * 		the programmatic reason, false means user mouse/keyboard interaction reason.</td></tr>
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
     *  @eventType windowActived
	 */
	inline public static var WINDOW_ACTIVATED:String= "windowActived";
	
	/**
     *  The <code>WindowEvent.WINDOW_DEACTIVATED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>windowDeactived</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>isProgrammatic()</code></td><td>True means this event is fired by 
     * 		the programmatic reason, false means user mouse/keyboard interaction reason.</td></tr>
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
     *  @eventType windowDeactived
	 */
	inline public static var WINDOW_DEACTIVATED:String= "windowDeactived";	
		
	public function new(type:String, programmatic:Bool=false){
		super(type, programmatic);
	}
	
	override public function clone():Event{
		return new WindowEvent(type, isProgrammatic());
	}	
}