/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;


import flash.events.Event;

/**
 * The event for <code>JPopup</code>.
 * @see org.aswing.JPopup
 * @author paling
 */
class PopupEvent extends AWEvent{
	
	/**
     *  The <code>PopupEvent.POPUP_OPENED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>popupOpened</code> event.
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
     *  @eventType popupOpened
	 */
	inline public static var POPUP_OPENED:String= "popupOpened";
	
	/**
     *  The <code>PopupEvent.POPUP_CLOSED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>popupClosed</code> event.
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
     *  @eventType popupClosed
	 */
	inline public static var POPUP_CLOSED:String= "popupClosed";	
		
	public function new(type:String){
		super(type, false, false);
	}

	override public function clone():Event{
		return new PopupEvent(type);
	}	
}