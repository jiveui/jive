/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;

	
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * Event for display object release and release outside.
 * <p>
 * Generally, if you need the target, you may need the <code>pressTarget</code> 
 * indeed. The <code>pressTarget</code> property is the target of which object was 
 * pressed and then released.
 * The <code>target</code> property is the object which was released, but maybe it 
 * is not pressed, i mean, its child was press, not itself. So, use <code>getPressTarget()</code> 
 * to get the right target.
 * </p>
 * @author paling
 */
class ReleaseEvent extends MouseEvent{
	
	/**
     *  The <code>ReleaseEvent.RELEASE</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>release</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getPressTarget()</code></td><td>The object that 
     * 		is the target which is pressed and then released</td></tr>
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
     *  @eventType release
	 */
	inline public static var RELEASE:String= "release";	
	
	/**
     *  The <code>ReleaseEvent.RELEASE_OUT_SIDE</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>releaseOutSide</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getPressTarget()</code></td><td>The object that 
     * 		is the target which is pressed and then released out side</td></tr>
     *     <tr><td><code>isReleasedOutSide()</code></td><td>true if this is released out side</td></tr>
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
     *  @eventType releaseOutSide
	 */
	inline public static var RELEASE_OUT_SIDE:String= "releaseOutSide";		
	
	private var pressTarget:DisplayObject;
	private var releasedOutSide:Bool;
	
	public function new(type:String, pressTarget:DisplayObject, releasedOutSide:Bool, e:MouseEvent){
		super(type, false, false, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown);
		this.pressTarget = pressTarget;
		this.releasedOutSide = releasedOutSide;
	}
	
	/**
	 * Returns the target for of the press phase.
	 * @return the press target
	 */
	public function getPressTarget():DisplayObject{
		return pressTarget;
	}
	
	/**
	 * Returns whether or not this release is acted out side of the pressed display object.
	 * @return true if out side or false not.
	 */
	public function isReleasedOutSide():Bool{
		return releasedOutSide;
	}
	
	override public function clone():Event{
		return new ReleaseEvent(type, getPressTarget(), isReleasedOutSide(), this);
	}
	
}