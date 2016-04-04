/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;
 

import org.aswing.error.Error;
import org.aswing.tree.TreePath;
import flash.events.Event;

/**
 * An event that characterizes a change in the current
 * selection.  The change is based on any number of paths.
 * TreeSelectionListeners will generally query the source of
 * the event for the new selected status of each potentially
 * changed row.
 * 
 * @author paling
 */
class TreeSelectionEvent extends InteractiveEvent{

	/**
     *  The <code>TreeSelectionEvent.TREE_SELECTION_CHANGED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>treeSelectionChanged</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>isProgrammatic()</code></td><td>True means this event is fired by 
     * 		the programmatic reason, false means user mouse/keyboard interaction reason.</td></tr>
     *     <tr><td><code>getPaths()</code></td><td>changed paths.</td></tr>
     *     <tr><td><code>getPath()</code></td><td>first path.</td></tr>
     *     <tr><td><code>isAddedPath()</code></td><td>is the first path element has been added to the selection.</td></tr>
     *     <tr><td><code>isAddedPathOfPath()</code></td><td>is path is added.</td></tr>
     *     <tr><td><code>isAddedPathOfIndex()</code></td><td>is path specified by index is added.</td></tr>
     *     <tr><td><code>getOldLeadSelectionPath()</code></td><td>previously the lead path.</td></tr>
     *     <tr><td><code>getNewLeadSelectionPath()</code></td><td>current lead path.</td></tr>
     *     <tr><td><code>cloneWithSource()</code></td><td>clone with source.</td></tr>
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
     *  @eventType treeSelectionChanged
	 */
	inline public static var TREE_SELECTION_CHANGED:String= "treeSelectionChanged";		
	
	/** the source object*/
	private var source:Dynamic;
    /** Paths this event represents. */
    private var paths:Array<Dynamic>;
    /** For each path identifies if that is path is in fact new. */
    private var areNew:Array<Dynamic>; //boolean[]
    /** leadSelectionPath before the paths changed, may be null. */
    private var oldLeadSelectionPath:TreePath;
    /** leadSelectionPath after the paths changed, may be null. */
    private var newLeadSelectionPath:TreePath;

    /**
      * Represents a change in the selection of a TreeSelectionModel.
      * paths identifies the paths that have been either added or
      * removed from the selection.
      *
      * @param source source of event
      * @param paths the paths that have changed in the selection
      */
    public function new(source:Dynamic, programmatic:Bool,
    			 paths:Array<Dynamic>, areNew:Array<Dynamic>, oldLeadSelectionPath:TreePath,
			     newLeadSelectionPath:TreePath)
    {
		super(TREE_SELECTION_CHANGED, programmatic);
		this.source = source;
		this.paths = paths;
		this.areNew = areNew;
		this.oldLeadSelectionPath = oldLeadSelectionPath;
		this.newLeadSelectionPath = newLeadSelectionPath;
    }
	
	/**
	 * Returns the source.
	 */
	public function getSource():Dynamic{
		return source;
	}
	
    /**
      * Returns the paths(TreePath[]) that have been added or removed from the
      * selection.
      */
    public function getPaths():Array<Dynamic>{
		return paths.copy();
    }

    /**
      * Returns the first path element.
      */
    public function getPath():TreePath{
		return paths[0];
    }

    /**
     * Returns true if the first path element has been added to the
     * selection, a return value of false means the first path has been
     * removed from the selection.
     * @see #isAddedPathOfPath()
     * @see #isAddedPathOfIndex()
     */
    public function isAddedPath():Bool{
		return areNew[0] == true;
    }

    /**
     * Returns true if the path identified by path was added to the
     * selection. A return value of false means the path was in the
     * selection but is no longer in the selection. This will raise if
     * path is not one of the paths identified by this event.
     */
    public function isAddedPathOfPath(path:TreePath):Bool{
		for(counter in 0...paths.length  ){
		    if(paths[counter].equals(path)){
				return areNew[counter]==true;
		    }
		}
		throw new Error("path is not a path identified by the TreeSelectionEvent");
		 
    }

    /**
     * Returns true if the path identified by <code>index</code> was added to
     * the selection. A return value of false means the path was in the
     * selection but is no longer in the selection. This will raise if
     * index < 0 || >= <code>getPaths</code>.length.
     *
     * @since 1.3
     */
    public function isAddedPathOfIndex(index:Int):Bool{
		if (paths == null || index < 0 || index >= paths.length) {
		    throw new Error("index is beyond range of added paths identified by TreeSelectionEvent");
		}
		return areNew[index]==true;
    }

    /**
     * Returns the path that was previously the lead path.
     */
    public function getOldLeadSelectionPath():TreePath {
		return oldLeadSelectionPath;
    }

    /**
     * Returns the current lead path.
     */
    public function getNewLeadSelectionPath():TreePath {
		return newLeadSelectionPath;
    }

    /**
     * Returns a copy of the receiver, but with the source being newSource.
     */
    public function cloneWithSource(newSource:Dynamic):TreeSelectionEvent {
		return new TreeSelectionEvent(newSource, isProgrammatic(), paths, areNew, oldLeadSelectionPath, newLeadSelectionPath);
    }
    
    override public function clone():Event{
    	return new TreeSelectionEvent(source, isProgrammatic(), paths, areNew, oldLeadSelectionPath, newLeadSelectionPath);
    }
}