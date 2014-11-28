/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;

	
import org.aswing.tree.TreePath;
import flash.events.Event;

/**
 * Tree event.
 * @author paling
 */
class TreeEvent extends AWEvent{
	
	/**
     *  The <code>TreeEvent.TREE_EXPANDED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>treeExpanded</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getPath()</code></td><td>the tree path</td></tr>
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
     *  @eventType treeExpanded
	 */
	inline public static var TREE_EXPANDED:String= "treeExpanded";

	/**
     *  The <code>TreeEvent.TREE_COLLAPSED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>treeCollapsed</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getPath()</code></td><td>the tree path</td></tr>
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
     *  @eventType treeCollapsed
	 */
	inline public static var TREE_COLLAPSED:String= "treeCollapsed";
	
	/**
     *  The <code>TreeEvent.TREE_WILL_EXPAND</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>treeWillExpand</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getPath()</code></td><td>the tree path</td></tr>
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
     *  @eventType treeWillExpand
	 */
	inline public static var TREE_WILL_EXPAND:String= "treeWillExpand";
	
	/**
     *  The <code>TreeEvent.TREE_WILL_COLLAPSE</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>treeWillCollapse</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getPath()</code></td><td>the tree path</td></tr>
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
     *  @eventType treeWillCollapse
	 */
	inline public static var TREE_WILL_COLLAPSE:String= "treeWillCollapse";	
	
	private var path:TreePath;
	
	public function new(type:String, path:TreePath){
		super(type, false, false);
		this.path = path;
	}
	
	/**
	 * Returns a TreePath object identifying the newly expanded/collapsed node.
	 * @return a TreePath object identifying the newly expanded/collapsed node.
	 */
	public function getPath():TreePath{
		return path;
	}
	
	override public function clone():Event{
		return new TreeEvent(type, path);
	}
	
}