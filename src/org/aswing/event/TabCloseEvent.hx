package org.aswing.event;

	import flash.events.Event;
	

/**
 * The event for JClosableTabbedPane tab close button clicked.
 * @author paling
 */
class TabCloseEvent extends AWEvent{

	/**
     *  The <code>TabCloseEvent.TAB_CLOSING</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>tabClosing</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getIndex()</code></td><td>the tab index</td></tr>
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
     *  @eventType tabClosing
	 */
	inline public static var TAB_CLOSING:String= "tabClosing";
	
	private var index:Int;
	
	public function new(index:Int){
		super(TAB_CLOSING, false, false);
		this.index = index;
	}
	
	/**
	 * Return the index of tab that close button clicked.
	 */
	public function getIndex():Int{
		return index;
	}
	
	override public function clone():Event{
		return new TabCloseEvent(index);
	}
}