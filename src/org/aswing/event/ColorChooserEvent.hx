/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;

import flash.events.Event;

import org.aswing.ASColor;
class ColorChooserEvent extends AWEvent
{
	/**
     *  The <code>ColorChooserEvent.COLOR_ADJUSTING</code> When user adjusting to a new color.
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getContainer()</code></td><td>the container who just be added a child.</td></tr>
     *     <tr><td><code>getChild()</code></td><td>the added child.</td></tr>
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
     *  @eventType colorAdjusting
	 */
	inline public static var COLOR_ADJUSTING:String= "colorAdjusting";
	private var color:ASColor;
	
	public function new(type:String, color:ASColor){
		this.color = color;
		super(type, false, false);
	}
	
	public function getColor():ASColor{
		return color;
	}
	
	override public function clone():Event{
		return new ColorChooserEvent(type, color);
	}	
}