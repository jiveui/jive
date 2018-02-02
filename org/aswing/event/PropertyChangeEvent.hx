/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;

	
import flash.events.Event;

/**
 * Event for object property changed.
 * @author paling
 */
class PropertyChangeEvent extends AWEvent{
	
	/**
     *  The <code>PropertyChangeEvent.PROPERTY_CHANGE</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>propertyChange</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getPropertyName()</code></td><td>value changed property name</td></tr>
     *     <tr><td><code>getOldValue()</code></td><td>old value</td></tr>
     *     <tr><td><code>getNewValue()</code></td><td>new value</td></tr>
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
     *  @eventType propertyChange
	 */
	inline public static var PROPERTY_CHANGE:String= "propertyChange";	
	
	private var propertyName:String;
	private var oldValue:Dynamic;
	private var newValue:Dynamic;
	
	public function new(propertyName:String, oldValue:Dynamic, newValue:Dynamic){
		super(PROPERTY_CHANGE, false, false);
		this.propertyName = propertyName;
		this.oldValue = oldValue;
		this.newValue = newValue;
	}
	
	public function getPropertyName():String{
		return propertyName;
	}
	
	public function getOldValue():Dynamic{
		return oldValue;
	}
	
	public function getNewValue():Dynamic{
		return newValue;
	}
	
	override public function clone():Event{
		return new PropertyChangeEvent(propertyName, oldValue, newValue);
	}
}