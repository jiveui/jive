/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;

	
import flash.events.KeyboardEvent;
import flash.events.Event; 

class FocusKeyEvent extends KeyboardEvent{

	/**
     *  The <code>FocusKeyEvent.FOCUS_KEY_DOWN</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>focusKeyDown</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>charCode</code></td><td>The character code value of the key pressed or released.</td></tr>
     *     <tr><td><code>keyCode</code></td><td>The key code value of the key pressed or released.</td></tr>
     *     <tr><td><code>keyLocation</code></td><td>The location of the key on the AWKeyboard.</td></tr>
     *     <tr><td><code>ctrlKey</code></td><td>true if the Control key is active; false if it is inactive.</td></tr>
     *     <tr><td><code>altKey</code></td><td>false, reserved</td></tr>
     *     <tr><td><code>shiftKey</code></td><td>true if the Shift key is active; false if it is inactive.</td></tr>
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
     *  @eventType focusKeyDown
	 */	 
	inline public static var FOCUS_KEY_DOWN:String= "focusKeyDown";

	/**
     *  The <code>FocusKeyEvent.FOCUS_KEY_UP</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>focusKeyUp</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>charCode</code></td><td>The character code value of the key pressed or released.</td></tr>
     *     <tr><td><code>keyCode</code></td><td>The key code value of the key pressed or released.</td></tr>
     *     <tr><td><code>keyLocation</code></td><td>The location of the key on the AWKeyboard.</td></tr>
     *     <tr><td><code>ctrlKey</code></td><td>true if the Control key is active; false if it is inactive.</td></tr>
     *     <tr><td><code>altKey</code></td><td>false, reserved</td></tr>
     *     <tr><td><code>shiftKey</code></td><td>true if the Shift key is active; false if it is inactive.</td></tr>
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
     *  @eventType focusKeyUp
	 */	 	 
	inline public static var FOCUS_KEY_UP:String= "focusKeyUp";		
 
	public function new(type:String, ?charCode:Int=0, ?keyCode:Int=0, ?keyLocation:Dynamic, ?ctrlKey:Bool=false, ?altKey:Bool=false, ?shiftKey:Bool=false){
	
		
		
		super(type, false, false, charCode, keyCode, keyLocation, ctrlKey, altKey, shiftKey);
		 
	 }
	
	override public function clone():Event{
		return new FocusKeyEvent(type, charCode, keyCode, keyLocation, ctrlKey, altKey, shiftKey);
	}
	
}