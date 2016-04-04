/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;
 

import org.aswing.tree.TreePath;

/**
 * Encapsulates information describing changes to a tree model, and
 * used to notify tree model listeners of the change.
 * 
 * @author paling
 */
class TreeModelEvent extends ModelEvent {
	
    /** Path to the parent of the nodes that have changed. */
    private var path:TreePath;
    /** Indices identifying the position of where the children were. */
    private var childIndices:Array<Dynamic>;
    /** Children that have been removed. */
    private var children:Array<Dynamic>;
    
    /**
     * TreeModelEvent(source:Object, path:TreePath, childIndices:Array, children:Array)<br>
     * TreeModelEvent(source:Object, path:Array, childIndices:Array, children:Array)<br>
     * Used to create an event when nodes have been changed, inserted, or
     * removed, identifying the path to the parent of the modified items as
     * an array of Objects. All of the modified objects are siblings which are
     * direct descendents (not grandchildren) of the specified parent.
     * The positions at which the inserts, deletes, or changes occurred are
     * specified by an array of <code>int</code>. The indexes in that array
     * must be in order, from lowest to highest.
     * <p>
     * For changes, the indexes in the model correspond exactly to the indexes
     * of items currently displayed in the UI. As a result, it is not really
     * critical if the indexes are not in their exact order. But after multiple
     * inserts or deletes, the items currently in the UI no longer correspond
     * to the items in the model. It is therefore critical to specify the
     * indexes properly for inserts and deletes.
     * <p>
     * For inserts, the indexes represent the <i>final</i> state of the tree,
     * after the inserts have occurred. Since the indexes must be specified in
     * order, the most natural processing methodology is to do the inserts
     * starting at the lowest index and working towards the highest. Accumulate
     * a Vector of <code>Integer</code> objects that specify the
     * insert-locations as you go, then convert the Vector to an
     * array of <code>int</code> to create the event. When the postition-index
     * equals zero, the node is inserted at the beginning of the list. When the
     * position index equals the size of the list, the node is "inserted" at
     * (appended to) the end of the list.
     * <p>
     * For deletes, the indexes represent the <i>initial</i> state of the tree,
     * before the deletes have occurred. Since the indexes must be specified in
     * order, the most natural processing methodology is to use a delete-counter.
     * Start by initializing the counter to zero and start work through the
     * list from lowest to higest. Every time you do a delete, add the current
     * value of the delete-counter to the index-position where the delete occurred,
     * and append the result to a Vector of delete-locations, using
     * <code>addElement()</code>. Then increment the delete-counter. The index
     * positions stored in the Vector therefore reflect the effects of all previous
     * deletes, so they represent each object's position in the initial tree.
     * (You could also start at the highest index and working back towards the
     * lowest, accumulating a Vector of delete-locations as you go using the
     * <code>insertElementAt(Integer, 0)</code>.) However you produce the Vector
     * of initial-positions, you then need to convert the Vector of <code>Integer</code>
     * objects to an array of <code>int</code> to create the event.
     * <p>
     * <b>Notes:</b><ul>
     * <li>Like the <code>insertNodeInto</code> method in the
     *    <code>DefaultTreeModel</code> class, <code>insertElementAt</code>
     *    appends to the <code>Vector</code> when the index matches the size
     *    of the vector. So you can use <code>insertElementAt(Integer, 0)</code>
     *    even when the vector is empty.
     * <ul>To create a node changed event for the root node, specify the parent
     *     and the child indices as <code>null</code>.
     * </ul>
     *
     * @param source the Object responsible for generating the event (typically
     *               the creator of the event object passes <code>this</code>
     *               for its value)
     * @param path   a TreePath object or a object[] that identifies the path to the
     *               parent of the modified item(s)
     * @param childIndices an array of <code>int</code> that specifies the
     *               index values of the modified items
     * @param children an array of Object containing the inserted, removed, or
     *                 changed objects
     */
    public function new(source:Dynamic, path:TreePath, childIndices:Array<Dynamic>=null,
			  children:Array<Dynamic>=null)
    {
		super(source);
		this.path = path;
		this.childIndices = childIndices;
		this.children = children;
    }
    
    /**
     * For all events, except treeStructureChanged,
     * returns the parent of the changed nodes.
     * For treeStructureChanged events, returns the ancestor of the
     * structure that has changed. This and
     * <code>getChildIndices</code> are used to get a list of the effected
     * nodes.
     * <p>
     * The one exception to this is a treeNodesChanged event that is to
     * identify the root, in which case this will return the root
     * and <code>getChildIndices</code> will return null.
     *
     * @return the TreePath used in identifying the changed nodes.
     * @see TreePath#getLastPathComponent
     */
    public function getTreePath():TreePath{ 
    	return path; 
    }

    /**
     * Convenience method to get the array of objects from the TreePath
     * instance that this event wraps.
     *
     * @return an array of Objects, where the first Object is the one
     *         stored at the root and the last object is the one
     *         stored at the node identified by the path
     */
    public function getPath():Array<Dynamic>{
		if(path != null)
		    return path.getPath();
		return null;
    }

    /**
     * Returns the objects that are children of the node identified by
     * <code>getPath</code> at the locations specified by
     * <code>getChildIndices</code>. If this is a removal event the
     * returned objects are no longer children of the parent node.
     *
     * @return an array of Object containing the children specified by
     *         the event
     * @see #getPath
     * @see #getChildIndices
     */
    public function getChildren():Array<Dynamic>{
		if(children != null) {
		    return children.copy();
		}
		return null;
    }

    /**
     * Returns the values of the child indexes. If this is a removal event
     * the indexes point to locations in the initial list where items
     * were removed. If it is an insert, the indices point to locations
     * in the final list where the items were added. For node changes,
     * the indices point to the locations of the modified nodes.
     *
     * @return an array of <code>int</code> containing index locations for
     *         the children specified by the event
     */
    public function getChildIndices():Array<Dynamic>{
		if(childIndices != null) {
		    return childIndices.copy();
		}
		return null;
    }
    
    public function toString():String{
    	return "TreeModelEvent[Path:" + getPath() + ", childIndices:"+childIndices + ", children:" + children+"]";
    }
}