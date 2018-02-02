/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;


import org.aswing.Component;
import org.aswing.dnd.SourceData;
	import org.aswing.geom.IntPoint;
import flash.events.Event;

class DragAndDropEvent extends AWEvent{
	
	/**
     *  The <code>DragAndDropEvent.DRAG_RECOGNIZED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>dragRecongnized</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getDragInitiator()</code></td><td>the drag initiator component</td></tr>
     *     <tr><td><code>getMousePosition()</code></td><td>the mouse point in stage scope</td></tr>
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
     *  @eventType dragRecongnized
	 */
	inline public static var DRAG_RECOGNIZED:String= "dragRecognized";	
	
	/**
     *  The <code>DragAndDropEvent.DRAG_START</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>dragStart</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getDragInitiator()</code></td><td>the drag initiator component</td></tr>
     *     <tr><td><code>getSourceData()</code></td><td>the drag source data</td></tr>
     *     <tr><td><code>getMousePosition()</code></td><td>the mouse point in stage scope</td></tr>
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
     *  @eventType dragStart
	 */
	inline public static var DRAG_START:String= "dragStart";	

	/**
     *  The <code>DragAndDropEvent.DRAG_ENTER</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>dragEnter</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getDragInitiator()</code></td><td>the drag initiator component</td></tr>
     *     <tr><td><code>getSourceData()</code></td><td>the drag source data</td></tr>
     *     <tr><td><code>getMousePosition()</code></td><td>the mouse point in stage scope</td></tr>
     *     <tr><td><code>getTargetComponent()</code></td><td>the mouse entered target component</td></tr>
     *     <tr><td><code>getRelatedTargetComponent()</code></td><td>the previouse entered 
     * 		target component</td></tr>
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
     *  @eventType dragEnter
	 */
	inline public static var DRAG_ENTER:String= "dragEnter";	
		
	/**
     *  The <code>DragAndDropEvent.DRAG_OVERRING</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>dragOverring</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getDragInitiator()</code></td><td>the drag initiator component</td></tr>
     *     <tr><td><code>getSourceData()</code></td><td>the drag source data</td></tr>
     *     <tr><td><code>getMousePosition()</code></td><td>the mouse point in stage scope</td></tr>
     *     <tr><td><code>getTargetComponent()</code></td><td>the mouse entered target component</td></tr>
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
     *  @eventType dragOverring
	 */
	inline public static var DRAG_OVERRING:String= "dragOverring";	
	
	/**
     *  The <code>DragAndDropEvent.DRAG_EXIT</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>dragExit</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getDragInitiator()</code></td><td>the drag initiator component</td></tr>
     *     <tr><td><code>getSourceData()</code></td><td>the drag source data</td></tr>
     *     <tr><td><code>getMousePosition()</code></td><td>the mouse point in stage scope</td></tr>
     *     <tr><td><code>getTargetComponent()</code></td><td>the mouse entered target component</td></tr>
     *     <tr><td><code>getRelatedTargetComponent()</code></td><td>the next being entered 
     * 		target component</td></tr>
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
     *  @eventType dragExit
	 */
	inline public static var DRAG_EXIT:String= "dragExit";	
	
	/**
     *  The <code>DragAndDropEvent.DRAG_DROP</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>dragDrop</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getDragInitiator()</code></td><td>the drag initiator component</td></tr>
     *     <tr><td><code>getSourceData()</code></td><td>the drag source data</td></tr>
     *     <tr><td><code>getMousePosition()</code></td><td>the mouse point in stage scope</td></tr>
     *     <tr><td><code>getTargetComponent()</code></td><td>the mouse entered target component</td></tr>
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
     *  @eventType dragDrop
	 */
	inline public static var DRAG_DROP:String= "dragDrop";		
	
	private var dragInitiator:Component;
	private var sourceData:SourceData;
	private var mousePos:IntPoint;
	private var targetComponent:Component;
	private var relatedTargetComponent:Component;
	
	/**
	 * Create a drag and drop event.
	 * @param type the type.
	 * @param dragInitiator the drag initiator component.
	 * @param dragSource the data source.
	 * @param mousePos a <code>IntPoint</code> indicating the cursor location in global space.
	 * @param targetComponent the mouse entered component.
	 * @param relatedTargetComponent the related target component.
	 */
	public function new(type:String, 
		dragInitiator:Component, sourceData:SourceData, mousePos:IntPoint, 
		?targetComponent:Component=null, ?relatedTargetComponent:Component=null){
		super(type, false, false);
		this.dragInitiator = dragInitiator;
		this.sourceData = sourceData;
		this.mousePos = mousePos.clone();
		this.targetComponent = targetComponent;
		this.relatedTargetComponent = relatedTargetComponent;
	}
	
	override public function clone():Event{
		return new DragAndDropEvent(type, dragInitiator, sourceData, mousePos, targetComponent);
	}
	
	/**
	 * Returns the drag initiator component.
	 */
	public function getDragInitiator():Component{
		return dragInitiator;
	}
	/**
	 * Returns the data source.
	 * <p>
	 * For <code>DRAG_RECOGNIZED</code> events this property is null.
	 * </p>
	 */
	public function getSourceData():SourceData{
		return sourceData;
	}
	/**
	 * Returns a <code>IntPoint</code> indicating the cursor location in global space.
	 */
	public function getMousePosition():IntPoint{
		return mousePos;
	}
	/**
	 * Returns the mouse entered component. 
	 * <p>
	 * For <code>DRAG_START</code> and <code>DRAG_RECOGNIZED</code> events this property is always null.
	 * </p>
	 */
	public function getTargetComponent():Component{
		return targetComponent;
	}
	/**
	 * Returns the related mouse entered component. For <code>DRAG_ENTER</code> event, 
	 * it is the previous target component, for <code>DRAG_EXIT</code> it is the next being entered 
	 * target component.
	 * <p>
	 * For <code>DRAG_START</code>, <code>DRAG_RECOGNIZED</code>, 
	 * <code>DRAG_OVERRING</code>, <code>DRAG_DROP</code> events this property is always null.
	 * </p>
	 */
	public function getRelatedTargetComponent():Component{
		return relatedTargetComponent;
	}
}