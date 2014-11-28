/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;

	
import flash.events.Event;
import org.aswing.Container;
import org.aswing.Component;
	

/**
 * The Event class is used to Container events. 
 * @author paling
 */
class ContainerEvent extends AWEvent
{	
	/**
     *  The <code>AWEvent.COM_ADDED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>comAdded</code> event.
     *
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
     *  @eventType comAdded
	 */
	inline public static var COM_ADDED:String= "comAdded";
	
	/**
     *  The <code>AWEvent.COM_REMOVED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>comRemoved</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getContainer()</code></td><td>the container who just be removed a child.</td></tr>
     *     <tr><td><code>getChild()</code></td><td>the removed child.</td></tr>
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
     *  @eventType comRemoved
	 */
	inline public static var COM_REMOVED:String= "comRemoved";	
	
	private var container:Container;
	private var child:Component;
	
	/**
	 * Create an Container Event.
	 */
	public function new(type:String, container:Container, child:Component){
		super(type, false, false);
		this.container = container;
		this.child = child;
	}
	
	override public function clone():Event{
		//TODO:check if need this; return new ContainerEvent(type, container, child, bubbles, cancelable);
		return new ContainerEvent(type, container, child);
	}
	
	/**
	 * Returns the container whos component child was just removed.
	 */
	public function getContainer():Container{
		return container;
	}
	
	/**
	 * Returns the child component was just removed from its parent container.
	 */
	public function getChild():Component{
		return child;
	}
}